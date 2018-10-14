/* ----------------------------------------------------------------------------
Description:
    Collects this vehicle for further processing

Parameters:
    _vehicle	- A vehicle.

Returns:
    nothing

Example:
    [_vehicle] call aso_fnc_collectVehicle;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_vehicle"];

// Get out, there is nothing to do
if (isNil "_vehicle") exitWith {};

// Save vehicle name
[_vehicle] call aso_fnc_setVehicleName;

// Keep this group in mind for saving
ASO_VEHICLES pushBackUnique _vehicle;