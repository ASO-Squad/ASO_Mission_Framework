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
if (!isServer) exitWith {false;};

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
	
} forEach _vehicles;