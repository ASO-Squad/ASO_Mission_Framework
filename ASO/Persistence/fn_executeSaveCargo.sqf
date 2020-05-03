/* ----------------------------------------------------------------------------
Description:
    Saves the cargos of the given object.

Parameters:
    _objects	- The objects that we want to keep the cargos of
	
Returns:
    nothing

Example:
    [_objects] call aso_fnc_executeSaveCargo;

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
	private _dbName = [_x, _saveByName] call aso_fnc_getDbName;
	private _items = [_x] call aso_fnc_getCargo;
	["Cargo", _dbName, "Items", _items] call aso_fnc_writeValue;
		
} forEach _objects;