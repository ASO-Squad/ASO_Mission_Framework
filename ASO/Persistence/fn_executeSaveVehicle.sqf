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

Returns:
    nothing

Example:
    [_vehicles, _prefix] call aso_fnc_executeSaveVehicle;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];
if ((count _this) > 2) then 
{
	_params = (_this select 3); // Parameters are here when this code is called from an action
} else
{
	_params = _this;
};
_vehicles = (_params select 0);
_prefix = (_params select 1);
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
	}
	else
	{
		[_x, true, _prefix] remoteExecCall ["aso_fnc_savePosition", 2, false]; // Call this on the server
		[_x, _prefix] remoteExecCall ["aso_fnc_saveCargo", 2, false]; // Call this on the server
		[_x, _prefix] remoteExecCall ["aso_fnc_saveDamage", 2, false]; // Call this on the server
	};		
} forEach _vehicles;