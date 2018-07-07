/* ----------------------------------------------------------------------------
Description:
    Pushes this crate ASO_CRATES for further processing

Parameters:
    _crate	- A Crate 

Returns:
    nothing

Example:
    [_crate] call aso_fnc_collectCrate;

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

// Keep this group in mind for saving
ASO_CRATES pushBackUnique _crate;