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
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_vehicles, _prefix] call aso_fnc_executeSaveVehicle;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};
params ["_vehicles", ["_prefix", ASO_PREFIX]];

if (count _vehicles == 0) then
{
	_vehicles = vehicles;
};
// If the array is empty, save all vehicles
{
	if (isServer) then
	{
		[_x, true, _prefix] call aso_fnc_savePosition;
		[_x, _prefix] call aso_fnc_saveCargo;
		[_x, _prefix] call aso_fnc_saveDamage;
		[_x, _prefix] call aso_fnc_saveWeapons;
		[_x, _prefix] call aso_fnc_saveACESupplies;
	}
	else
	{	// Call those on the server 
		[_x, true, _prefix] remoteExecCall ["aso_fnc_savePosition", 2, false]; 
		[_x, _prefix] remoteExecCall ["aso_fnc_saveCargo", 2, false];
		[_x, _prefix] remoteExecCall ["aso_fnc_saveDamage", 2, false];
		[_x, _prefix] remoteExecCall ["aso_fnc_saveWeapons", 2, false];
		[_x, _prefix] remoteExecCall ["aso_fnc_saveACESupplies", 2, false];
	};		
} forEach _vehicles;