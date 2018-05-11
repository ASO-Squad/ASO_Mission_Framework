/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to load the state of an AOI
Parameters:
    _trigger		- The trigger representing the AOI
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_trigger, _prefix] call aso_fnc_executeLoadAOI;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_trigger", "_prefix"];

if (isServer) then
{
	[_trigger, false, _prefix, "", ""] call aso_fnc_loadVar;
}
else
{
	[_trigger, false, _prefix, "", ""] remoteExecCall ["aso_fnc_loadVar", 2, false]; // Call this on the server
};		