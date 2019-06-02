/* ----------------------------------------------------------------------------
Description:
    A function for a group to attack a AOI. 

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be reinforced, should be a circle
    _orders     - task to complete
    _completion - Completion radius for waypoints 
    _fromDB     - Avoid loading orders, useful if this function is already called by loading an order

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_reinforce

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", "_trigger", "_orders", ["_completion", 20], ["_fromDB", true]];
private ["_orders", "_default"];

// Keep this group in mind for saving
[_group] call aso_fnc_collectGroup;

// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// add some safety distance
_radius = _radius * 1.5;

// Load previous state, if desired
// true is, in this case a safe default, because we check for the presence of aso_orders later
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
_lodadedOrders = -1;
if (_load == 1 && _fromDB) then
{
    ["Loading Orders for:", groupId _group] call aso_fnc_debug;    
    [[_group], ASO_PREFIX] call aso_fnc_executeLoadOrders;
    // Make sure we loaded some orders
    _lodadedOrders = _group getVariable ["aso_orders", false];
    _default = false;
};
if (typeName _lodadedOrders == "ARRAY") then
{
    _order = (_lodadedOrders select 0);
    _target = (_lodadedOrders select 1);
    // Putting this group to AOI
    [_group, _trigger] spawn aso_fnc_addGroupToAOI;
    switch (_order) do 
    {
        case "ATTACK": { _trigger = _target; _default = true; };
        case "SEARCH": { [_group, _target, false] call aso_fnc_search; };
        case "PATROL": { [_group, _target, false] call aso_fnc_patrol; };
        case "GUARD":  { [_group, _target, false, _type, false] call aso_fnc_guard };
        default { _default = true; };
    };
}
else
{
    _default = true;
};
if (_default) then
{
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
        // Attack
        switch (_orders) do 
        {
            case "ATTACK": {  [_group, _trigger, (_radius/3), "SAD", "AWARE", "RED", "FULL", "STAG COLUMN", "", [0,0,0], _completion] call CBA_fnc_addWaypoint; };
            case "SEARCH": { [_group, _target, false] call aso_fnc_search; };
            case "PATROL": { [_group, _target, false] call aso_fnc_patrol; };
            case "GUARD":  { [_group, _target, false, _type, false] call aso_fnc_guard };
            default {  [_group, _trigger, (_radius/3), "SAD", "AWARE", "RED", "FULL", "STAG COLUMN", "", [0,0,0], _completion] call CBA_fnc_addWaypoint; };
        };
        [_group, "AWARE", "NORMAL", 60] spawn aso_fnc_delayedBehaviourChange;
    }
    else
    {
        // delete all previous waypoints
        while {(count (waypoints _group)) > 0} do
        {
            deleteWaypoint ((waypoints _group) select 0);
        };
        switch (_orders) do 
        {
            case "ATTACK": { [_group, _trigger, (_radius/2.5), "SAD", "AWARE", "RED", "FULL", "STAG COLUMN", "", [0,0,0], _completion] call CBA_fnc_addWaypoint; };
            case "SEARCH": { [_group, _target, false] call aso_fnc_search; };
            case "PATROL": { [_group, _target, false] call aso_fnc_patrol; };
            case "GUARD":  { [_group, _target, false, _type, false] call aso_fnc_guard };
            default { [_group, _trigger, (_radius/2.5), "SAD", "AWARE", "RED", "FULL", "STAG COLUMN", "", [0,0,0], _completion] call CBA_fnc_addWaypoint; };
        };
    };
    [_group, "AWARE", "NORMAL", 60] spawn aso_fnc_delayedBehaviourChange;

    // Tracking orders
    _group setVariable ["ASO_ORDERS", [_orders, _trigger], true];

    // Show Debug Output
    ["New task REINFORCE for", groupId _group] call aso_fnc_debug;
    [_group] spawn aso_fnc_trackGroup;
};