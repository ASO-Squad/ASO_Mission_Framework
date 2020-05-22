/* ----------------------------------------------------------------------------
Description:
    Pushes this crate ASO_CRATES for further processing

Parameters:
    _crate	- A Crate 

Returns:
    nothing

Example:
    [this] call aso_fnc_collectCrate;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_crate"];

// Get out, there is nothing to do
if (isNil "_crate") exitWith {};

// save objects name
private _name = [_object] call aso_fnc_setVehicleName;

// Check for unnamed object
private _return = false;
if (_name == "*NoNameV*") then 
{
    hint parseText "<t size='1.2' color='#ff0000'>Unnamed Crate Found</t><br/>
                    <t align='left'>You tried to collect a unnamed crate. You must name all crate you want to collect!</t>";
    _return = true;
}
else 
{
    // Keep this crate in mind for saving
    ASO_CRATES pushBackUnique _crate;
    _return = false;
};
_return;