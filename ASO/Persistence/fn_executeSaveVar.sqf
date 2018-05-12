/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to save all variables stored on an object or namespace
	If you choose to save only one variable, exactly one variable is going to be saved. All previous saved variables are going to be overwritten.
	
Parameters:
    _varspace		- Can be any object true namespaces are currently not supported
	_saveByName		- If true, and the target is a player we are saving this by the units name, otherwise it is saved by the players name
	_varname		- the variable we want to save. If you leave this empty, all variables of the target are saved (this can be a LOT!)
					  you can also give an array of variables, you want to be saved.
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_varspace, false, _varname, nil, _prefix] call aso_fnc_executeSaveVar;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_varspace", "_saveByName", ["_varname", ""], ["_default", ""], ["_prefix", ASO_PREFIX]];

if (isServer) then
{
	[_varspace, _saveByName, _prefix, _varname, _default] call aso_fnc_saveVar;
}
else
{
	[_varspace, _saveByName, _prefix, _varname, _default] remoteExecCall ["aso_fnc_saveVar", 2, false]; // Call this on the server
};		