/* ----------------------------------------------------------------------------
Description:
    Adds a Group to an AOI.

Parameters:
    _group		- The group that needs to be assigned to an AOI
    _trigger    - The trigger that defines the location and size of this AOI

Returns:
    None

Examples:
    [_thisGroup, _thisTrigger] spawn aso_fnc_addGroupToAOI

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_group", "_trigger"];
// Wait until bis_fnc_init is ready
waitUntil {!isnil "bis_fnc_init"};

_thisAOI = [];

// Wait for the AOI to appear
waitUntil {_thisAOI = [ASO_AOIs, _trigger] call CBA_fnc_hashGet; (count _thisAOI) > 0};

// Get AOI from global hash
_thisAOI = [ASO_AOIs, _trigger] call CBA_fnc_hashGet;
// Get groups already in this AOI
_groups = [_trigger] call aso_fnc_getAOIGroups;
// Add new group to array 
_groups pushBackUnique _group;
[_groups, _trigger] call aso_fnc_setAOIGroups;
// push to global AOI list
[ASO_AOIs, _trigger, _thisAOI] call CBA_fnc_hashSet;

["Group added", _group] call aso_fnc_debug;