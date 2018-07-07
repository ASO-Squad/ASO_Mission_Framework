/* ----------------------------------------------------------------------------
Description:
    Loads the health of the given unit, and does this with INIDBI2.
	Files are read on the server machine.

Parameters:
    _unit			- The unit that we want to track the health of
	_loadByName		- If true, we are saving this by the units name, otherwise it is loaded by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
	_ifIsDead		- What to do if the unit is dead.
					If this is an object, the unit will be transported there
					If it is a bool: true  means, it will stay dead.
									 false means, the unit will wke up with half its previous damage.

Returns:
    nothing

Example:
    [_unit, false, _prefix, _ifIsDead] call aso_fnc_loadHealth;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_loadByName", "_prefix", "_ifIsDead"];

// Check if the health got already loaded
if (_unit getVariable ["ASO_P_Health", false]) exitWith {};

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Use the appropriate name for the database 
_db = [_unit, _loadByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;

// Check if there is something to load
if (!("exists" call _inidbi)) exitWith {};

// Read information
_isAlive = ["read", ["Health", "IsAlive"]] call _inidbi;
_isUnconscious = ["read", ["Health", "IsUnconscious"]] call _inidbi;
_hitpointDamage = ["read", ["Health", "Damage"]] call _inidbi;
_morphine = ["read", ["Health", "Morphine"]] call _inidbi;
_tourniquets = ["read", ["Health", "Tourniquets"]] call _inidbi;

if (typeName _ifIsDead == "OBJECT" && !_isAlive) then
{
	_unit setVehiclePosition [(getPosATL _ifIsDead), [], 5, "NONE"];
};
if (typeName _ifIsDead == "BOOL" && !_isAlive) then
{
	if (_ifIsDead) then
	{
		_unit setDamage [1, true]; // Unit is Dead
	}
	else
	{
		// Apply variables
		[_unit, true] call ace_medical_fnc_setUnconscious;
		// Ease the pain
		[_unit, ((_hitpointDamage select 2)/2), "head", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 7)/2), "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 12)/2), "hand_l", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 13)/2), "hand_r", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 14)/2), "leg_l", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 15)/2), "leg_r", "bullet"] call ace_medical_fnc_addDamageToUnit;

		_unit setVariable ["ace_medical_morphine", _morphine, true];
		_unit setVariable ["ace_medical_tourniquets", _tourniquets, true];
	};
};
if (_isAlive) then
{
	// Apply variables
	[_unit, _isUnconscious] call ace_medical_fnc_setUnconscious;
	// Handling damage
	[_unit, _hitpointDamage select 2, "head", "bullet"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 7, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 12, "hand_l", "bullet"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 13, "hand_r", "bullet"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 14, "leg_l", "bullet"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 15, "leg_r", "bullet"] call ace_medical_fnc_addDamageToUnit;

	_unit setVariable ["ace_medical_morphine", _morphine, true];
	_unit setVariable ["ace_medical_tourniquets", _tourniquets, true];
};
_unit setVariable ["ASO_P_Health", true, true];
