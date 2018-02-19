/* ----------------------------------------------------------------------------
Description:
    A function for a group to defend a trigger.

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle
    _hold       - chance for each unit to hold their garrison in combat
    _type       - What kind of unit is this. Possible values are:
                "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"

Returns:
    None

Example:
    [myGroup, myTrigger, true] call aso_fnc_guard

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger", "_hold", "_type"];
// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Only infantry switch to defense mode, other types mount their vehicles and stay where they are
 if (_type == "INFANTRY") then 
{
    // Calling CBA_fnc_taskDefend
    [_group, _trigger, _radius, 2, 0, _hold] call CBA_fnc_taskDefend;
}
else
{
    // Create a waypoint to move into a vehicle if possible
    [_group, (getPos leader _group), 0, "GETIN", "SAFE", "YELLOW", "NORMAL", "STAG COLUMN"] call CBA_fnc_addWaypoint;
};

// Adding this group the the AOI
[_group, _trigger] spawn aso_fnc_addGroupToAOI;

// Tracking Orders
_group setVariable ["ASO_ORDERS", ["GUARD", _trigger], true];
_group setVariable ["ASO_HOME", _trigger, true]; // Set new homebase
_group setVariable ["ASO_TYPE", _type, true];

// Show Debug Output
["New task GUARD for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;
[_group, 60] spawn aso_fnc_enableDynamicSim;

