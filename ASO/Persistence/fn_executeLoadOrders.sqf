/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to load orders of a group
Parameters:
    _groups		- The groups we want to load
	_prefix		- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_groups, _prefix] call aso_fnc_executeLoadOrders;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_groups", ["_prefix", ASO_PREFIX]];

if (isServer) then
{
    {
        [_x, false, _prefix, "", ""] call aso_fnc_loadVar;
        
    } forEach _groups;
	
}
else
{
    {
        [_x, false, _prefix, "", ""] remoteExecCall ["aso_fnc_loadVar", 2, false]; // Call this on the server
        
    } forEach _groups;
	
};		