/* ----------------------------------------------------------------------------
Description:
    Loads the health of the given unit, and does this with INIDBI2.
	Files are read on the server machine.

Parameters:
    _unit			- The unit that we want to track the health of
	_health			- The health array
	_ifIsDead		- What to do if the unit is dead.
					If this is an object, the unit will be transported there
					If it is a bool: true  means, it will stay dead.
									 false means, the unit will wake up with half its previous damage.

Returns:
    nothing

Example:
    [_unit, _health] call aso_fnc_setHealth;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_health", ["_ifIsDead", false]];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Read information
_morphine = _health select 0;
_tourniquets = _health select 1;
_hitpointDamage = _health select 2;
_isUnconscious = _health select 3;
_isAlive = _health select 4;

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
		[_unit, ((_hitpointDamage select 2)/2), "Head"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 7)/2), "Body"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 12)/2), "LeftArm"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 13)/2), "RightArm"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 14)/2), "LeftLeg"] call ace_medical_fnc_addDamageToUnit;
		[_unit, ((_hitpointDamage select 15)/2), "RightLeg"] call ace_medical_fnc_addDamageToUnit;

		_unit setVariable ["ace_medical_morphine", _morphine, true];
		_unit setVariable ["ace_medical_tourniquets", _tourniquets, true];
	};
};
if (_isAlive) then
{
	// Apply variables
	[_unit, _isUnconscious] call ace_medical_fnc_setUnconscious;
	// Handling damage
	[_unit, _hitpointDamage select 2, "Head"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 7, "Body"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 12, "LeftArm"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 13, "RightArm"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 14, "LeftLeg"] call ace_medical_fnc_addDamageToUnit;
	[_unit, _hitpointDamage select 15, "RightLeg"] call ace_medical_fnc_addDamageToUnit;

	_unit setVariable ["ace_medical_morphine", _morphine, true];
	_unit setVariable ["ace_medical_tourniquets", _tourniquets, true];
};
true;