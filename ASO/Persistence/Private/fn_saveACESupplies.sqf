/* ----------------------------------------------------------------------------
Description:
    Saves the ACE supplies of the given object, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _obj			- The object that we want to keep the cargo of
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_obj, _prefix] call aso_fnc_saveACESupplies;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_obj", "_prefix"];

// Use the appropriate name for the database 
_db = [_obj, true] call aso_fnc_getDbName;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Supplies"] call _inidbi; // cleanup

// Collecting supplies
_ammo = [_obj] call ace_rearm_fnc_getSupplyCount;
_fuel = [_obj] call ace_refuel_fnc_getFuel;
_cargo = _obj getVariable ["ace_cargo_loaded", []];
_fuelLevel = fuel _obj;

// Write supplies to iniDB
["write", ["Supplies", "Ammo", _ammo]] call _inidbi;
["write", ["Supplies", "Fuel", _fuel]] call _inidbi;
["write", ["Supplies", "Cargo", _cargo]] call _inidbi;
["write", ["Supplies", "FuelLevel", _fuelLevel]] call _inidbi;