/* ----------------------------------------------------------------------------
Description:
    A function for a group to defend a trigger. 
	A garrison might engage enemies far away and even be called to defend another trigger
    BE ADVISED: If a unit previously belonged to an AOI, it is still considered to be part of that AOI.

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle
    _type       - What kind of unit is this. Possible values are:
                "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"
    _loiter     - Move around the current position

Returns:
    None

Example:
    [myGroup, myTrigger, _type, _true] call aso_fnc_garrisonSimple

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger", "_type", "_loiter"];
// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Clear waypoints to make the group move immediately
[_group] call CBA_fnc_clearWaypoints;



// Do not use defend with anything else than infantry
// defending vehicles get stuck easily and wont move anywhere even with new waypoints
if (_type == "INFANTRY") then 
{
    if (_loiter) then 
    {
        // Move around
        [_group, (getPos leader _group), (_radius/4), 10, "MOVE", "SAFE", "YELLOW", "LIMITED", "FILE", "", [0,3,10]] call CBA_fnc_taskPatrol;
        // re-enable dynamic simulation, most of the time the group will go to sleep mid-way and continue its way if something gets close enough
        [_group, 60] spawn aso_fnc_enableDynamicSim;
    }
    else
    {
        [_group, (getPos leader _group), 0, "HOLD", "AWARE", "YELLOW", "LIMITED", "FILE", "group this enableDynamicSimulation true;"] call CBA_fnc_addWaypoint;
    };
}
else
{
    if (_loiter) then 
    {
        [_group,(getPos leader _group), (_radius), 10, "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [0,3,10]] call CBA_fnc_taskPatrol;
        // re-enable dynamic simulation, most of the time the group will go to sleep mid-way and continue its way if something gets close enough
        [_group, 60] spawn aso_fnc_enableDynamicSim;
    }
    else
    {
        // Create a waypoint to move into a vehicle if possible
        [_group, (getPos leader _group), 0, "GETIN", "SAFE", "YELLOW", "NORMAL", "STAG COLUMN"] call CBA_fnc_addWaypoint;
        // re-enable dynamic simulation, most of the time the group will go to sleep mid-way and continue its way if something gets close enough
        [_group, 60] spawn aso_fnc_enableDynamicSim;
    };
};

// Putting this group to AOI
[_group, _trigger] spawn aso_fnc_addGroupToAOI;

// Tracking Orders
_group setVariable ["ASO_ORDERS", ["GARRISON", _trigger], true];
_group setVariable ["ASO_HOME", _trigger, true]; // Set new homebase
_group setVariable ["ASO_TYPE", _type, true];

// Show Debug Output
["New task GARRISON for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;