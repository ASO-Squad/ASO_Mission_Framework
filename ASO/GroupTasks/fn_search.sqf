/* ----------------------------------------------------------------------------
Description:
    A function for a group to search an AOI. 

Parameters:
    _group      - the group searching the area
    _trigger   	- trigger that is to be searched, should be a circle
    _fromDB   - Avoid loading orders, useful if this function is already called by loading an order

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_search

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", "_trigger", ["_fromDB", true]];
private ["_orders", "_default"];

// Keep this group in mind for saving
[_group] call aso_fnc_collectGroup;

// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};

// Load previous state, if desired
// true is, in this case a safe default, because we check for the presence of aso_orders later
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
_orders = -1;
if (_load == 1 && _fromDB) then
{
    ["Loading Orders for:", groupId _group] call aso_fnc_debug;    
    [[_group], ASO_PREFIX] call aso_fnc_executeLoadOrders;
    // Make sure we loaded some orders
    _orders = _group getVariable ["aso_orders", false];
    _default = false;
};
if (typeName _orders == "ARRAY") then
{
    _order = (_orders select 0);
    _target = (_orders select 1);
    // Putting this group to AOI
    [_group, _trigger] spawn aso_fnc_addGroupToAOI;
    switch (_order) do 
    {
        case "ATTACK": { [_group, _target, false] call aso_fnc_attack; };
        case "SEARCH": { _trigger = _target; _default = true;};
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
    // In case the new task is not at the units home, assume its reinforcements
    _home = _group getVariable ["aso_home", objNull];
    if (_home != _trigger && !isNull _home) then
    {
        [_group, _trigger, "SEARCH"] spawn aso_fnc_addGroupToAOIReinforcements;
    }
    else
    {
        [_group, _trigger] call CBA_fnc_taskSearchArea;
        // somehow there is a waypoint created on the original position. This is the workaround
        _wpCount = count (waypoints _group);
        if (_wpCount > 1) then
        {
            deleteWaypoint [_group, 0];
        };
        // Tracking Orders
        _group setVariable ["ASO_ORDERS", ["SEARCH", _trigger], true];

        // Show Debug Output
        ["New task SEARCH for", groupId _group] call aso_fnc_debug;
        [_group] spawn aso_fnc_trackGroup;
        // Give that group a little time to move
        [_group, 300] spawn aso_fnc_enableDynamicSim;
    };
};