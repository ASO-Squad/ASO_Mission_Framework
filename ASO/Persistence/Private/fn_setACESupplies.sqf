/* ----------------------------------------------------------------------------
Description:
    Sets the (ACE) supplies for the given object

Parameters:
    _obj			- The object that we want to set the supplies of
    _supplies       - A Supply array

Returns:
    nothing

Example:
    [_obj, _supplies] call aso_fnc_loadSupplies;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_obj", "_supplies"];

// reading categories
_ammo = _supplies select 0;
_fuel = _supplies select 1;
_fuelLevel = _supplies select 2;
_cargo = _supplies select 3;

// Remove cargo already present
_obj setVariable ["ace_cargo_loaded", [], true];

// Apply supplies
[_obj, _ammo] call ace_rearm_fnc_setSupplyCount;
[_obj, _fuel] call ace_refuel_fnc_setFuel;
_obj setVariable ["ace_cargo_loaded", _cargo, true];

// Apply data
if (local _obj) then
{
	_obj setFuel _fuelLevel;
}
else
{
	[_obj, _fuelLevel] remoteExec ["setFuel", _obj, false]; // needs local parameters
};
true;
