/* ----------------------------------------------------------------------------
Description:
    Add a boolean to the tasks object

Parameters:
    _taskObj    - The task module that is used to sychronize spawn points to.

Returns:
    nothing

Examples:
    [this, "allow_some_shit"] call aso_fnc_addBoolean;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_taskObj", "_var"];

_variables = _taskObj getVariable ["aso_switch", []];

_variables pushBack _var;

_taskObj setVariable ["aso_switch", _variables];

missionNamespace setVariable [_var, false];
true;