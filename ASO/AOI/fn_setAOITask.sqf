/* ----------------------------------------------------------------------------
Description:
    Sets the taskname for this AOI

Parameters:
    _AOI		- The trigger that defines the AOI
	_taskName	- the taskname for this AOI

Returns:
    None

Examples:
    [_AOI, _taskName] call aso_fnc_setAOITask

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_AOI", "_taskName"];

_AOI setVariable ["ASO_TASK", _taskName, true];
["AOI task set", _taskName] call aso_fnc_debug;