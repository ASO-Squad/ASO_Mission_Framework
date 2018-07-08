/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to load the mission environment,
	that includes date, time, weather and the weather forecast 
	
Parameters:
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_prefix] call aso_fnc_executeLoadEnvironment;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_prefix", ASO_PREFIX]];

if (isServer) then
{
	[_prefix] call aso_fnc_loadDateTime;
}
else
{
	[_prefix] remoteExecCall ["aso_fnc_loadDateTime", 2, false]; // Call this on the server
};		