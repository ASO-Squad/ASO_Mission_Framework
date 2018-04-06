/* ----------------------------------------------------------------------------
Description:
    Loads the inventory for the given unit, and does this with INIDBI2.
	InventoryFiles are loaded from the server machine.
	The unit in question should be of the type MEN.

Parameters:
    _unit			- The unit that we want to load the inventory of
	_loadByName		- If true, we are loading this by the units name, otherwise it is loaded by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_loadInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_saveByName", "_prefix"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// check if iniDBI2 is loaded
if ((activatedAddons find "inidbi2") == -1) exitWith {}; 

// Use the appropriate name for the database 
_db = "";
if (_saveByName) then 
{
	_db = vehicleVarName _unit;
}
else
{
	_uid = getPlayerUID _unit;
	if (_uid == "") then
	{
		_db = vehicleVarName _unit; // Fallback if the unit is not a player
	}
	else
	{
		_db = _uid;
	};
};

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};

// reading item slots
_headgear = ["read", ["Inventory", "Headgear"]] call _inidbi;
_goggles = ["read", ["Inventory", "Goggles"]] call _inidbi;
_items = ["read", ["Inventory", "Items"]] call _inidbi;
_binocular = ["read", ["Inventory", "Binocular"]] call _inidbi;
_uniform = ["read", ["Inventory", "Uniform"]] call _inidbi;
_vest = ["read", ["Inventory", "Vest"]] call _inidbi;
_backpack = ["read", ["Inventory", "Backpack"]] call _inidbi;

// Putting together basics
_basics = [_headgear, _goggles, _items, _binocular, _uniform, _vest, _backpack];

// Remote call to apply gear to the player
[_unit, _basics] remoteExecCall ["aso_fnc_applyInventory", _unit, false];
_basics;