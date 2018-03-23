/* ----------------------------------------------------------------------------
Description:
    Adds a Group to an AOI as reinforcments.

Parameters:
    _group		- The group that moves into that AOI as reinforcments
    _trigger    - The trigger that defines the location and size of this AOI
    _orders     - Can be one of the following: "ATTACK", "GUARD", "SEARCH"

Returns:
    None

Examples:
    [_thisGroup, _thisTrigger, _orders] spawn aso_fnc_addGroupToAOIReinforcements

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_group", "_trigger", "_orders"];
// Wait until bis_fnc_init is ready
waitUntil {!isnil "bis_fnc_init"};

_thisAOI = [];

// Wait for the AOI to appear
waitUntil {_thisAOI = [ASO_AOIs, _trigger] call CBA_fnc_hashGet; (count _thisAOI) > 0};

// Get AOI from global hash
_thisAOI = [ASO_AOIs, _trigger] call CBA_fnc_hashGet;
// Get groups already assigend as reinforcements 
_groups = [_trigger] call aso_fnc_getAOIReinforcementGroups;
// Add new group to array 
_groups pushBackUnique _group;
[_groups, _trigger] call aso_fnc_setAOIReinforcementGroups;
// push to global AOI list
[ASO_AOIs, _trigger, _thisAOI] call CBA_fnc_hashSet;
["Group added as reeinforcment", _group] call aso_fnc_debug;

[_group, _trigger, _orders] call aso_fnc_reinforce;

