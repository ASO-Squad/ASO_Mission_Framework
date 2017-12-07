/* ----------------------------------------------------------------------------
Description:
    A function for a group to defend a trigger. 
	A garrison might engage enemies far away and even be called to defend another trigger

Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle

Returns:
    None

Example:
    [myGroup, myTrigger] call aso_fnc_garrison

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_trigger"];
// extracting info from trigger
_xRad = triggerArea _trigger select 0;
_yRad = triggerArea _trigger select 1;
_radius = (_xRad + _yRad) / 2;

// Calling CBA_fnc_taskDefend
[_group, _trigger, _radius, 2, 0.5, 0] call CBA_fnc_taskDefend;

// Putting this group to the global garrison
ASO_GARRISON pushBack _group;
["New unit in ASO_GARRISON", groupId _group] call aso_fnc_debug;
// Show Debug Output
["New task GARRISON for", groupId _group] call aso_fnc_debug;
[_group] spawn aso_fnc_trackGroup;