/* ----------------------------------------------------------------------------
Description:
    Gets the in-game position of the specified entity

Parameters:
    _unit			- The unit that we want to keep the inventory of

Returns:
    nothing

Example:
    [_unit] call aso_fnc_getPosition;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit"];

// Variables
_position = getPosATL _unit;
_direction = getDir _unit;
_stance = stance _unit;

[_position, _direction, _stance];