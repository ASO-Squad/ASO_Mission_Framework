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
// index #6 is the groups for this AOI
_groups = _thisAOI select 6; 
_groups pushBackUnique _group;
_thisAOI set [6, _groups];
// push to global AOI list
[ASO_AOIs, _trigger, _thisAOI] call CBA_fnc_hashSet;
["Group added", _group] call aso_fnc_debug;
// Delete from Garrison
_toDelete = [_group];
ASO_GARRISON = ASO_GARRISON - _toDelete; // I dont know if this is fast. It could be worth to implement getters and setters on those global hashes 
["Group is no longer in garrison", _group] call aso_fnc_debug;