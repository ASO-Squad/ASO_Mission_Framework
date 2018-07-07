/* ----------------------------------------------------------------------------
Description:
    Saves the cargos of the given object, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _obj			- The object that we want to keep the cargos of
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_obj, _prefix] call aso_fnc_saveCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_obj", "_prefix"];

// Use the appropriate name for the database 
_db = [_obj, true] call aso_fnc_getDbName;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Cargo"] call _inidbi; // cleanup

// Collecting cargo
_magazines = magazinesAmmoCargo _obj;
_weapons = weaponsItemsCargo _obj;
_items = itemCargo _obj;
// itemCargo needs some extra care 
if (isNil "_items") then 
{
	_items = [];
};
// Look for stuff in containers (we do not need for stuff in contianers that are in containers because arma does not allow that)
_containerList = [];
_containers = [];
{ 
	_class = (_x select 0);
	_container = (_x select 1);
	_containerList pushBack (_class);
	// Looking for cargo 
	_mags = magazinesAmmoCargo _container;
	_guns = weaponsItemsCargo _container;
	_stuff = itemCargo _container; 
	_containers pushBack [_class, _mags, _guns, _stuff];
  
} forEach (everyContainer _obj);
// We need to handle containers differently than normal items
_items = _items-_containerList;

// Write cargo to iniDB
["write", ["Cargo", "Magazines", _magazines]] call _inidbi;
["write", ["Cargo", "Weapons", _weapons]] call _inidbi;
["write", ["Cargo", "Items", _items]] call _inidbi;
["write", ["Cargo", "Containers", _containers]] call _inidbi;
true;