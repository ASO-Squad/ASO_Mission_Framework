/* ----------------------------------------------------------------------------
Description:
   Saves one or all variables of a given namespace
	
Parameters:
    _varspace		- Can be any object
	_varname		- the variable we want to save. If you leave this empty, all variables of the target are saved (this can be a LOT!)
	_default 		- The preferred default value
	_aso			- pick only variables with the ASO prefix

Returns:
    nothing

Example:
    [_varspace, _varname, _default, true] call aso_fnc_getVariables;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_varspace", ["_varname", ""], ["_default", false],  ["_aso", true]];

private _varNames = [];
private _variables = [];

if (_varname == "") then
{
	_varNames = allVariables _varspace;
}
else 
{
	_varNames = [_varname];
};
// Now go through all that vars 
{
	private _var = [_x, _varspace getVariable [_x, _default]];
	private _sub = [_x, 0, 2] call CBA_fnc_substring;
	if (_sub == "aso") then 
	{
		_variables pushBack _var;
	};
	
} forEach _varNames;
_variables;