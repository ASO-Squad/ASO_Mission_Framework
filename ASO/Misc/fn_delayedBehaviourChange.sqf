/* ----------------------------------------------------------------------------
Description:
    A little helper that puts a delay on the intended behaviour change.

Parameters:
    _group      - The group that we want change the behaviour of
    _behaviour  - The behaviour the group changes to
    _speed      - speedMode change
    _time       - Wat this amount of time befor executing 

Returns:
    None

Example:
    [_group, "AWARE", "NORMAL", 60] spawn aso_fnc_delayedBehaviourChange;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_behaviour", "_speed", "_time"];

if (!canSuspend) exitWith {_group setBehaviour _behaviour; _group setSpeedMode _speed;};

sleep _time;
_group setBehaviour _behaviour;
_group setSpeedMode _speed;
