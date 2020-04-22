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

private _index = count _markers;
// Draw markers
if (_index >= 0) then
{
	private _i = 0;
	while {_i < _index} do 
	{
		private _info = _markers select _i;
		// Extract name
		private _name = _info select 0;
		// Extract additional info
		private _additional = _info select 1;
		private _pos = _additional select 1;
		private _size = _additional select 2;
		private _color = _additional select 3;
		private _type = _additional select 4;
		private _alpha = _additional select 5;
		private _text = _additional select 6;
		private _dir = _additional select 7;
		private _shape = _additional select 8;
		// Marker is created here
		private _marker = createMarker [_name,_pos];
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