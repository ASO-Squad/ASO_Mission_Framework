/* ----------------------------------------------------------------------------
Description:
    A function for a group to attack a AOI. 

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be reinforced, should be a circle
    _task       - task given, once the group is close enough

Returns:
    None

Example:
    [myGroup, myTrigger, _task] call aso_fnc_reinforce

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger", "_task"];
// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// add some safety distance
_radius = _radius * 1.5;

// Reinforcments may arrive from far away so we have to make sure they can move
_group enableDynamicSimulation false; 

// Cleanup for immediate reaction
[_group] call CBA_fnc_clearWaypoints;

// Do only try to get in when there is supposed to be a vehicle
_type = [_group] call aso_fnc_getGroupType;
if (_type == "MOBILE") then 
{
    // Create a waypoint to move into a vehicle if possible
    [_group, (getPos leader _group), 0, "GETIN", "SAFE", "YELLOW", "NORMAL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

    // Create a waypoint to unload transport
    [_group, (getPos _trigger), 0, "UNLOAD", "SAFE", "YELLOW", "NORMAL", "STAG COLUMN", "", [0,0,0], _radius] call CBA_fnc_addWaypoint;
};

// Calling CBA_fnc_Attack
[_group, _trigger, _radius, false] call CBA_fnc_taskAttack;
[_group, "AWARE", "NORMAL", 60] spawn aso_fnc_delayedBehaviourChange;

// Tracking orders
_group setVariable ["ASO_ORDERS", ["ATTACK", _trigger], true];

// Show Debug Output
["New task ATTACK for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;