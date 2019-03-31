/* ----------------------------------------------------------------------------
Description:
    initializes an area of interest with all its properties

Parameters:
    _trigger				- The trigger that defines the location and size of this AOI
	_objectiveHeader		- If this string is filled, it will create an objective for this AOI
	_objectiveDescription	- This string should describe the objective of this AOI 
	_taskType				- Can by any taskType defined here: https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Default_Task_Types:_Actions
	_taskOwner				- Who recieves the generated task can be any side or any player
	_taskPriority			- Task priority, higher numbers are more important tasks
	_taskParent				- parent task id, can be an empty string

Returns:
    None

Examples:
    [_thisTrigger, "My Header", "Kill everyone!", "attack", "west", ] call aso_fnc_initAOI

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_trigger", "_objectiveHeader", "_objectiveDescription", "_taskType", "_taskOwner", "_taskPriority", ["_taskParent", ""]];

// the indices of this array have the following meanings
// 0 - 2 = Parameters as definded above
// 3 = Groups occuping this AOI
// 4 = Groups on their way to this AOI
_thisAOI = [_trigger, _objectiveHeader, _objectiveDescription, [], []];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

//Creating task
if (_objectiveHeader != "") then
{
	_taskName = format ["task_%1", _trigger];
	if (_taskParent == "") then 
	{
		[_taskOwner, [_taskName], [_objectiveDescription, _objectiveHeader, ""], (getPos _trigger), "AUTOASSIGNED", _taskPriority, true, _taskType] call BIS_fnc_taskCreate;
	} 
	else 
	{
		[_taskOwner, [_taskName, _taskParent], [_objectiveDescription, _objectiveHeader, ""], (getPos _trigger), "AUTOASSIGNED", _taskPriority, true, _taskType] call BIS_fnc_taskCreate;
	};
	
	[_trigger, _taskName] call aso_fnc_setAOITask;

};
// set initial AOI status status
_trigger setVariable ["ASO_SAFE", true, true];
_trigger setVariable ["ASO_DETECTED", false, true];
_trigger setVariable ["ASO_DISTRESS", false, true];
_trigger setVariable ["ASO_LOST", false, true];

// Load previous state, if desired
waitUntil {!(isNil "paramsArray")};
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
if (_load == 1) then
{
	[[_trigger], ASO_PREFIX] call aso_fnc_executeLoadAOI;
};

waitUntil {!isnil "bis_fnc_init"};
// push to global AOI list
[ASO_AOIs, _trigger, _thisAOI] call CBA_fnc_hashSet;

["AOI initialized", _trigger] call aso_fnc_debug;