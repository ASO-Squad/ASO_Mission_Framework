/* ----------------------------------------------------------------------------
Description:
    Gets the health of the given unit.

Parameters:
    _unit			- The unit that we want to track the health of

Returns:
    health array

Example:
    [_unit] call aso_fnc_getHealth;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_saveByName", "_prefix"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Variables
private _morphine = _unit getVariable ["ace_medical_morphine", 0];
private _tourniquets = _unit getVariable ["ace_medical_tourniquets", [0,0,0,0,0,0]];
private _hitpointDamage = ((getAllHitPointsDamage _unit) select 2); 
private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
private _isAlive = alive _unit;

[_morphine, _tourniquets, _hitpointDamage, _isUnconscious, _isAlive];