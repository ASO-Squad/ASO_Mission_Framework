/* ----------------------------------------------------------------------------
Description:
    Saves all markers created by users, and does this with INIDBI2.
	Files are written on the server machine.
	TODO: Save information on locality of the marker. 
	Right now all markers are saved and loaded from global.

Parameters:
    _all			- If true, every marker is saved, not just the ones beginning with "_USER_DEFINED"
					If you use this option, make sure to not place any markers with the editor, 
					because this will blow up very quickly with double and triple markers.
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [false, _prefix] call aso_fnc_saveMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_all", "_prefix"];

// Use the appropriate name for the database 
_db = "mapMarkers";

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "MarkerIndex"] call _inidbi; // cleanup
["deleteSection", "Markers"] call _inidbi; // cleanup

// get markers
_markers = allMapMarkers;
_index = -1;
{
	_name = _x;
	_pos = getMarkerPos _x;
	_size = getMarkerSize _x;
	_color = getMarkerColor _x;
	_type = getMarkerType _x;
	_alpha = markerAlpha _x;
	_text = markerText _x;
	_dir = markerDir _x;
	_shape = markerShape _x;
	_ud = _x splitString " ";
	if ((_ud select 0) == "_USER_DEFINED") then
	{
		_index = _index + 1;
		["write", ["Markers", format["Marker%1",_index], [_name, _pos, _size, _color, _type, _alpha, _text, _dir, _shape]]] call _inidbi;
	}
	else
	{
		if (_all) then
		{
			_index = _index + 1;
			["write", ["Markers", format["Marker%1",_index], [_name, _pos, _size, _color, _type, _alpha, _text, _dir, _shape]]] call _inidbi;
		};
	};
	
} forEach _markers;
// Write information down
["write", ["MarkerIndex", "Markers", _index]] call _inidbi;