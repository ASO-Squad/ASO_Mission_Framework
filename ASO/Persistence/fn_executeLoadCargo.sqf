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
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};
params ["_objects", ["_prefix", ASO_PREFIX]];
{
	private _dbName = [_x, true] call aso_fnc_getDbName;
	private _items = ["Cargo", _dbName, "Items"] call aso_fnc_readValue;
	[_x, _items] call aso_fnc_setCargo;
} forEach _objects;