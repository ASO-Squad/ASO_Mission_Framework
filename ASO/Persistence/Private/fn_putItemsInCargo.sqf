/* ----------------------------------------------------------------------------
Description:
    Puts Items in a cargo container

Parameters:
    _obj	- Cargo Container
	_items	- Items array

Returns:
    nothing

Example:
    [_obj, _items] call aso_fnc_putItemsInCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_obj", "_items"];
// Adding items
{
	_obj addItemCargoGlobal [_x, 1];
} forEach _items;