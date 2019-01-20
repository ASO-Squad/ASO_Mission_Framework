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
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_units, false, false, _prefix] call aso_fnc_executeLoadMan;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_units", "_loadByName", "_ifIsdead", ["_prefix", ASO_PREFIX]];

if (count _units == 0) then
{
	_units = allPlayers;
};

// If the unit array is empty, load all players
{
	if (isServer) then
	{
		// for players, we need to wait until tfr is initialized
		if (ASO_USE_TFR && isPlayer _x) then
		{
			[_x, _loadByName, _prefix] spawn aso_fnc_loadInventory;
		}
		else 
		{
			// for all AIs we want speed
			[_x, _loadByName, _prefix] call aso_fnc_loadInventory;
		};
		[_x, _loadByName, _prefix] call aso_fnc_loadPosition;
		[_x, _loadByName, _prefix, _ifIsDead] call aso_fnc_loadHealth;
		[_x, _loadByName, _prefix] call aso_fnc_loadMount;
		[_x, _loadByName, _prefix] call aso_fnc_loadExplosives;
	}
	else
	{
		if (ASO_USE_TFR && isPlayer _x) then
		{
			[_x, _loadByName, _prefix] remoteExec ["aso_fnc_loadInventory", 2, false]; // Call this on the server
		}
		else
		{
			[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadInventory", 2, false]; // Call this on the server
		};
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadPosition", 2, false]; // Call this on the server
		[_x, _loadByName, _prefix, _ifIsDead] remoteExecCall ["aso_fnc_loadHealth", 2, false]; // Call this on the server
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadMount", 2, false]; // Call this on the server
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadExplosives", 2, false]; // Call this on the server
	};		
} forEach _units;
