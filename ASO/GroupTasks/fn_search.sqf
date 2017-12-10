/* ----------------------------------------------------------------------------
Description:
    A function for a group to search an AOI. 

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_search

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger"];
// do not give orders to empty groups
if (isNull _group || (count units _group) == 0) exitWith {};
// Calling CBA_fnc_taskDefend
[_group, _trigger] call CBA_fnc_taskSearchArea;

// Tracking Orders
_group setVariable ["ASO_ORDERS", ["SEARCH", _trigger], true];

// Show Debug Output
["New task SEARCH for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;