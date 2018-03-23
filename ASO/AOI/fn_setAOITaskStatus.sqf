/* ----------------------------------------------------------------------------
Description:
    gets the current status for this AOI

Parameters:
    _trigger    - The trigger that defines the location and size of this AOI
    _taskStatus - Task status as defined here: https://community.bistudio.com/wiki/BIS_fnc_taskState

Returns:
    None

Examples:
    [_trigger, _taskStatus] call aso_fnc_setAOITaskStatus

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_trigger", "_taskStatus"];

_taskName = _trigger getVariable ["ASO_TASK", false];
[_taskName, _taskStatus, true] spawn BIS_fnc_taskSetState;