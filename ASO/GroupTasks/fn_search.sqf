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

// Calling CBA_fnc_taskDefend
[_group, _trigger] call CBA_fnc_taskSearchArea;

// Show Debug Output
["New task SEARCH for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;