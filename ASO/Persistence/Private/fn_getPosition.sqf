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
private _position = getPosATL _unit;
private _direction = getDir _unit;
private _stance = stance _unit;
private _action = "";

switch (_stance) do 
{
    case "STAND": { _action = "PlayerStand" };
    case "CROUCH": { _action = "PlayerCrouch" };
    case "PRONE": { _action = "PlayerProne" };
    default { _action = "PlayerCrouch" };
};

[_position, _direction, _stance];