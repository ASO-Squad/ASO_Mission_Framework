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
if (!isServer) exitWith {false;};

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
} forEach _units;
true;
