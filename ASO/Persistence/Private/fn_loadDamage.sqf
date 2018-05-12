/* ----------------------------------------------------------------------------
Description:
    Loads the damage of the given vehicle, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _vehicle		- The vehicle that we want to load
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_vehicle, _prefix] call aso_fnc_loadDamage;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_vehicle", "_prefix"];

// Check if the explosives got already loaded
if (_vehicle getVariable ["ASO_P_Damage", false]) exitWith {};

// Use the appropriate name for the database 
_db = [_vehicle, true] call aso_fnc_getDbName;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};
// Load information
_hitpoints = ["read", ["Damage", "Hitpoints"]] call _inidbi;
_damages = ["read", ["Damage", "Damages"]] call _inidbi;
_damage = ["read", ["Damage", "Damage"]] call _inidbi;
// Apply dammage
if (typeName _hitpoints != "ARRAY") exitWith {};
// This vehicle is most probably already burnt down
_vehicle setVariable ["ace_cookoff_enable", false, true];
_vehicle setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
_vehicle setDamage [_damage, false];
if (local _vehicle) then
{
	{
        _vehicle setHitPointDamage [_x, (_damages select _forEachIndex), true];
    } forEach _hitpoints;
}
else
{
    {
        [_x, (_damages select _forEachIndex), false] remoteExec ["setHitPointDamage", _x, false]; // setHitPointDamage needs local parameters  
    } forEach _hitpoints;
};
if (alive _vehicle) then 
{
    _vehicle setVariable ["ace_cookoff_enable", true, true];
    _vehicle setVariable ["ace_cookoff_enableAmmoCookoff", true, true];
};
_vehicle setVariable ["ASO_P_Damage", true, true];