/* ----------------------------------------------------------------------------
Description:
    Sets all tasks currently assigned to an AOI 

Parameters:
    _tasks          - The new tasks
    _AOIObject      - The AOI I want the tasks to be set for

Returns:
    None

Examples:
    [[_newTasks], _thisAOI] call aso_fnc_setAOITasks

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_tasks", "_AOIObject"];

// Get AOI from global hash
_thisAOI = [ASO_AOIs, _AOIObject] call CBA_fnc_hashGet;
// Check if there is an AOI, quit quietly if there is not
if ((count _thisAOI) == 0) exitWith {[]};

// index #6 is the tasks for an AOI
_thisAOI set [6, _tasks];

// push this AOI back to the global array
[ASO_AOIs, _AOIObject, _thisAOI] call CBA_fnc_hashSet;