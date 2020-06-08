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
private _bodypartdamage = _unit getVariable ["ace_medical_bodypartdamage", [0,0,0,0,0,0]];
private _openWounds = _unit getVariable ["ace_medical_openwounds", []];
private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];
private _isAlive = alive _unit;

// only unpatched wounds are saved
{
    if ((_x select 2) == 0) then
    {
       _bodypartdamage set [(_x select 1), 0];
    };
    
} forEach _openWounds;

[_morphine, _tourniquets, _bodypartdamage, _isUnconscious, _isAlive];