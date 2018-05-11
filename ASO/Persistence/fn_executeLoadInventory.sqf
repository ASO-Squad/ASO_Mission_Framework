/* ----------------------------------------------------------------------------
Description:
    Remotly executes loadInventory for a bunch of units  

Parameters:
    _units			- The units that we want to load the inventory of.
					If you leave this array empty, all players get load.
	_loadByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_units, false, _prefix] call aso_fnc_executeLoadInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_units", "_loadByName", ["_prefix", ASO_PREFIX]];

if (count _units == 0) then
{
	_units = allPlayers;
};
// If the unit array is empty, load all players
{
	if (isServer) then
	{
		[_x, _loadByName, _prefix] call aso_fnc_loadInventory;
	}
	else
	{
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadInventory", 2, false]; // Call this on the server
	};		
} forEach _units;
