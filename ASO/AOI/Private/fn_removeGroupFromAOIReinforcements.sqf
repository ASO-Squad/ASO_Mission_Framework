/* ----------------------------------------------------------------------------
Description:
    Removes a Group from the reinforcments list of an AOI.

Parameters:
    _group		- The group that is removed from that AOI as reinforcments
    _trigger    - The trigger that defines the location and size of this AOI

Returns:
    None

Examples:
    [_thisGroup, _thisTrigger] spawn aso_fnc_removeGroupFromAOIReinforcements

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
// Get groups already assigend as reinforcements 
_groups = [_trigger] call aso_fnc_getAOIReinforcementGroups;
// Remove Group 
_groups = _groups - [_group];
[_groups, _trigger] call aso_fnc_setAOIReinforcementGroups;
// push to global AOI list
[ASO_AOIs, _trigger, _thisAOI] call CBA_fnc_hashSet;
["Group removed from reinforcment list", _group] call aso_fnc_debug;

