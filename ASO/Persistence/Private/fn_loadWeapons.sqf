/* ----------------------------------------------------------------------------
Description:
    Loads the weapons and ammo of the given vehicle, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _vehicle		- The vehicle that we want to load
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_vehicle, _prefix] call aso_fnc_loadWeapons;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_vehicle", "_prefix"];

// Check if the explosives got already loaded
if (_vehicle getVariable ["ASO_P_Weapons", false]) exitWith {};

// Use the appropriate name for the database 
_db = [_vehicle, true] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};
// Load information
_magazines = ["read", ["Weapons", "Magazines"]] call _inidbi;
// Apply data
if (local _vehicle) then
{
	// Remove every Magazine
    {
        _vehicle removeMagazinesTurret [(_x select 0), (_x select 1)];
    } forEach _magazines;
    // Add old magazines
    {
        _vehicle addMagazineTurret [(_x select 0), (_x select 1), (_x select 2)]
    } forEach _magazines;
}
else
{
    // Remove every Magazine
    {
        [_vehicle, [(_x select 0), (_x select 1)]] remoteExec ["removeMagazinesTurret", _vehicle, false];// this needs local parameters
    } forEach _magazines;
    // Add old magazines
    {
        [_vehicle, [(_x select 0), (_x select 1), (_x select 2)]] remoteExec ["removeMagazinesTurret", _vehicle, false];// this needs local parameters
    } forEach _magazines;
};
_vehicle setVariable ["ASO_P_Weapons", true, true];