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
if (!isServer) exitWith {false;};

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
	private _dbName = [_x, true] call aso_fnc_getDbName;
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
	
} forEach _vehicles;
