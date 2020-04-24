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
Returns:
    nothing

Example:
    [_vehicles] call aso_fnc_executeLoadVehicle;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_vehicles"];

if (count _vehicles == 0) then
{
	_vehicles = vehicles;
};
{
	private _dbName = [_x, _saveByName] call aso_fnc_getDbName;
	if (isServer) then
	{
		private _position = ["Vehicles", _dbName, "Position"] call aso_fnc_readValue;
		private _items = ["Vehicles", _dbName, "Items"] call aso_fnc_readValue;
		private _damage = ["Vehicles", _dbName, "Damage"] call aso_fnc_readValue;
		private _weapons = ["Vehicles", _dbName, "Weapons"] call aso_fnc_readValue;
		private _supplies = ["Vehicles", _dbName, "Supplies"] call aso_fnc_readValue;

		[_x, _position] call aso_fnc_setPosition;
		[_x, _items] call aso_fnc_setCargo;
		[_x, _damage] call aso_fnc_setDamage;
		[_x, _weapons] call aso_fnc_setWeapons;
		[_x, _supplies] call aso_fnc_setACESupplies;
	}
	else
	{	// Call those on the server 
		private _position = ["Vehicles", _dbName, "Position"] remoteExecCall ["aso_fnc_readValue", 2, false]; 
		private _items = ["Vehicles", _dbName, "Items"] remoteExecCall ["aso_fnc_readValue", 2, false];
		private _damage = ["Vehicles", _dbName, "Damage"] remoteExecCall ["aso_fnc_readValue", 2, false];	
		private _weapons = ["Vehicles", _dbName, "Weapons"] remoteExecCall ["aso_fnc_readValue", 2, false];
		private _supplies = ["Vehicles", _dbName, "Supplies"] remoteExecCall ["aso_fnc_readValue", 2, false];

		[_x, _position] remoteExecCall ["aso_fnc_setPosition", 2, false]; 
		[_x, _items] remoteExecCall ["aso_fnc_setCargo", 2, false];
		[_x, _damage] remoteExecCall ["aso_fnc_setDamage", 2, false];
		[_x, _weapons] remoteExecCall ["aso_fnc_setWeapons", 2, false];
		[_x, _supplies] remoteExecCall ["aso_fnc_setACESupplies", 2, false];
	};		
} forEach _vehicles;
