/* ----------------------------------------------------------------------------
Description:
    Remotly executes all function that are needed to save a vehicle state.
	That includes:
	- Position
	- Damage
	- Weapons
	- Ammo 
	- Cargo (Items, Repair, Fuel)
	- Fuel

Parameters:
    _vehicles		- The vehicles that we want to save.
					If you leave this array empty, all vehicles get saved. 
					Make sure that all vehicles have names to use this feature properly

Returns:
    nothing

Example:
    [_vehicles] call aso_fnc_executeSaveVehicle;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};
params ["_vehicles"];

// If the array is empty, save all vehicles
if (count _vehicles == 0) then
{
	_vehicles = vehicles;
};

{
	private _dbName = [_x, _saveByName] call aso_fnc_getDbName;
	if (isServer) then
	{
		private _position = [_x] call aso_fnc_getPosition;
		private _items = [_x] call aso_fnc_getCargo;
		private _damage = [_x] call aso_fnc_getDamage;
		private _weapons = [_x] call aso_fnc_getWeapons;
		private _supplies = [_x] call aso_fnc_getACESupplies;
		// save the stuff
		["Vehicles", _dbName, "Position", _position] call aso_fnc_writeValue;
		["Vehicles", _dbName, "Items", _items] call aso_fnc_writeValue;
		["Vehicles", _dbName, "Damage", _damage] call aso_fnc_writeValue;
		["Vehicles", _dbName, "Weapons", _weapons] call aso_fnc_writeValue;
		["Vehicles", _dbName, "Supplies", _supplies] call aso_fnc_writeValue;
	}
	else
	{	// Call those on the server 
		private _position = [_x] remoteExecCall ["aso_fnc_getPosition", 2, false]; 
		private _items = [_x] remoteExecCall ["aso_fnc_getCargo", 2, false];
		private _damage = [_x] remoteExecCall ["aso_fnc_getDamage", 2, false];
		private _weapons = [_x] remoteExecCall ["aso_fnc_getWeapons", 2, false];
		private _supplies = [_x] remoteExecCall ["aso_fnc_getACESupplies", 2, false];

		// save the stuff
		["Vehicles", _dbName, "Position", _position] remoteExecCall ["aso_fnc_writeValue", 2, false]; 
		["Vehicles", _dbName, "Items", _items] remoteExecCall ["aso_fnc_writeValue", 2, false];
		["Vehicles", _dbName, "Damage", _damage] remoteExecCall ["aso_fnc_writeValue", 2, false];	
		["Vehicles", _dbName, "Weapons", _weapons] remoteExecCall ["aso_fnc_writeValue", 2, false];
		["Vehicles", _dbName, "Supplies", _supplies] remoteExecCall ["aso_fnc_writeValue", 2, false];
	};	
} forEach _vehicles;