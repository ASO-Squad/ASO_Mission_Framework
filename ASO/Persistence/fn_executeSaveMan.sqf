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
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_units, false, _prefix] call aso_fnc_executeSaveMan;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];
if ((count _this) > 3) then 
{
	_params = (_this select 3); // Parameters are here when this code is called from an action
} else
{
	_params = _this;
};
_units = (_params select 0);
_saveByName = (_params select 1);
_prefix = (_params select 2);
if (count _units == 0) then
{
	_units = allPlayers;
};
// If the unit array is empty, save all players
{
	if (isServer) then
	{
		[_x, _saveByName, _prefix] call aso_fnc_saveInventory;
		[_x, _saveByName, _prefix] call aso_fnc_savePosition;
		[_x, _saveByName, _prefix] call aso_fnc_saveHealth;
		[_x, _saveByName, _prefix] call aso_fnc_saveMount;
		[_x, _saveByName, _prefix] call aso_fnc_saveExplosives;
	}
	else
	{
		[_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_saveInventory", 2, false]; // Call this on the server
		[_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_savePosition", 2, false]; // Call this on the server
		[_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_saveHealth", 2, false]; // Call this on the server
		[_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_saveMount", 2, false]; // Call this on the server
		[_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_saveExplosives", 2, false]; // Call this on the server
	};		
} forEach _units;