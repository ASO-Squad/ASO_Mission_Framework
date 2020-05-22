/* ----------------------------------------------------------------------------
Description:
    Collects this vehicle for further processing

Parameters:
    _vehicle	- A vehicle.

Returns:
    nothing

Example:
    [this] call aso_fnc_collectVehicle;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_vehicle"];

// Get out, there is nothing to do
if (isNil "_vehicle") exitWith {false;};

// Save vehicle name
private _name = [_vehicle] call aso_fnc_setVehicleName;

// Check for unnamed object
private _return = false;
if (_name == "*NoNameV*") then 
{
    hint parseText "<t size='1.2' color='#ff0000'>Unnamed Vehicle Found</t><br/>
                    <t align='left'>You tried to collect a unnamed vehicle. You must name all vehicles you want to collect!</t>";
    _return = false;
}
else 
{
    // Keep this vehicle in mind for saving
    ASO_VEHICLES pushBackUnique _vehicle;
    _return = true;
};
_return;