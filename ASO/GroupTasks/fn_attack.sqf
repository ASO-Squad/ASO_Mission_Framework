/* ----------------------------------------------------------------------------
Description:
    A function for a group to attack a AOI. 

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_attack

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger"];
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Calling CBA_fnc_taskDefend
[_group, _trigger, _radius, true] call CBA_fnc_taskAttack;

// Tracking orders
_group setVariable ["ASO_ORDERS", ["ATTACK", _trigger], true];

// Show Debug Output
["New task ATTACK for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;