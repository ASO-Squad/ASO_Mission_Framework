/* ----------------------------------------------------------------------------
Description:
    A function for a group to patrol a area defined by a trigger

Parameters:
    _group      - the group patroling the area
    _trigger   	- trigger that is to be patroled, should be a circle
    _type       - What kind of unit is this. Possible values are:
                "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_patrol

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger", "_type"];
// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Calling CBA_fnc_taskPatrol
[_group, _trigger, _radius, 10, "MOVE", "SAFE", "YELLOW", "LIMITED", "FILE", "", [0,3,10]] call CBA_fnc_taskPatrol;

// Adding this group the the AOI
[_group, _trigger] spawn aso_fnc_addGroupToAOI;

// Tracking Orders
_group setVariable ["ASO_ORDERS", ["PATROL", _trigger], true];
_group setVariable ["ASO_HOME", _trigger, true]; // Set new homebase
_group setVariable ["ASO_TYPE", _type, true];

// Show Debug Output
["New task PATROL for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;
// Give this Group a little time to move around
[_group, 300] spawn aso_fnc_enableDynamicSim;