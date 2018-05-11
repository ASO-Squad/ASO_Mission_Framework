/* ----------------------------------------------------------------------------
Description:
    Loads the the cargos of the given objects, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _objects		- The objects that we want to load the cargos of
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_objects, _prefix] call aso_fnc_executeLoadCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};
params ["_objects", ["_prefix", ASO_PREFIX]];
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