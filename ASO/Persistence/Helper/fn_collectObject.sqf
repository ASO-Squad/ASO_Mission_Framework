/* ----------------------------------------------------------------------------
Description:
    Collects this object for further processing

Parameters:
    _object     - A Object

Returns:
    nothing

Example:
    [_object] call aso_fnc_collectObject;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_object"];

// Get out, there is nothing to do
if (isNil "_object") exitWith {};

// save objects name
[_object] call aso_fnc_setVehicleName;

// Keep this group in mind for saving
ASO_OBJECTS pushBackUnique _object;