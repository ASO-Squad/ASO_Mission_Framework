/* ----------------------------------------------------------------------------
Description:
    Applies the inventory provided by the server, to the local player.
	REMARK: This should be called remotly from the server

Parameters:
    _unit		- The unit that we want to apply the inventory to
	_basics		- Basic stuff like uniforms, backpacks, goggles and other items	

Returns:
    nothing

Example:
    [_unit, _basics] call aso_fnc_applyInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_unit", "_basics"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// remove all items from the player
removeAllItemsWithMagazines _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeHeadgear _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;

// Adding basic stuff
//_basics = [_headgear, _goggles, _items, _binocular, _uniform, _vest, _backpack];
_unit AddHeadgear (_basics select 0);
_unit AddGoggles (_basics select 1);
{
	_unit linkItem _x;	
} forEach (_basics select 2);
_unit addWeapon (_basics select 3);;
_unit forceAddUniform (_basics select 4);
_unit addVest (_basics select 5);
_unit addBackpack (_basics select 6);
_basics;