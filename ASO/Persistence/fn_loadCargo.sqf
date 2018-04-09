/* ----------------------------------------------------------------------------
Description:
    Loads the cargo for the given object, and does this with INIDBI2.
	Files are loaded from the server machine.

Parameters:
    _obj			- The object  that we want to load the cargo of
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_obj, _prefix] call aso_fnc_loadCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_obj", "_prefix"];

// Use the appropriate name for the database 
_db = vehicleVarName _obj;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};

// Empty cargo space 
clearItemCargoGlobal _obj;
clearMagazineCargoGlobal _obj;
clearWeaponCargoGlobal _obj;
clearBackpackCargoGlobal _obj;

// reading categories
_magazines = ["read", ["Cargo", "Magazines"]] call _inidbi;
_weapons = ["read", ["Cargo", "Weapons"]] call _inidbi;
_items = ["read", ["Cargo", "Items"]] call _inidbi;
_containers = ["read", ["Cargo", "Containers"]] call _inidbi;

// Apply Cargo 
[_obj, _magazines] call aso_fnc_putMagazinesInCargo;
[_obj, _weapons] call aso_fnc_putWeaponsInCargo;
[_obj, _items] call aso_fnc_putItemsInCargo;

// Adding Containers
{
	_obj addItemCargoGlobal [(_x select 0), 1];	
} forEach _containers;
_newContainers = everyContainer _obj;

if ((count _newContainers) == (count _containers)) then
{
	// Filling Containers 
	{
		_container = (_containers select _forEachIndex);
		_mags = (_container select 1);
		_guns = (_container select 2);
		_stuff = (_container select 3);

		[(_x select 1), _mags] call aso_fnc_putMagazinesInCargo;
		[(_x select 1), _guns] call aso_fnc_putWeaponsInCargo;
		[(_x select 1), _stuff] call aso_fnc_putItemsInCargo;
		
	} forEach _newContainers;
};
true;