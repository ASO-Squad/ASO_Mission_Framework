/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to load the state of an AOI
Parameters:
    _triggers		- The triggers representing the AOIs
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_triggers, _prefix] call aso_fnc_executeLoadAOI;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_triggers", ["_prefix", ASO_PREFIX]];

if (isServer) then
{
    {
        [_x, false, _prefix, "", ""] call aso_fnc_loadVar;
        
    } forEach _triggers;
	
}
else
{
    {
        [_x, false, _prefix, "", ""] remoteExecCall ["aso_fnc_loadVar", 2, false]; // Call this on the server
        
    } forEach _triggers;
	
};		