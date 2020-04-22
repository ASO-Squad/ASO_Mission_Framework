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

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_objects"];

{
	private _dbName = [_x, _saveByName] call aso_fnc_getDbName;
	if (isServer) then
	{
		private _items = [_x] call aso_fnc_getCargo;
		["Cargo", _dbName, "Items", _items] call aso_fnc_writeValue;
	}
	else
	{
		private _items = [_x] remoteExecCall ["aso_fnc_getCargo", 2, false];
		["Cargo", _dbName, "Items", _items] remoteExecCall ["aso_fnc_writeValue", 2, false];
	};	
} forEach _objects;