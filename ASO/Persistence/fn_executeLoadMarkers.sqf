/* ----------------------------------------------------------------------------
Description:
    Loads markers created by users, and does this with INIDBI2.
	TODO: Load information on locality of the marker. 
	Right now all markers are saved and loaded from global.

Parameters:
	none

Returns:
    nothing

Example:
    [] call aso_fnc_executeLoadMarkers;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

_database = format ["%1_%2", ASO_PREFIX, "Markers"];
_inidbi = ["new", _database] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {false};

private _sections = "getSections" call _inidbi;
private _markers = [];

{
	// preloading information
	private _marker = ["Markers", _x, "Marker"] call aso_fnc_readValue;
	_markers pushBack _marker;

} forEach _sections;

// Now create those markers
[_markers] call aso_fnc_setMarkers;
true;