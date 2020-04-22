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
private _magazines = magazinesAmmoCargo _obj;
private _weapons = weaponsItemsCargo _obj;
private _items = itemCargo _obj;
// itemCargo needs some extra care 
if (isNil "_items") then 
{
	_items = [];
};
// Look for stuff in containers (we do not need for stuff in contianers that are in containers because arma does not allow that)
private _containerList = [];
private _containers = [];
{ 
	private _class = (_x select 0);
	private _container = (_x select 1);
	_containerList pushBack (_class);
	// Looking for cargo 
	private _mags = magazinesAmmoCargo _container;
	private _guns = weaponsItemsCargo _container;
	private _stuff = itemCargo _container; 
	_containers pushBack [_class, _mags, _guns, _stuff];
  
} forEach (everyContainer _obj);
// We need to handle containers differently than normal items
_items = _items-_containerList;

[_magazines, _weapons, _items, _containers];