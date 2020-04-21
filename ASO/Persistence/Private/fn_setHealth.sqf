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

// Only deal dammage if neccessary to avoid blood stains on the floor
_head = _hitpointDamage select 2;
_body = _hitpointDamage select 7;
_leftArm = _hitpointDamage select 12;
_rightArm = _hitpointDamage select 13;
_leftLeg = _hitpointDamage select 14;
_rightLeg = _hitpointDamage select 15;
_damageArray = [[_head, "Head"], [_body, "Body"], [_leftArm, "LeftArm"], [_rightArm, "RightArm"], [_leftLeg, "LeftLeg"], [_rightLeg, "RightLeg"]];

if (typeName _ifIsDead == "BOOL" && !_isAlive) then
{
	if (_ifIsDead) then
	{
		_unit setDamage [1, true]; // Unit is Dead
	}
	else
	{
		{
			_damage = (_x select 0);
			if (_damage >= 0.1) then 
			{
				[_unit, ((_x select 0)/2), (_x select 1)] call ace_medical_fnc_addDamageToUnit;				
			};
		} forEach _damageArray;

		_unit setVariable ["ace_medical_morphine", _morphine, true];
		_unit setVariable ["ace_medical_tourniquets", _tourniquets, true];
	};
};
if (_isAlive) then
{
	// Apply variables
	[_unit, _isUnconscious] call ace_medical_fnc_setUnconscious;
	// Handling damage
	{
			_damage = (_x select 0);
			if (_damage >= 0.1) then 
			{
				[_unit, ((_x select 0)), (_x select 1)] call ace_medical_fnc_addDamageToUnit;				
			};
		} forEach _damageArray;

	_unit setVariable ["ace_medical_morphine", _morphine, true];
	_unit setVariable ["ace_medical_tourniquets", _tourniquets, true];
};
true;