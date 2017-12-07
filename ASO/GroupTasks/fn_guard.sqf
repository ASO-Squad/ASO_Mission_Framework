/* ----------------------------------------------------------------------------
Description:
    A function for a group to defend a trigger.

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle
    _hold       - chance for each unit to hold their garrison in combat

Returns:
    None

Example:
    [myGroup, myTrigger, true] call aso_fnc_guard

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger", "_hold"];
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Calling CBA_fnc_taskDefend
[_group, _trigger, _radius, 2, 0, _hold] call CBA_fnc_taskDefend;

// Adding this group the the AOI
[_trigger, _group] spawn aso_fnc_addGroupToAOI;

// Show Debug Output
["New task GUARD for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;

