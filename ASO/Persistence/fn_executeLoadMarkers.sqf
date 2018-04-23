/* ----------------------------------------------------------------------------
Description:
    Loads markers created by users, and does this with INIDBI2.
	TODO: Load information on locality of the marker. 
	Right now all markers are saved and loaded from global.

Parameters:
    _prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_prefix] call aso_fnc_executeLoadMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];
if ((count _this) > 1) then 
{
	_params = (_this select 3); // Parameters are here when this code is called from an action
} else
{
	_params = _this;
};
_prefix = (_params select 0);
if (isServer) then
{
	[_prefix] call aso_fnc_loadMarkers;
}
else
{
	[_prefix] remoteExecCall ["aso_fnc_loadMarkers", 2, false]; // Call this on the server
};