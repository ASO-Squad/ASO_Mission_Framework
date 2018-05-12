/* ----------------------------------------------------------------------------
Description:
   Saves one or all varaibles of a given namespace
	
Parameters:
    _varspace		- Can be any object
	_saveByName		- If true, and the target is a player we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
	_varname		- the variable we want to save. If you leave this empty, all variables of the target are saved (this can be a LOT!)
	_default 		- The preferred default value

Returns:
    nothing

Example:
    [_varspace, false, _prefix, _varname, _default] call aso_fnc_SaveVar;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_varspace", "_saveByName", "_prefix", "_varname", "_default"];

// Use the appropriate name for the database 
_db = [_varspace, _saveByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Variables"] call _inidbi; // cleanup

_value = "";
_all = [];
if (_varname == "") then
{
	_all = allVariables _varspace;
	["write", ["Variables", "AllVariables", _all]] call _inidbi;
	// looping through all variables
	{
		_value = _varspace getVariable _x;
		["write", ["Variables", _x, _value]] call _inidbi;
	} forEach _all;
}
else
{
	["write", ["Variables", "AllVariables", [_varname]]] call _inidbi;
	_value = _varspace getVariable [_varname, _default];
	["write", ["Variables", _varname, _value]] call _inidbi;
};