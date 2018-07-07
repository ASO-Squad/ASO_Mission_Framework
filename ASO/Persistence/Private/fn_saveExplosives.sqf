/* ----------------------------------------------------------------------------
Description:
    Saves all actived ACE explosives associated with this unit.
	ACE cellphone triggers and BI mines are not supported

Parameters:
    _unit			- The unit that we want to track
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_saveExplosives;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_saveByName", "_prefix"];

// Use the appropriate name for the database 
_db = [_unit, _saveByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Explosives"] call _inidbi; // cleanup

// Variables
_exp = [_unit] call ACE_Explosives_fnc_getPlacedExplosives;
_explosives = [];
{
	_position = getPosATL (_x select 0);
	_direction = getDir (_x select 0);
	_class = typeOf (_x select 0);
	_detonator = (_x select 4);
	_clackerClass = (_x select 3);
	_explosives pushBack [_position, _direction, _class, _detonator, _clackerClass];
} forEach _exp;

// Write information down
["write", ["Explosives", "Array", _explosives]] call _inidbi;