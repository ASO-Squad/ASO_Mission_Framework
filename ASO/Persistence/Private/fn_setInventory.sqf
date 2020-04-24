/* ----------------------------------------------------------------------------
Description:
    Sets the inventory for the given unit.
	The unit in question should be of the type MEN.

Parameters:
    _unit			- The unit that we want to load the inventory of
	_inventory		- The inventory array

Returns:
    nothing

Example:
    [_unit, _inventory] call aso_fnc_setInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_inventory"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Restoring inventory
private _fullInventory = _inventory select 0;
private _earplugs = _inventory select 1;

// Use earplugs if needed
if (_earplugs) then
{
	[_unit] call ace_hearing_fnc_putInEarplugs;
};

// Wait for TFR if we can and only if the unit is a player (fuck those AI radios!)
if (ASO_USE_TFR) then
{
	if (canSuspend && isPlayer _unit) then
	{
		_tfr = _unit getVariable ["tfar_handlersset", false];
		while {!_tfr} do 
		{
			sleep 1;
			_tfr = _unit getVariable ["tfar_handlersset", false];
		};
	};
};

// Apply loadout 
_unit setUnitLoadout [_fullInventory, false];
true;
