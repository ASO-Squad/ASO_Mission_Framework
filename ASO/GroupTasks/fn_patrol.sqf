/* ----------------------------------------------------------------------------
Description:
    A function for a group to patrol a area defined by a trigger

Parameters:
    _group      - the group patroling the area
    _trigger   	- trigger that is to be patroled, should be a circle

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_patrol

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger"];
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Calling CBA_fnc_taskPatrol
[_group, _trigger, _radius, 10, "MOVE", "SAFE", "YELLOW", "LIMITED", "FILE", "", [0,3,10]] call CBA_fnc_taskPatrol;

// Show Debug Output
["New task PATROL for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;