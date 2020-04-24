/* ----------------------------------------------------------------------------
Description:
    Returns the full inventory for the given unit.
	The unit in question should be of the type MEN.

Parameters:
    _unit			- The unit that we want to keep the inventory of

Returns:
    Inventory Array

Example:
    [_unit] call aso_fnc_getInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Using getUnitLoadout for inventory of infantry units
private _fullInventory = getUnitLoadout _unit;

// Check for Earplugs
private _earplugs = [_unit] call ace_hearing_fnc_hasEarPlugsIn;

[_fullInventory, _earplugs];