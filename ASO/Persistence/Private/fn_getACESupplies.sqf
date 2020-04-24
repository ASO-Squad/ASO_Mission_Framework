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
private _ammo = [_obj] call ace_rearm_fnc_getSupplyCount;
private _fuel = [_obj] call ace_refuel_fnc_getFuel;
private _cargoList = _obj getVariable ["ace_cargo_loaded", []];
private _cargo = [];
{
    // If we put Items back, we get an object that needs extra handling
    _c = _x;
    if (typeName _x == "OBJECT") then 
    {
        _c = typeOf _x;
    };
    _cargo pushBack _c;
} forEach _cargoList;

private _fuelLevel = fuel _obj;

[_ammo, _fuel, _fuelLevel, _cargo];