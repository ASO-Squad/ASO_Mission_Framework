/* ----------------------------------------------------------------------------
Description:
    Puts a tasks safely inside ASO_TASKS Array. Make sure to only use this on 
    tasks that are used to spawn units or groups.

Parameters:
    _tasks			- A Tasks array, in most cases ASO_TASKS

Returns:
    nothing

Examples:
    [] spawn aso_fnc_watchTasks;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!canSuspend) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_tasks", ASO_TASKS]];
waitUntil { count _tasks > 0; };
private _serverTasks = +_tasks;
while {count _tasks > 0} do 
{
    {
        private _currentTask = _x call BIS_fnc_taskCurrent;
        private _parent = "";
        if (_currentTask != "") then 
        {
            _parent = _currentTask call BIS_fnc_taskParent;
            if (_parent != "" && count ([_tasks, _parent] call BIS_fnc_findNestedElement) > 0) then 
            {
                [_parent, "ASSIGNED", false] call BIS_fnc_taskSetState;
                // Remove that task
                _listEntry = [_tasks, _parent] call BIS_fnc_findNestedElement;
                _i = (_listEntry select 0);
                _tasks deleteAt _i;   
            }
            else 
            {
                if (count ([_tasks, _currentTask] call BIS_fnc_findNestedElement) > 0) then
                {
                    [_currentTask, "ASSIGNED", false] call BIS_fnc_taskSetState;
                    // Remove that task
                    _listEntry = [_tasks, _currentTask] call BIS_fnc_findNestedElement;
                    _i = (_listEntry select 0);
                    _tasks deleteAt _i; 
                };                
            };
        };        
    } forEach allPlayers;
    
    if (isServer) then 
    {
        {
            private _taskID = _x select 0;
            private _obj = _x select 1;
            private _state = _taskID call BIS_fnc_taskState;
            if (_state == "ASSIGNED") then 
            {
                private _isAddition = _obj getVariable ["aso_isaddition", false];
                if (_isAddition) then
                {
                    _title = (_taskID call BIS_fnc_taskDescription) select 1 select 0;
                    ["New Impediment", _title, ""] remoteExec ["aso_fnc_displayInfo"];
                    [_taskID,"SUCCEEDED", false] call BIS_fnc_taskSetState;
                }
                else 
                {
                    _title = (_taskID call BIS_fnc_taskDescription) select 1 select 0;
                    _location = format ["At Grid %1", mapGridPosition (_taskID call BIS_fnc_taskDestination)];
                    ["New Assignment", _title, _location] remoteExec ["aso_fnc_displayInfo"];
                };
                // Spawn the tasks synced groups
                [_obj] call aso_fnc_spawnSynchronized;
                // See if there is a variable that needs to be set to true;
                [_obj] call aso_fnc_setTrue;
                _serverTasks = _serverTasks - [_x];             
            };   
        } forEach _serverTasks;
    };
    uiSleep 5;
};