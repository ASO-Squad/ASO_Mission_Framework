/* ----------------------------------------------------------------------------
Description:
    Returns the defined type of a group

Parameters:
    _group      - The group that we want to know stuff about
    _behaviour  - The bahviour the group changes to
    _speed      - speedMode change
    _time       - Wat this amount of time befor executing 

Returns:
    nothing

Example:
    [_group, "AWARE", "NORMAL", 60] spawn aso_fnc_delayedBahviourChange;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_behaviour", "_speed", "_time"];

if (!canSuspend) exitWith {_group setBehaviour _behaviour; _group setSpeedMode _speed;};

sleep _time;
_group setBehaviour _behaviour;
_group setSpeedMode _speed;
