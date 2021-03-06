/* ----------------------------------------------------------------------------
Description:
    Sets the position for the given unit.

Parameters:
    _unit			- The unit that we want to load the position of
	_position		- A position array

Returns:
    nothing

Example:
    [_unit, _position] call aso_fnc_setPosition;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_unit", "_position"];

if (([_position] call aso_fnc_isReadError)) exitWith {false;}; 

// reading position
private _pos = _position select 0;
private _dir = _position select 1;
private _stance = _position select 2;

// Apply data
if (local _unit) then
{
	_unit setDir _dir;
	_unit playAction _stance;
	_unit setPosATL _pos;
}
else
{
	[_unit, _dir] remoteExec ["setDir", _unit, false];// setDir needs local parameters
	[_unit, _stance] remoteExec ["playAction", _unit, false];// playAction needs local parameters
	[_unit, _pos] remoteExec ["setPosATL", _unit, false];// this needs to be called remotly in case a player starts in a vehicle
};
_unit setPosATL _pos; // Position seems to be synced, so this call needs to be done on the server too
// Return the position to use it with other functions
_position;
