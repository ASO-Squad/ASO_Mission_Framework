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
_db = "";
if (_loadByName) then 
{
	_db = vehicleVarName _varspace;
}
else
{
	_uid = getPlayerUID _varspace;
	if (_uid == "") then
	{
		_db = vehicleVarName _varspace; // Fallback if the unit is not a player
	}
	else
	{
		_db = _uid;
	};
};
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;

_value = "";
_all = [];
if (_varname == "") then
{
	_all = ["read", ["Variables", "AllVariables"]] call _inidbi;
	// looping through all variables
	{
		_value = ["read", ["Variables", _x, _default]] call _inidbi;
		_varspace setVariable [_x, _value, true];
	} forEach _all;
}
else
{
	_value = ["read", ["Variables", _varname, _default]] call _inidbi;
	_varspace setVariable [_varname, _value, true];
};