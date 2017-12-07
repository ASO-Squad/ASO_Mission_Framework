/* ----------------------------------------------------------------------------
Description:
    initializes an area of interest with all its properties

Parameters:
    _trigger				- The trigger that defines the location and size of this AOI
	_group					- The more important, the higher this number should be a integer between 1-5

Returns:
    None

Examples:
    [_thisTrigger, _thisGroup] call aso_fnc_addGroupToAOI

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_trigger", "_group"];
// Wait until bis_fnc_init is ready
waitUntil {!isnil "bis_fnc_init"};

_thisAOI = [];

// Wait for the AOI to appear
waitUntil {_thisAOI = [ASO_AOIs, _trigger] call CBA_fnc_hashGet; (count _thisAOI) > 0};

// Get AOI
_thisAOI = [ASO_AOIs, _trigger] call CBA_fnc_hashGet;
// index #6 is the groups for this AOI
// This might be better solved with hashes
_groups = _thisAOI select 6;
_groups pushBack _group;
_thisAOI set [6, _groups];
// push to global AOI list
[ASO_AOIs, _trigger, _thisAOI] call CBA_fnc_hashSet; // Kommt noch doppelt an evtl. pushBackUnique verwenden.

["Group added", _group] call aso_fnc_debug;