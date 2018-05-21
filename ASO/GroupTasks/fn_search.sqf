/* ----------------------------------------------------------------------------
Description:
    A function for a group to search an AOI. 

Parameters:
    _group      - the group searching the area
    _trigger   	- trigger that is to be searched, should be a circle

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

params ["_group", "_trigger"];

// Keep this group in mind for saving
[_group] call aso_fnc_collectGroup;

// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};

// Load previous state, if desired
// true is, in this case a safe default, because we check for the presence of aso_orders later
_load = ["LoadMission", 1] call BIS_fnc_getParamValue; 
if (_load == 1) then
{
    [[_group], ASO_PREFIX] call aso_fnc_executeLoadOrders;
};
// Make sure we loaded some orders
_orders = _group getVariable ["aso_orders", false];
_default = false;
if (typeName _orders == "ARRAY") then
{
    _order = (_orders select 0);
    _target = (_orders select 1);
    // Putting this group to AOI
    [_group, _trigger] spawn aso_fnc_addGroupToAOI;
    switch (_order) do 
    {
        case "ATTACK": { [_group, _target] call aso_fnc_attack; };
        case "SEARCH": { _trigger = _target; _default = true;};
        case "PATROL": { [_group, _target] call aso_fnc_patrol; };
        case "GUARD":  { [_group, _target, false, _type] call aso_fnc_guard };
        default { _default = true; };
    };
}
else
{
    _default = true;
};
if (_default) then
{
    // Calling CBA_fnc_taskDefend
    [_group, _trigger] call CBA_fnc_taskSearchArea;

    // Tracking Orders
    _group setVariable ["ASO_ORDERS", ["SEARCH", _trigger], true];

    // Show Debug Output
    ["New task SEARCH for", groupId _group] call aso_fnc_debug;
    [_group] spawn aso_fnc_trackGroup;
    // Give that group a little time to move
    [_group, 300] spawn aso_fnc_enableDynamicSim;
};