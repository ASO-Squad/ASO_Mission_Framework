/* ----------------------------------------------------------------------------
Description:
    Remotly executes saveInventory  

Parameters:
    _units			- The units that we want to keep the inventory of.
					If you leave this array empty, all players get saved.
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name

Returns:
    nothing

Example:
    [_units, false] call aso_fnc_executeSaveInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_units", "_saveByName"];

if (count _units == 0) then
{
	_units = allPlayers;
};
// If the unit array is empty, save all players
{
	private _dbName = [_x, _saveByName] call aso_fnc_getDbName;
	if (isServer) then
	{
		private _inventory = [_x] call aso_fnc_getInventory;
		["Inventory", _dbName, "Inventory", _inventory] call aso_fnc_writeValue;
	}
	else
	{
		private _inventory = [_x] remoteExecCall ["aso_fnc_getInventory", 2, false];
		["Inventory", _dbName, "Inventory", _inventory] remoteExecCall ["aso_fnc_writeValue", 2, false];
	};		
} forEach _units;