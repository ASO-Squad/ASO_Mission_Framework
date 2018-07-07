/* ----------------------------------------------------------------------------
Description:
    Saves the health of the given unit, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _unit			- The unit that we want to track the health of
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_saveHealth;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_saveByName", "_prefix"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Use the appropriate name for the database 
_db = [_unit, _saveByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Health"] call _inidbi; // cleanup

// Variables
_morphine = _unit getVariable ["ace_medical_morphine", 0];
_tourniquets = _unit getVariable ["ace_medical_tourniquets", [0,0,0,0,0,0]];
_hitpointDamage = ((getAllHitPointsDamage _unit) select 2); 
_isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
_isAlive = alive _unit;

// Write information down
["write", ["Health", "IsAlive", _isAlive]] call _inidbi;
["write", ["Health", "IsUnconscious", _isUnconscious]] call _inidbi;
["write", ["Health", "Damage", _hitpointDamage]] call _inidbi;
["write", ["Health", "Morphine", _morphine]] call _inidbi;
["write", ["Health", "Tourniquets", _tourniquets]] call _inidbi;