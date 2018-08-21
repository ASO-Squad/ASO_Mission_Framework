/* ----------------------------------------------------------------------------
Description:
    A function for a group to patrol a area defined by a trigger

Parameters:
    _group      - the group patroling the area
    _trigger   	- trigger that is to be patroled, should be a circle
    _type       - What kind of unit is this. Possible values are:
                "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"
    _fromDB   - Avoid loading orders, useful if this function is already called by loading an order

Returns:
    None

Example:
    [myGroup, myTrigger, _type] call aso_fnc_patrol

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", "_trigger", "_type", ["_fromDB", true]];
private ["_orders", "_default"];

// Keep this group in mind for saving
[_group] call aso_fnc_collectGroup;

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
        case "SEARCH": { [_group, _target], false call aso_fnc_search; };
        case "PATROL": { _trigger = _target; _default = true; };
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
        [_group, _trigger, "PATROL"] spawn aso_fnc_addGroupToAOIReinforcements;
    }
    else
    {
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
        // Give this Group a little time to move around
        [_group, 300] spawn aso_fnc_enableDynamicSim;
    };
};

[_group] spawn aso_fnc_trackGroup;