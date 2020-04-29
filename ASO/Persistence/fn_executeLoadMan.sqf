/* ----------------------------------------------------------------------------
Description:
    Remotly executes all function that are needed to load a players state.
	That includes:
	- Position
	- Inventory	
	- Health
	- Vehicle/w. Seat
	- Linked Mines

Parameters:
    _units			- The units that we want to load.
					If you leave this array empty, all players get load.
	_loadByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_ifIsDead		- What to do if the unit is dead.
					If this is an object, the unit will be transported there
					If it is a bool: true  means, it will stay dead.
									 false means, the unit will wake up with half its previous damage.

Returns:
    nothing

Example:
    [_units, false, false] call aso_fnc_executeLoadMan;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_units", "_loadByName", "_ifIsdead"];

if (count _units == 0) then
{
	_units = allPlayers;
};

// If the unit array is empty, load all players
{
	private _dbName = [_x, _loadByName] call aso_fnc_getDbName;
	if (isServer) then
	{
		// Reading from DB
		private _position = ["Men", _dbName, "Position"] call aso_fnc_readValue;
		private _inventory = ["Men", _dbName, "Inventory"] call aso_fnc_readValue;
		private _health = ["Men", _dbName, "Health"] call aso_fnc_readValue;
		private _mount = ["Men", _dbName, "Mount"] call aso_fnc_readValue;
		private _explosives = ["Men", _dbName, "Explosives"] call aso_fnc_readValue;

		// for players, we need to wait until tfr is initialized
		if (ASO_USE_TFR && isPlayer _x) then
		{
			[_x, _inventory] spawn aso_fnc_setInventory;
		}
		else 
		{
			// for all AIs we want speed
			[_x, _inventory] call aso_fnc_setInventory;
		};
		[_x, _position] call aso_fnc_setPosition;
		[_x, _health, _ifIsDead] call aso_fnc_setHealth;
		[_x, _mount] call aso_fnc_setMount;
		[_x, _explosives] call aso_fnc_setExplosives;
	}
	else
	{
		// Reading from DB
		private _position = ["Men", _dbName, "Position"] remoteExecCall ["aso_fnc_readValue", 2, false];
		private _inventory = ["Men", _dbName, "Inventory"] remoteExecCall ["aso_fnc_readValue", 2, false];
		private _health = ["Men", _dbName, "Health"] remoteExecCall ["aso_fnc_readValue", 2, false];	
		private _mount = ["Men", _dbName, "Mount"] remoteExecCall ["aso_fnc_readValue", 2, false];	
		private _explosives = ["Men", _dbName, "Explosives"] remoteExecCall ["aso_fnc_readValue", 2, false];

		if (ASO_USE_TFR && isPlayer _x) then
		{
			[_x, _inventory] remoteExec ["aso_fnc_setInventory", 2, false]; 
		}
		else
		{
			[_x, _inventory] remoteExecCall ["aso_fnc_setInventory", 2, false];
		};
		[_x, _position] remoteExecCall ["aso_fnc_setPosition", 2, false];
		[_x, _health, _ifIsDead] remoteExecCall ["aso_fnc_setHealth", 2, false];
		[_x, _mount] remoteExecCall ["aso_fnc_setMount", 2, false];
		[_x, _explosives] remoteExecCall ["aso_fnc_setExplosives", 2, false];
	};		
} forEach _units;
true;
