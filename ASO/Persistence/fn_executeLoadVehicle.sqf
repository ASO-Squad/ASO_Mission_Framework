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
					If you don not provide a prefix, ASO_PREFIX will be used. 
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

params ["_vehicles", ["_prefix", ASO_PREFIX]];

if (count _vehicles == 0) then
{
	_vehicles = vehicles;
};
{
	if (isServer) then
	{
		[(vehicle _x), false, _prefix, "", true] call aso_fnc_loadPosition;
		[(vehicle _x), _prefix] call aso_fnc_loadCargo;
		[(vehicle _x), _prefix] call aso_fnc_loadDamage;
		[(vehicle _x), _prefix] call aso_fnc_loadWeapons;
		[(vehicle _x), _prefix] call aso_fnc_loadACESupplies;
	}
	else
	{
		[(vehicle _x), false, _prefix, "", true] remoteExecCall ["aso_fnc_loadPosition", 2, false]; // Call this on the server
		[(vehicle _x), _prefix] remoteExecCall ["aso_fnc_LoadCargo", 2, false]; // Call this on the server
		[(vehicle _x), _prefix] remoteExecCall ["aso_fnc_LoadDamage", 2, false]; // Call this on the server
		[(vehicle _x), _prefix] remoteExecCall ["aso_fnc_LoadWeapons", 2, false]; // Call this on the server
		[(vehicle _x), _prefix] remoteExecCall ["aso_fnc_LoadACESupplies", 2, false]; // Call this on the server
	};		
} forEach _vehicles;
