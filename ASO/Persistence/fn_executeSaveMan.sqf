/* ----------------------------------------------------------------------------
Description:
    Remotly executes all function that are needed to save a players state.
	That includes:
	- Position
	- Inventory	
	- Health
	- Vehicle/w. Seat
	- Linked Mines

Parameters:
    _units			- The units that we want to save.
					If you leave this array empty, all players get saved.
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name

Returns:
    nothing

Example:
    [_units, false] call aso_fnc_executeSaveMan;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_units", "_saveByName", ["_prefix", ASO_PREFIX]];

// If the unit array is empty, save all players
if (count _units == 0) then
{
	_units = allPlayers;
};

{
	private _dbName = [_x, _saveByName] call aso_fnc_getDbName;
	if (isServer) then
	{
		private _position = [_x] call aso_fnc_getPosition;
		private _inventory = [_x] call aso_fnc_getInventory;
		private _health = [_x] call aso_fnc_getHealth;
		private _mount = [_x] call aso_fnc_getMount;
		private _explosives = [_x] call aso_fnc_getExplosives;

		["Men", _dbName, "Position", _position] call aso_fnc_writeValue;
		["Men", _dbName, "Inventory", _inventory] call aso_fnc_writeValue;
		["Men", _dbName, "Health", _health] call aso_fnc_writeValue;
		["Men", _dbName, "Mount", _mount] call aso_fnc_writeValue;
		["Men", _dbName, "Explosives", _explosives] call aso_fnc_writeValue;
	}
	else
	{
		private _position = [_x] remoteExecCall ["aso_fnc_getPosition", 2, false];
		private _inventory = [_x] remoteExecCall ["aso_fnc_getInventory", 2, false];
		private _health = [_x] remoteExecCall ["aso_fnc_getHealth", 2, false];
		private _mount = [_x] remoteExecCall ["aso_fnc_getMount", 2, false];
		private _explosives = [_x] remoteExecCall ["aso_fnc_getExplosives", 2, false];
		
		["Men", _dbName, "Position", _position] remoteExecCall ["aso_fnc_writeValue", 2, false];
		["Men", _dbName, "Inventory", _inventory] remoteExecCall ["aso_fnc_writeValue", 2, false];
		["Men", _dbName, "Health", _health] remoteExecCall ["aso_fnc_writeValue", 2, false];
		["Men", _dbName, "Mount", _mount] remoteExecCall ["aso_fnc_writeValue", 2, false];
		["Men", _dbName, "Explosives", _explosives] remoteExecCall ["aso_fnc_writeValue", 2, false];
	};		
} forEach _units;
true;