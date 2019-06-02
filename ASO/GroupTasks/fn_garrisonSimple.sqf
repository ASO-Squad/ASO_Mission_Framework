/* ----------------------------------------------------------------------------
Description:
    Puts a group to the garrison of an AOI. They keep close to their starting position, and in contrast
    to aso_fnc_garrison non-loiterinmg groups do not move at all (but may enter their vehicles)  
	A garrison might engage enemies far away and even be called to defend another trigger
    BE ADVISED: If a unit previously belonged to an AOI, it is still considered to be part of that AOI.

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle
    _type       - What kind of unit is this. Possible values are:
                "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"
    _loiter     - Move around the current position
    _fromDB   - Avoid loading orders, useful if this function is already called by loading an order

Returns:
    None

Example:
    [myGroup, myTrigger, "INFANTRY", true] call aso_fnc_garrisonSimple

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", "_trigger", "_type", "_loiter", ["_fromDB", true]];
private ["_orders", "_default"];

// Keep this group in mind for saving
[_group] call aso_fnc_collectGroup;

// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Clear waypoints to make the group move immediately
[_group] call CBA_fnc_clearWaypoints;

// Load previous state, if desired
// true is, in this case a safe default, because we check for the presence of aso_orders later
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
_orders = -1;
if (_load == 1 && _fromDB) then
{
    ["Loading Orders for", groupId _group, true] call aso_fnc_debug;    
    [[_group], ASO_PREFIX] call aso_fnc_executeLoadOrders;
    // Make sure we loaded some orders
    _orders = _group getVariable ["aso_orders", false];
    _default = false;
};

if (typeName _orders == "ARRAY") then
{
    _order = (_orders select 0);
    _target = (_orders select 1);
    ["execute orders", _order] call aso_fnc_debug;
    ["order target", _target] call aso_fnc_debug; 
    // Putting this group to AOI
    switch (_order) do 
    {
        case "ATTACK": { [_group, _target, false] call aso_fnc_attack; };
        case "SEARCH": { [_group, _target, false] call aso_fnc_search; };
        case "PATROL": { [_group, _target, false] call aso_fnc_patrol; };
        case "GUARD":  { [_group, _target, false, _type, false] call aso_fnc_guard };
        default { _default = true; };
    };
}
else
{
    ["orders are array", false] call aso_fnc_debug;
    _default = true;
};
if (_default) then
{
     ["Using default orders", groupId _group] call aso_fnc_debug;
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
        if (_type == "AIR") then
        {
            // If it is not flying, I assume it is at its base
            _leader = leader _group;
            _height = (getPosATL _leader) select 2;
            if (_height <= 3) then
            {
                [_group, _trigger, 0, "GETIN", "COMBAT", "YELLOW", "NORMAL", "STAG COLUMN"] call CBA_fnc_addWaypoint;
            };
            // Check for ASO_LANDING
            _landing = _group getVariable ["ASO_LANDING", []];
            // Create landing if possible
            if (count _landing == 0 && _height <= 3) then
            {
                _landing = [_group, (leader _group)] call aso_fnc_setLandingPad;
            };
            // Try to land
            [_group, _landing, nil] spawn aso_fnc_wpLand;
            ["Trying to land: ", _group] call aso_fnc_debug;
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
                [_group, (getPos leader _group), 0, "GETIN", "COMBAT", "YELLOW", "NORMAL", "STAG COLUMN"] call CBA_fnc_addWaypoint;
                // re-enable dynamic simulation, most of the time the group will go to sleep mid-way and continue its way if something gets close enough
                [_group, 60] spawn aso_fnc_enableDynamicSim;
            };
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
};
// Show Debug Output
[_group] spawn aso_fnc_trackGroup;