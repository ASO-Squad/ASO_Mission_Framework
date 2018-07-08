/* ----------------------------------------------------------------------------
Description:
    A function for a group to guard an AOI. They allways protect their AOI and should never leave it.

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle
    _hold       - chance for each unit to hold their garrison in combat
    _type       - What kind of unit is this. Possible values are:
                "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"
    _fromDB   - Avoid loading orders, useful if this function is already called by loading an order

Returns:
    None

Example:
    [myGroup, myTrigger, true, "INFANTRY"] call aso_fnc_guard

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", "_trigger", "_hold", "_type", ["_fromDB", true]];
private ["_orders", "_default"];

// Keep this group in mind for saving
[_group] call aso_fnc_collectGroup;

// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

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
        case "SEARCH": { [_group, _target, false] call aso_fnc_search; };
        case "PATROL": { [_group, _target, false] call aso_fnc_patrol; };
        case "GUARD":  { _trigger = _target; _default = true; };
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
        [_group, _trigger, "GUARD"] spawn aso_fnc_addGroupToAOIReinforcements;
    }
    else
    {
        // Only infantry switch to defense mode, other types mount their vehicles and stay where they are
        if (_type == "INFANTRY") then 
        {
            // Calling CBA_fnc_taskDefend
            [_group, _trigger, _radius, 2, 0, _hold] call CBA_fnc_taskDefend;
        }
        else
        {
            // Create a waypoint to move into a vehicle if possible
            [_group, (getPos leader _group), 0, "GETIN", "SAFE", "YELLOW", "NORMAL", "FILE"] call CBA_fnc_addWaypoint;
        };

        // Adding this group the the AOI
        [_group, _trigger] spawn aso_fnc_addGroupToAOI;

        // Tracking Orders
        _group setVariable ["ASO_ORDERS", ["GUARD", _trigger], true];
        _group setVariable ["ASO_HOME", _trigger, true]; // Set new homebase
        _group setVariable ["ASO_TYPE", _type, true];

        // Show Debug Output
        ["New task GUARD for", groupId _group] call aso_fnc_debug;
        [_group, 60] spawn aso_fnc_enableDynamicSim;
    };
};
[_group] spawn aso_fnc_trackGroup;
