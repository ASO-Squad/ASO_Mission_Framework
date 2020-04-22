/* ----------------------------------------------------------------------------
Description:
    Gets all markers created by users
	TODO: Save information on locality of the marker. 
	Right now all markers are saved and loaded from global.

Parameters:
    _all			- If true, every marker is saved, not just the ones beginning with "_USER_DEFINED"
					If you use this option, make sure to not place any markers with the editor, 
					because this will blow up very quickly with double and triple markers.

Returns:
    nothing

Example:
    [false] call aso_fnc_getMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_all", "_prefix"];

// get markers
private _markers = allMapMarkers;
private _index = -1;
private _return = [];
{
	private _name = _x;
	private _pos = getMarkerPos _x;
	private _size = getMarkerSize _x;
	private _color = getMarkerColor _x;
	private _type = getMarkerType _x;
	private _alpha = markerAlpha _x;
	private _text = markerText _x;
	private _dir = markerDir _x;
	private _shape = markerShape _x;
	private _ud = _x splitString " ";
	if ((_ud select 0) == "_USER_DEFINED") then
	{
		_index = _index + 1;
		_return append [[format["Marker%1",_index],  [_name, _pos, _size, _color, _type, _alpha, _text, _dir, _shape]]];	
	}
	else
	{
		if (_all) then
		{
			_index = _index + 1;
			_return append [[format["Marker%1",_index],  [_name, _pos, _size, _color, _type, _alpha, _text, _dir, _shape]]];	
		};
	};
	
} forEach _markers;

_return;