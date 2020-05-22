/* ----------------------------------------------------------------------------
Description:
    Remotly executes all function that are needed to save a object state.
	That includes:
	- Position
	- Damage
	- Cargo
	- Variables

Parameters:
    _objects		- The object that we want to save.

Returns:
    nothing

Example:
    [_objects] call aso_fnc_executeSaveObject;

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
	private _position = [_x] call aso_fnc_getPosition;
	private _items = [_x] call aso_fnc_getCargo;
	private _damage = [_x] call aso_fnc_getDamage;
	private _var = [_x] call aso_fnc_getVariables;
		
	// save the stuff
	["Objects", _dbName, "Position", _position] call aso_fnc_writeValue;
	["Objects", _dbName, "Items", _items] call aso_fnc_writeValue;
	["Objects", _dbName, "Damage", _damage] call aso_fnc_writeValue;
	["Objects", _dbName, "Variables", _var] call aso_fnc_writeValue;
	
} forEach _objects;