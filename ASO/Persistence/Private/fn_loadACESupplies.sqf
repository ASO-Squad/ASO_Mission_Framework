/* ----------------------------------------------------------------------------
Description:
    Loads the ACE supplies for the given object, and does this with INIDBI2.
	Files are loaded from the server machine.

Parameters:
    _obj			- The object that we want to load the supplies of
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_obj, _prefix] call aso_fnc_loadSupplies;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_obj", "_prefix"];

// Use the appropriate name for the database 
_db = [_obj, true] call aso_fnc_getDbName;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};

// reading categories
_ammo = ["read", ["Supplies", "Ammo"]] call _inidbi;
_fuel = ["read", ["Supplies", "Fuel"]] call _inidbi;
_cargo = ["read", ["Supplies", "Cargo"]] call _inidbi;
_fuelLevel = ["read", ["Supplies", "FuelLevel"]] call _inidbi;

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
