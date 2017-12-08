/* ----------------------------------------------------------------------------
Description:
    initializes an area of interest with all its properties

Parameters:
    _trigger				- The trigger that defines the location and size of this AOI
	_level					- The more important, the higher this number should be a integer between 1-5
	_canCallReenforcments	- Can call for help from garrison units
	_canReoccupy			- Can use garrison units to replace fallen units
	_objectiveHeader		- If this string is filled, it will create an objective for this AOI
	_objectiveDescription	- This string should describe the objective of this AOI 
	_taskType				- Can by any taskType defined here: https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Default_Task_Types:_Actions
	_taskOwner				- Who recieves the generated task can be any side or any player

Returns:
    None

Examples:
    [_thisTrigger, 2, true, true, "My Header", "Kill everyone!", "attack", "west"] call aso_fnc_initAOI

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_trigger", "_level", "_canCallReenforcments", "_canReoccupy", "_objectiveHeader", "_objectiveDescription", "_taskType", "_taskOwner"];

// the indices of this array have the following meanings
// 0 - 5 = Parameters as definded above
// 6 = Groups occuping this AOI
// 7 = Groups on their way to this AOI
// 8 = is defeated or not
_thisAOI = [_trigger, _level, _canCallReenforcments, _canReoccupy, _objectiveHeader, _objectiveDescription, [], [], 0,  false];

//Creating task
if (_objectiveHeader != "") then
{
	_taskName = format ["task_%1", _trigger];
	[_taskOwner, [_taskName], [_objectiveDescription, _objectiveHeader, ""], (getPos _trigger), true, 0, true, _taskType] call BIS_fnc_taskCreate;
};
waitUntil {!isnil "bis_fnc_init"};
// push to global AOI list
[ASO_AOIs, _trigger, _thisAOI] call CBA_fnc_hashSet;

["AOI initialized", _trigger] call aso_fnc_debug;