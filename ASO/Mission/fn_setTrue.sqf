/* ----------------------------------------------------------------------------
Description:
    Allows you to set a boolean variable stored in the tasks object to true.

Parameters:
    _taskObj    - The task module that is used to sychronize spawn points to.

Returns:
    nothing

Examples:
    [this] call aso_fnc_setTrue;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_taskObj"];

_variables = _taskObj  getVariable ["aso_switch", []];

{
    missionNamespace setVariable [_x, true];

} forEach _variables;

true;