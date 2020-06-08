/* ----------------------------------------------------------------------------
Description:
    retrieves a inventory array localy and calls save inventory with the result.

Parameters:
    _unit			- The unit that we want to keep the inventory of
    _name           - Where do we want to write?

Returns:
    nothing

Example:
    [this, name] call aso_fnc_localInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_unit", ["_file", "Men"], ["_section", nil]];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

private _fullInventory = getUnitLoadout _unit;
private _earplugs = [_unit] call ace_hearing_fnc_hasEarPlugsIn;
private _inventory = [_fullInventory, _earplugs];

if (isNil "_section") then 
{
    [_file, _unit, "Inventory", _inventory] remoteExecCall ["aso_fnc_writeValue", 2];
}
else
{
    [_file, _section, "Inventory", _inventory] remoteExecCall ["aso_fnc_writeValue", 2];
};