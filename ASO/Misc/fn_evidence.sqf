/* ----------------------------------------------------------------------------
Description:
    Create a ACE menu entry for colleting some intel.

Parameters:
    _obj			- the object we want to attach this action to
	_name			- Actionname, should be unique. 
	_menuEntry 		- Menu Entry
	_title			- Title for the progress bar
	_time 			- How long does it take?

Returns:
    None

Examples:
    [_obj, name, _menuEntry, _title, _time] call aso_fnc_evidence;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_obj", "_name", "_menuEntry", "_title", ["_time", 5]];

// Make sure the variable is there
_var = "ASO_Found";
_obj setVariable [_var, false, true];

private _progress = { params ["_target", "_caller", "_param"]; [_param select 0, _param select 1, _param select 2, _param select 3] call aso_fnc_showProgress; };

_action = [_name, _menuEntry,"", _progress, {true}, {}, [_title, _time, _obj, _var]] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

true;