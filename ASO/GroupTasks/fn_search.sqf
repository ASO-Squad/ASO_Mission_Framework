/* ----------------------------------------------------------------------------
Description:
    A function for a group to search an AOI. 

Parameters:
    _group      - the group searching the area
    _trigger   	- trigger that is to be searched, should be a circle

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_search

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
// Calling CBA_fnc_taskDefend
[_group, _trigger] call CBA_fnc_taskSearchArea;

// Tracking Orders
_group setVariable ["ASO_ORDERS", ["SEARCH", _trigger], true];

// Show Debug Output
["New task SEARCH for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;
// Give that group a little time to move
[_group, 300] spawn aso_fnc_enableDynamicSim;