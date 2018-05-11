/* ----------------------------------------------------------------------------
Description:
    Loads the the cargos of the given objects, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _objects		- The objects that we want to load the cargos of
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_objects, _prefix] call aso_fnc_executeLoadCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

if ((count _this) > 2) then 
{
	_params = (_this select 3); // Parameters are here when this code is called from an action
} else
{
	_params = _this;
};
_objects = (_params select 0);
_prefix = (_params select 1);
{
	if (isServer) then
	{
		[_x, _prefix] call aso_fnc_loadCargo;
	}
	else
	{
		[_x, _prefix] remoteExecCall ["aso_fnc_loadCargo", 2, false]; // Call this on the server
	};	
} forEach _objects;