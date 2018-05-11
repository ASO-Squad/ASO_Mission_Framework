/* ----------------------------------------------------------------------------
Description:
    Loads markers created by users, and does this with INIDBI2.
	TODO: Load information on locality of the marker. 
	Right now all markers are saved and loaded from global.

Parameters:
   _prefix	- Prefix to be used for the database. This is usually used to identify different missions
			If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_prefix] call aso_fnc_executeLoadMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_prefix", ASO_PREFIX]];

if (isServer) then
{
	[_prefix] call aso_fnc_loadMarkers;
}
else
{
	[_prefix] remoteExecCall ["aso_fnc_loadMarkers", 2, false]; // Call this on the server
};