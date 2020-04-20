/* ----------------------------------------------------------------------------
Description:
    Sets markers created by users.
	TODO: Load information on locality of the marker. 
	Right now all markers are saved and loaded from global.

Parameters:
    _markers 	- Markers array

Returns:
    nothing

Example:
    [_markers] call aso_fnc_setMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_markers"];

_index = count _markers;
// Draw markers
if (_index >= 0) then
{
	_i = 0;
	while {_i < _index} do 
	{
		_info = _markers select _i;
		// Extract name
		_name = _info select 0;
		// Extract additional info
		_additional = _info select 1;
		_pos = _additional select 1;
		_size = _additional select 2;
		_color = _additional select 3;
		_type = _additional select 4;
		_alpha = _additional select 5;
		_text = _additional select 6;
		_dir = _additional select 7;
		_shape = _additional select 8;
		// Marker is created here
		_marker = createMarker [_name,_pos];
		_marker setMarkerSize _size;
		_marker setMarkerColor _color;
		_marker setMarkerType _type;
		_marker setMarkerAlpha _alpha;
		_marker setMarkerText _text;
		_marker setMarkerDir _dir;
		_marker setMarkerShape _shape;

		_i = _i + 1;	
	};
};