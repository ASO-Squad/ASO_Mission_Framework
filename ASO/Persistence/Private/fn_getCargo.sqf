/* ----------------------------------------------------------------------------
Description:
    gets the cargos of the given object.

Parameters:
    _obj			- The object that we want to keep the cargo of

Returns:
    Cargo array

Example:
    [_obj] call aso_fnc_getCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_obj"];

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

[_magazines, _weapons, _items, _containers];