/* ----------------------------------------------------------------------------
Description:
    Adds a Task to an AOI. This is important if you want to delete tasks later, based on its AOI

Parameters:
    _taskID		- The task that needs to be assigned to an AOI
    _trigger    - The trigger that defines the location and size of this AOI

Returns:
    None

Examples:
    [_taskID, _thisTrigger] spawn aso_fnc_addTaskToAOI

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_taskID", "_trigger"];
// Wait until bis_fnc_init is ready
waitUntil {!isnil "bis_fnc_init"};

_thisAOI = [];

// Wait for the AOI to appear
waitUntil {_thisAOI = [ASO_AOIs, _trigger] call CBA_fnc_hashGet; (count _thisAOI) > 0};

// Get AOI from global hash
_thisAOI = [ASO_AOIs, _trigger] call CBA_fnc_hashGet;
// Get tasks already in this AOI
_tasks = [_trigger] call aso_fnc_getAOITasks;
// Add new task to array 
_tasks pushBackUnique _taskID;
[_tasks, _trigger] call aso_fnc_setAOITasks;
// push to global AOI list
[ASO_AOIs, _trigger, _thisAOI] call CBA_fnc_hashSet;

["Task added", _taskID] call aso_fnc_debug;