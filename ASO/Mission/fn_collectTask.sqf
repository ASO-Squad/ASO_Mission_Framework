/* ----------------------------------------------------------------------------
Description:
    Puts a tasks safely inside ASO_TASKS Array

Parameters:
    _obj			- The Task object
    _isAddition     - True if this is an additional task 

Returns:
    nothing

Examples:
    [this] spawn aso_fnc_collectTask;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_obj", ["_isAddition", false]];

waitUntil { !isNil {BIS_fnc_init}; };
waitUntil { BIS_fnc_init; };

private _task = _obj getVariable ["task", ""];
if (_isAddition) then 
{
    _obj setVariable ["aso_isaddition", true];
};

if (_task == "") exitWith {false;};

ASO_TASKS pushBackUnique [_task, _obj];