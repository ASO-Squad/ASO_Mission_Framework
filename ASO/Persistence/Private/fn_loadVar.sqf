/* ----------------------------------------------------------------------------
Description:
   Loads one or all variables of a given namespace
	
Parameters:
    _varspace		- Can be any object
	_loadByName		- If true, and the target is a player we are loading this by the units name, otherwise it is loaded by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
	_varname		- the variable we want to load. If you leave this empty, all variables of the target are loaded (this can be a LOT!)
	_default 		- The preferred default value

Returns:
    nothing

Example:
    [_varspace, false, _prefix, _varname, _default] call aso_fnc_loadVar;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_varspace", "_loadByName", "_prefix", "_varname", "_default"];

// Use the appropriate name for the database 
_db = [_varspace, _loadByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
// Check if there is something to load
if (!("exists" call _inidbi)) exitWith {};

_value = "";
_all = [];
if (_varname == "") then
{
	_all = ["read", ["Variables", "AllVariables"]] call _inidbi;
	// looping through all variables
	{
		_value = ["read", ["Variables", _x, _default]] call _inidbi;
		if (typeName _value == "STRING") then
		{
			_isObject = _value find "OBJECT:";
			if (_isObject == 0) then
			{
				_value = [_value, "OBJECT:"] call CBA_fnc_leftTrim;
				_value = (missionNamespace getVariable [_value, objNull]);
			};
		};
		if (typeName _value == "ARRAY") then
		{
			_newValue = [];
			{
				_var = "";
				_isObject = _x find "OBJECT:";
				if (_isObject == 0) then
				{
					_var = [_x, "OBJECT:"] call CBA_fnc_leftTrim;
					_var = (missionNamespace getVariable [_var, objNull]);
				}
				else
				{
					_var = _x;
				};
				_newValue pushBack _var;			
			} forEach _value;
			_value = _newValue;
		};
		_varspace setVariable [_x, _value, true];
	} forEach _all;
}
else
{
	_value = ["read", ["Variables", _varname, _default]] call _inidbi;
	if (typeName _value == "STRING") then
	{
		_isObject = _value find "OBJECT:";
		if (_isObject == 0) then
		{
			_value = [_value, "OBJECT:"] call CBA_fnc_leftTrim;
			_value = (missionNamespace getVariable [_value, objNull]);
		};
	};
	if (typeName _value == "ARRAY") then
	{
		_newValue = [];
		{
			_var = "";
			_isObject = _x find "OBJECT:";
			if (_isObject == 0) then
			{
				_var = [_x, "OBJECT:"] call CBA_fnc_leftTrim;
				_var = (missionNamespace getVariable [_var, objNull]);
			}
			else
			{
				_var = _x;
			};
			_newValue pushBack _var;			
		} forEach _value;
		_value = _newValue;
	};
	_varspace setVariable [_varname, _value, true];
};