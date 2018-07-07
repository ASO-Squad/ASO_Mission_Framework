/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to load all variables stored on an object or namespace
	
Parameters:
    _varspace		- Can be any object true namespaces are currently not supported
	_loadByName		- If true, and the target is a player we are loading this by the units name, otherwise it is loaded by the players name
	_varname		- the variable we want to load. If you leave this empty, all variables of the target are loaded (this can be a LOT!)
	_default 		- The preferred default value
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_varspace, false, _prefix, _varname] call aso_fnc_executeLoadVar;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_varspace", "_loadByName", ["_varname", ""], ["_default", ""], ["_prefix", ASO_PREFIX]];

if (isServer) then
{
	[_varspace, _loadByName, _prefix, _varname, _default] call aso_fnc_loadVar;
}
else
{
	[_varspace, _loadByName, _prefix, _varname, _default] remoteExecCall ["aso_fnc_loadVar", 2, false]; // Call this on the server
};		