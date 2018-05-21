/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to save the orders of a group of AI
	
Parameters:
    _groups		- An array of groups
	_prefix		- Prefix to be used for the database. This is usually used to identify different missions
				If you do not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_groups, _prefix] call aso_fnc_executeSaveOrders;

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
		[_x, false, _prefix, ["aso_orders", "aso_home", "aso_type"], ""] call aso_fnc_saveVar;

	} forEach _groups;
}
else
{
	{
		[_x, false, _prefix, ["aso_orders", "aso_home", "aso_type"], ""] remoteExecCall ["aso_fnc_saveVar", 2, false]; // Call this on the server

	} forEach _groups;
	
};		