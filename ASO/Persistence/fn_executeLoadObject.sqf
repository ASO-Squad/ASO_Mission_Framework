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
    _objects		- The array of objects that we want to load.
					
Returns:
    nothing

Example:
    [_objects] call aso_fnc_executeLoadVehicle;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_objects"];

{
	private _dbName = [_x, true] call aso_fnc_getDbName;
	private _position = ["Objects", _dbName, "Position"] call aso_fnc_readValue;
	private _items = ["Objects", _dbName, "Items"] call aso_fnc_readValue;
	private _damage = ["Objects", _dbName, "Damage"] call aso_fnc_readValue;
	private _var = ["Objects", _dbName, "Variables"] call aso_fnc_readValue;
	

	[_x, _position] call aso_fnc_setPosition;
	[_x, _items] call aso_fnc_setCargo;
	[_x, _damage] call aso_fnc_setDamage;
	[_x, _var] call aso_fnc_setVariables;
		
} forEach _objects;
