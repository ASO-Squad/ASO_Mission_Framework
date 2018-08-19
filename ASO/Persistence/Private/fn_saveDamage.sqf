/* ----------------------------------------------------------------------------
Description:
    Saves the damage of the given vehicle, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _vehicle		- The vehicle that we want to track
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_vehicle, _prefix] call aso_fnc_saveDamage;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_vehicle", "_prefix"];

// Use the appropriate name for the database 
_db = [_vehicle, true] call aso_fnc_getDbName;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Damage"] call _inidbi; // cleanup

// Variables
_allDamages = getAllHitPointsDamage _vehicle;
_hitpoints = [];
_damages = [];
if ((count _allDamages) > 0) then
{
    _hitpoints = (_allDamages select 0);
    _damages = (_allDamages select 2); 
};
_damage = damage _vehicle;

// Write information down
["write", ["Damage", "Hitpoints", _hitpoints]] call _inidbi;
["write", ["Damage", "Damages", _damages]] call _inidbi;
["write", ["Damage", "Damage", _damage]] call _inidbi;