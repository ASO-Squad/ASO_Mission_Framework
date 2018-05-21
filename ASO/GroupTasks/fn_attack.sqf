/* ----------------------------------------------------------------------------
Description:
    A function for a group to attack an AOI. 

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

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", "_trigger"];

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
        case "ATTACK": { _trigger = _target; _default = true; };
        case "SEARCH": { [_group, _target] call aso_fnc_search; };
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
    // A attacking group needs to move!
    _group enableDynamicSimulation false; 
    //[_group, 60] spawn aso_fnc_enableDynamicSim;
};