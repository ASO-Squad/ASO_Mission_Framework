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

// Check for unnamed object
private _return = false;
if (_name == "*NoNameV*") then 
{
    hint parseText "<t size='1.2' color='#ff0000'>Unnamed Object Found</t><br/>
                    <t align='left'>You tried to collect a unnamed object. You must name all objects you want to collect!</t>";
    _return = true;
}
else 
{
    // Keep this object in mind for saving
    ASO_OBJECTS pushBackUnique _object;
    _return = false;
};
_return;