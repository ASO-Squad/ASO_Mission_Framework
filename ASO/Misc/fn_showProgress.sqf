/* ----------------------------------------------------------------------------
Description:
    Show a ACE progress bar and set a variable on a given object.

Parameters:
    _title			- What is the name of the progress bar
	_time			- How long does it take to complete
    _obj            - To what object is the success reported?
    _var            - How is the variable named that reports success

Returns:
    None

Examples:
    [_title, _time, _obj, _var] call aso_fnc_showProgress;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_title", "_time", "_obj", "_var"];

private _complete = false;

// Somehow the params do not work as expected, the first param contains all parameters.
_complete = { params ["_vars"]; _vars select 0 setVariable [_vars select 1, true, true];};
_fail = { params ["_vars"]; _vars select 0 setVariable [_vars select 1, false, true];};

[_time, [_obj, _var], _complete, _fail, _title] call ace_common_fnc_progressBar;

true;