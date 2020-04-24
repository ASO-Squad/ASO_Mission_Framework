/* ----------------------------------------------------------------------------
Description:
    Loads the the cargos of the given objects.

Parameters:
    _objects	- The objects that we want to load the cargos of

Returns:
    nothing

Example:
    [_objects] call aso_fnc_executeLoadCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};
params ["_objects", ["_prefix", ASO_PREFIX]];
{
	private _dbName = [_x, _saveByName] call aso_fnc_getDbName;
	if (isServer) then
	{
		private _items = ["Cargo", _dbName, "Items"] call aso_fnc_readValue;
		[_x, _items] call aso_fnc_setCargo;
	}
	else
	{
		private _items = ["Cargo", _dbName, "Items"] remoteExecCall ["aso_fnc_readValue", 2, false];
		[_x, _items] remoteExecCall ["aso_fnc_setCargo", 2, false];
	};	
} forEach _objects;