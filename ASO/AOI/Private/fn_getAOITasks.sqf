/* ----------------------------------------------------------------------------
Description:
    Returns all tasks currently assigned to an AOI 

Parameters:
    _AOI    - The AOI I want the tasks from

Returns:
    [Tasks]

Examples:
    [Tasks] = [_thisAOI] call aso_fnc_getAOITasks

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_AOI"];

// Get AOI from global hash
_thisAOI = [ASO_AOIs, _AOI] call CBA_fnc_hashGet;
// Check if there is an AOI, quit quietly if there is not
if ((count _thisAOI) == 0) exitWith {[]};

// index #6 is the tasks for an AOI
(_thisAOI select 6);