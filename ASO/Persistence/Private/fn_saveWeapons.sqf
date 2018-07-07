/* ----------------------------------------------------------------------------
Description:
    Saves the weapons and ammo of the given vehicle, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _vehicle		- The vehicle that we want to track
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_vehicle, _prefix] call aso_fnc_saveWeapons;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_vehicle", "_prefix"];

// Use the appropriate name for the database 
_db = [_vehicle, true] call aso_fnc_getDbName;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Weapons"] call _inidbi; // cleanup

// Variables
_mags = magazinesAllTurrets _vehicle;
// Just save data we needReload
_magazines = [];
{
    _magazines pushBack [(_x select 0), (_x select 1), (_x select 2)];    
} forEach _mags;

// Write information down
["write", ["Weapons", "Magazines", _magazines]] call _inidbi;