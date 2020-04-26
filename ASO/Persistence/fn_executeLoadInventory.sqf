/* ----------------------------------------------------------------------------
Description:
    Remotly executes loadInventory for a bunch of units  

Parameters:
    _units			- The units that we want to load the inventory of.
					If you leave this array empty, all players get load.
	_loadByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix         - Prefix that is used, leave empty for ASO_PREFIX

Returns:
    nothing

Example:
    [_units, false] call aso_fnc_executeLoadInventory;

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
	private _dbName = [_x, _loadByName] call aso_fnc_getDbName;
	if (isServer) then
	{
		private _inventory = ["Inventory", _dbName, "Inventory", _prefix] call aso_fnc_readValue;

		// for players, we need to wait until tfr is initialized
		if (ASO_USE_TFR && isPlayer _x) then
		{
			_return = [_x, _inventory] spawn aso_fnc_setInventory;
		}
		else 
		{
			// for all AIs we want speed
			[_x, _inventory] call aso_fnc_setInventory;
		};
	}
	else
	{
		private _inventory = ["Inventory", _dbName, "Inventory", _prefix] remoteExecCall ["aso_fnc_readValue", 2, false];
		
		if (ASO_USE_TFR && isPlayer _x) then
		{
			_return = [_x, _inventory] remoteExec ["aso_fnc_setInventory", 2, false]; 
		}
		else
		{
			[_x, _inventory] remoteExecCall ["aso_fnc_setInventory", 2, false];
		};
	};		
} forEach _units;
true;