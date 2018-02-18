/* ----------------------------------------------------------------------------
Description:
    A function for a group to attack a AOI. 

Parameters:
    _group      - the group attacking the area
    _trigger   	- trigger that is to be attacked, should be a circle

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_attack

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger"];
// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Attacks may arrive from far away so we have to make sure they can move
_group enableDynamicSimulation false; 

[_group] call CBA_fnc_clearWaypoints;
[_group, (getPos leader _group), 0, "MOVE", "AWARE", "YELLOW", "NORMAL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

// Calling CBA_fnc_Attack
[_group, _trigger, _radius, false] call CBA_fnc_taskAttack;
[_group, "AWARE", "NORMAL", 60] spawn aso_fnc_delayedBehaviourChange;

// Tracking orders
_group setVariable ["ASO_ORDERS", ["ATTACK", _trigger], true];

// Show Debug Output
["New task ATTACK for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;
// A attacking group need to move!
_group enableDynamicSimulation false; 
//[_group, 60] spawn aso_fnc_enableDynamicSim;