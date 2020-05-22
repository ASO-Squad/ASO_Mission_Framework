/* ----------------------------------------------------------------------------
Description:
    Show a ACE progress bar and set a variable on a given object.

Parameters:
    _title			- What is the name of the progress bar
	_time			- How long does it take to complete
    _obj            - To what object is the success reported?
    _var            - How is the variable named that reports success
    _hide           - Hide object after progress is completed

Returns:
    None

Examples:
    [_title, _time, _obj, _var, _hide] call aso_fnc_showProgress;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_title", "_time", "_obj", "_var", "_hide"];

private _complete = false;

// Somehow the params do not work as expected, the first param contains all parameters.
_complete = 
{ 
    params ["_vars"]; 
    private _object = _vars select 0;
    private _variable = _vars select 1;
    private _hide = _vars select 2;
    _object setVariable [_variable, true, true];
    if (_hide) then 
    { 
        _pos = getPosATL _object;
        _object setPosATL [_pos select 0, _pos select 1, -100];
    };
};
_fail =
{ 
    params ["_vars"]; 
    private _object = _vars select 0;
    private _variable = _vars select 1;
    _object setVariable [_variable, false, true];
};

[_time, [_obj, _var, _hide], _complete, _fail, _title] call ace_common_fnc_progressBar;

true;