/* ----------------------------------------------------------------------------
Description:
    Remotly executes all function that are needed to load a vehicle state.
	That includes:
	- Position
	- Damage
	- Weapons
	- Ammo 
	- Cargo (Items, Repair, Fuel)
	- Fuel

Parameters:
    _vehicles		- The units that we want to load.
					If you leave this array empty, all vehicles get load.
					Make sure that all vehicles have names to use this feature properly.
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_vehicles, _prefix] call aso_fnc_executeLoadVehicle;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

if ((count _this) > 3) then 
{
	_params = (_this select 3); // Parameters are here when this code is called from an action
} else
{
	_params = _this;
};
_vehicles = (_params select 0);
_loadByName = (_params select 1);
_prefix = (_params select 2);
if (count _vehicles == 0) then
{
	_vehicles = vehicles;
};
{
	if (isServer) then
	{
		[_x, _loadByName, _prefix] call aso_fnc_loadPosition;
		[_x, _prefix] call aso_fnc_loadCargo;
		[_x, _prefix] call aso_fnc_loadDamage;
		[_x, _prefix] call aso_fnc_loadWeapons;
		[_x, _prefix] call aso_fnc_loadACESupplies;
	}
	else
	{
		[_x, _loadByName, _prefix] remoteExecCall ["aso_fnc_loadPosition", 2, false]; // Call this on the server
		[_x, _prefix] remoteExecCall ["aso_fnc_LoadCargo", 2, false]; // Call this on the server
		[_x, _prefix] remoteExecCall ["aso_fnc_LoadDamage", 2, false]; // Call this on the server
		[_x, _prefix] remoteExecCall ["aso_fnc_LoadWeapons", 2, false]; // Call this on the server
		[_x, _prefix] remoteExecCall ["aso_fnc_LoadACESupplies", 2, false]; // Call this on the server
	};		
} forEach _vehicles;
