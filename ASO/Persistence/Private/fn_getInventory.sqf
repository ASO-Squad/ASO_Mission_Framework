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
if (!isServer) exitWith {false;};

params ["_unit", ["_name", nil], ["_unitName", nil]];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {false};

// This does not seem to work properly in a dedicated environment the loadout does not gets propper updates over the network.
//private _fullInventory = getUnitLoadout _unit;

// Check for Earplugs
//private _earplugs = [_unit] call ace_hearing_fnc_hasEarPlugsIn;

//[_fullInventory, _earplugs];

// Workaround for the issue above
//[_unit, _name, _unitName] remoteExecCall ["aso_fnc_localInventory", _unit];
[_unit, _name, _unitName] remoteExecCall ["aso_fnc_localInventory", _unit];
true;