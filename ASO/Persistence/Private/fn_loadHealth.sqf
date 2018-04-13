/* ----------------------------------------------------------------------------
Description:
    Loads the health of the given unit, and does this with INIDBI2.
	Files are read on the server machine.

Parameters:
    _unit			- The unit that we want to track the health of
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_loadHealth;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_saveByName", "_prefix"];

// Check if the health got already loaded
if (_unit getVariable ["ASO_P_Health", false]) exitWith {};

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Use the appropriate name for the database 
_db = "";
if (_saveByName) then 
{
	_db = vehicleVarName _unit;
}
else
{
	_uid = getPlayerUID _unit;
	if (_uid == "") then
	{
		_db = vehicleVarName _unit; // Fallback if the unit is not a player
	}
	else
	{
		_db = _uid;
	};
};
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;

// Write information down
_isUnconscious = ["read", ["Health", "IsUnconscious"]] call _inidbi;
_hitpointDamage = ["read", ["Health", "Damage"]] call _inidbi;
_morphine = ["read", ["Health", "Morphine"]] call _inidbi;
_tourniquets = ["read", ["Health", "Tourniquets"]] call _inidbi;

// Apply variables
[_unit, _isUnconscious] call ace_medical_fnc_setUnconscious;
// Handling damage
[_unit, _hitpointDamage select 2, "head", "bullet"] call ace_medical_fnc_addDamageToUnit;
[_unit, _hitpointDamage select 7, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
[_unit, _hitpointDamage select 12, "hand_l", "bullet"] call ace_medical_fnc_addDamageToUnit;
[_unit, _hitpointDamage select 13, "hand_r", "bullet"] call ace_medical_fnc_addDamageToUnit;
[_unit, _hitpointDamage select 14, "leg_l", "bullet"] call ace_medical_fnc_addDamageToUnit;
[_unit, _hitpointDamage select 15, "leg_r", "bullet"] call ace_medical_fnc_addDamageToUnit;

_unit setVariable ["ace_medical_morphine", _morphine];
_unit setVariable ["ace_medical_tourniquets", _tourniquets];
_unit setVariable ["ASO_P_Health", true, true];