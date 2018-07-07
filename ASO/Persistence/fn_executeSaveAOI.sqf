/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to save an AOI
	
Parameters:
    _triggers		- An Array with triggers representing the AOIs
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you do not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_triggers, _prefix] call aso_fnc_executeSaveAOI;

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
		[_x, false, _prefix, "", ""] call aso_fnc_saveVar;

	} forEach _triggers;
}
else
{
	{
		[_x, false, _prefix, "", ""] remoteExecCall ["aso_fnc_saveVar", 2, false]; // Call this on the server

	} forEach _triggers;
	
};		