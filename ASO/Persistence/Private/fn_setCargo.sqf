/* ----------------------------------------------------------------------------
Description:
    Sets the cargo load for the given object.

Parameters:
    _obj			- The object  that we want to load the cargo of
	_cargo 			- Cargo Array

Returns:
    nothing

Example:
    [_obj] call aso_fnc_setCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_obj", "_cargo"];


// Empty cargo space 
clearItemCargoGlobal _obj;
clearMagazineCargoGlobal _obj;
clearWeaponCargoGlobal _obj;
clearBackpackCargoGlobal _obj;

// reading categories
_magazines = _cargo select 0;
_weapons = _cargo select 1;
_items = _cargo select 2;
_containers = _cargo select 3;

// Apply Cargo 
[_obj, _magazines] call aso_fnc_putMagazinesInCargo;
[_obj, _weapons] call aso_fnc_putWeaponsInCargo;
[_obj, _items] call aso_fnc_putItemsInCargo;
if (typeName _containers == "ARRAY") then
{
	// Adding Containers
	{
		_class = (_x select 0);
		if (_class isKindOf "Bag_Base") then
		{
			_obj addBackpackCargoGlobal [(_x select 0), 1];
		}
		else
		{
			_obj addItemCargoGlobal [(_x select 0), 1];	
		}
	} forEach _containers;
}
else
{
 	_containers = [];
};
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