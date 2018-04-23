/* ----------------------------------------------------------------------------
Description:
    Saves all markers created by users, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _all			- If true, every marker is saved, not just the ones beginning with "_USER_DEFINED"
					If you use this option, make sure to not place any markers with the editor, 
					because this will blow up very quickly with double and triple markers.
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [false, _prefix] call aso_fnc_executeSaveMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
_params = [];
if ((count _this) > 2) then 
{
	_params = (_this select 3); // Parameters are here when this code is called from an action
} else
{
	_params = _this;
};
_all = (_params select 0);
_prefix = (_params select 1);
if (isServer) then
{
	[_all, _prefix] call aso_fnc_saveMarkers;
}
else
{
	[_all, _prefix] remoteExecCall ["aso_fnc_saveMarkers", 2, false]; // Call this on the server
};