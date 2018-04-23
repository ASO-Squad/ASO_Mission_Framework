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
    [_prefix] call aso_fnc_loadMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_prefix"];

_db = "mapMarkers";
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};

_index = ["read", ["MarkerIndex", "Markers"]] call _inidbi;
// Draw markers
if (_index >= 0) then
{
	_i = 0;
	while {_i <= _index} do 
	{
		_info = ["read", ["Markers", format["Marker%1", _i]]] call _inidbi;
		
		_name = _info select 0;
		_pos = _info select 1;
		_size = _info select 2;
		_color = _info select 3;
		_type = _info select 4;
		_alpha = _info select 5;
		_text = _info select 6;
		_dir = _info select 7;
		_shape = _info select 8;

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