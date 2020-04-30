/* ----------------------------------------------------------------------------
Description:
    Sets the weapons and ammo of the given vehicle.

Parameters:
    _vehicle		- The vehicle that we want to load
	_weapons		- The ammo array

Returns:
    nothing

Example:
    [_vehicle, _weapons] call aso_fnc_setWeapons;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_vehicle", "_weapons"];

if (([_weapons] call aso_fnc_isReadError)) exitWith {false;}; 

// Load information
private _magazines = _weapons;
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

true;