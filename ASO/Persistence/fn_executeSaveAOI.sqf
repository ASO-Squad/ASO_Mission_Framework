/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to save an AOI
	
Parameters:
    _trigger		- The trigger representing the AOI
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_trigger, _prefix] call aso_fnc_executeSaveAOI;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_trigger", ["_prefix", ASO_PREFIX]];

if (isServer) then
{
	[_trigger, false, _prefix, "", ""] call aso_fnc_saveVar;
}
else
{
	[_trigger, false, _prefix, "", ""] remoteExecCall ["aso_fnc_saveVar", 2, false]; // Call this on the server
};		