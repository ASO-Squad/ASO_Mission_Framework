/* ----------------------------------------------------------------------------
Description:
    Saves the inventory of the given unit, and does this with INIDBI2.
	InventoryFiles are written on the server machine.
	The unit in question should be of the type MEN.

Parameters:
    _unit			- The unit that we want to keep the inventory of
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_saveInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_saveByName", "_prefix"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// check if iniDBI2 is loaded
//if ((activatedAddons find "inidbi2") == -1) exitWith {}; 

// Use the appropriate name for the database 
_db = [_unit, _saveByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Inventory"] call _inidbi; // cleanup

// Using getUnitLoadout for inventory of infantry units
_fullInventory = getUnitLoadout _unit;

// Dissecting array to make ini DB better readable  and avoid dll overflow problems with huge loadouts
// Using the Array structure documented here: https://community.bistudio.com/wiki/Talk:getUnitLoadout
_primary = _fullInventory select 0;
_secondary = _fullInventory select 1;
_handgun = _fullInventory select 2;
_uniform = _fullInventory select 3;
_vest = _fullInventory select 4;
_backpack = _fullInventory select 5;
_helmet = _fullInventory select 6;
_facewear = _fullInventory select 7;
_binocular = _fullInventory select 8;
_items = _fullInventory select 9;

// Check for Earplugs
_earplugs = [_unit] call ace_hearing_fnc_hasEarPlugsIn;

["write", ["Inventory", "Primary", _primary]] call _inidbi;
["write", ["Inventory", "Secondary", _secondary]] call _inidbi;
["write", ["Inventory", "Handgun", _handgun]] call _inidbi;
["write", ["Inventory", "Uniform", _uniform]] call _inidbi;
["write", ["Inventory", "Vest", _vest]] call _inidbi;
["write", ["Inventory", "Backpack", _backpack]] call _inidbi;
["write", ["Inventory", "Helmet", _helmet]] call _inidbi;
["write", ["Inventory", "Facewear", _facewear]] call _inidbi;
["write", ["Inventory", "Binocular", _binocular]] call _inidbi;
["write", ["Inventory", "Items", _items]] call _inidbi;
["write", ["Inventory", "Earplugs", _earplugs]] call _inidbi;
_fullInventory;

// I'm ignoring TFAR Radio settings, because there is no way to get/set more than the currently active radio.
// We are better off to define standard frequencies on every mission.