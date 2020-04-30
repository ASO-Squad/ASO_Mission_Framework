/* ----------------------------------------------------------------------------
Description:
    Saves all markers created by users, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _all			- If true, every marker is saved, not just the ones beginning with "_USER_DEFINED"
					If you use this option, make sure to not place any markers with the editor, 
					because this will blow up very quickly with double and triple markers.

Returns:
    nothing

Example:
    [false] call aso_fnc_executeSaveMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_all", false]];

private _markers = [_all] call aso_fnc_getMarkers;
{
	["Markers", _x select 0, "Marker", _x] call aso_fnc_writeValue;
} forEach _markers;
true;