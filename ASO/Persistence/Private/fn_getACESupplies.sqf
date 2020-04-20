/* ----------------------------------------------------------------------------
Description:
    Gets the (ACE) supplies of the given object.

Parameters:
    _obj			- The object that we want to keep the cargo of

Returns:
    Supply array [ammo, fuel, fuelLevel, _cargo]

Example:
    [_obj] call aso_fnc_getACESupplies;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_obj"];

// Collecting supplies
_ammo = [_obj] call ace_rearm_fnc_getSupplyCount;
_fuel = [_obj] call ace_refuel_fnc_getFuel;
_cargo = _obj getVariable ["ace_cargo_loaded", []];
_fuelLevel = fuel _obj;

[_ammo, _fuel, _fuelLevel, _cargo];