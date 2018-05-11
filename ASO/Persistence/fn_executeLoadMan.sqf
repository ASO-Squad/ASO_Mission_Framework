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
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
	_ifIsDead		- What to do if the unit is dead.
					If this is an object, the unit will be transported there
					If it is a bool: true  means, it will stay dead.
									 false means, the unit will wke up with half its previous damage.

Returns:
    nothing

Example:
    [_units, false, _prefix, false] call aso_fnc_executeLoadMan;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

if (typeName (_this select 3) == "ARRAY") then 
{
	// We come from a action
	_params = (_this select 3); // Parameters are here when this code is called from an action
} else
{
	_params = _this;
};
_units = (_params select 0);
_loadByName = (_params select 1);
_prefix = (_params select 2);
_ifIsDead = (_params select 3);
if (count _units == 0) then
{
	_units = allPlayers;
};
// If the unit array is empty, load all players
{
	if (isServer) then
	{
		[_x, _loadByName, _prefix] call aso_fnc_loadInventory;
		[_x, _loadByName, _prefix] call aso_fnc_loadPosition;
		[_x, _loadByName, _prefix, _ifIsDead] call aso_fnc_loadHealth;
		[_x, _loadByName, _prefix] call aso_fnc_loadMount;
		[_x, _loadByName, _prefix] call aso_fnc_loadExplosives;
	}
	else
	{
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadInventory", 2, false]; // Call this on the server
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadPosition", 2, false]; // Call this on the server
		[_x, _loadByName, _prefix, _ifIsDead] remoteExecCall ["aso_fnc_loadHealth", 2, false]; // Call this on the server
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadMount", 2, false]; // Call this on the server
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadExplosives", 2, false]; // Call this on the server
	};		
} forEach _units;
