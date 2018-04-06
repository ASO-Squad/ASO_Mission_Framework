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
// Collecting item slots
_headgear = headgear _unit;
_goggles = goggles _unit;
_uniform = uniform _unit;
_vest = vest _unit;
_backpack = backpack _unit;
_items = assignedItems _unit;
_binocular = binocular _unit;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
"delete" call _inidbi; // cleanup

// writing item slots
["write", ["Inventory", "Headgear", _headgear]] call _inidbi;
["write", ["Inventory", "Goggles", _goggles]] call _inidbi;
["write", ["Inventory", "Items", _items]] call _inidbi;
["write", ["Inventory", "Binocular", _binocular]] call _inidbi;
["write", ["Inventory", "Uniform", _uniform]] call _inidbi;
["write", ["Inventory", "Vest", _vest]] call _inidbi;
["write", ["Inventory", "Backpack", _backpack]] call _inidbi;

// Collecting primary weapon, loaded magazines and attached items
_primaryWeapon = primaryWeapon _unit;
_primaryAttachments = primaryWeaponItems _unit;
_secondaryWeapon = secondaryweapon _unit;
_secondaryAttachments = secondaryWeaponItems _unit;
_handgunWeapon = handgunWeapon _unit;
_handgunAttachments = handgunItems _unit;
// Collecting magazines
_allMagazines = magazinesAmmoFull _unit; // This also includes any batteries inside of laserdesignators 
// splitting up according to location
_magazinesInUniform = [];
_magazinesInVest = [];
_magazinesInBackpack = [];
__magazinesLoaded = [];
{
	_location = (_x select 4);
	switch (_location) do {
		case "Uniform": { _magazinesInUniform pushBack [(_x select 0), (_x select 1)] }; // [MagClassName, BulletCount]
		case "Vest": { _magazinesInVest pushBack [(_x select 0), (_x select 1)] };
		case "Backpack": { _magazinesInBackpack pushBack [(_x select 0), (_x select 1)] };
		default { __magazinesLoaded pushBack [(_x select 0), (_x select 1)] }; // Laserdesignator batteries go here
	}; 
	
} forEach _allMagazines;
// Find Weapons in containers
_weaponsInUniform = weaponsItems uniformContainer _unit;
_weaponsInVest = weaponsItems vestContainer _unit;
_weaponsInBackpack = weaponsItems backpackContainer _unit;
// Find Items in ContainerClosed
_uniformItems = [];
_vestItems = [];
_backpackItems = [];
// Search in uniform for items
{
	_isItem = true; // Is an item
	_isItem = (!(_x isKindOf ["Pistol", configFile >> "CfgWeapons"]) // Not a pistol
	&& !(_x isKindOf ["Rifle", configFile >> "CfgWeapons"]) // Not a rifle
	&& !(_x isKindOf ["Launcher", configFile >> "CfgWeapons"]) // Not a launcher 
	&& !(_x isKindOf ["Default", configFile >> "CfgMagazines"])); // Not a magazine
	if (_isItem) then
	{
		_uniformItems pushback _x;
	};

} forEach uniformItems _unit;
// Search in vest for items
{
	_isItem = true; // Is an item
	_isItem = (!(_x isKindOf ["Pistol", configFile >> "CfgWeapons"]) // Not a pistol
	&& !(_x isKindOf ["Rifle", configFile >> "CfgWeapons"]) // Not a rifle
	&& !(_x isKindOf ["Launcher", configFile >> "CfgWeapons"]) // Not a launcher 
	&& !(_x isKindOf ["Default", configFile >> "CfgMagazines"])); // Not a magazine
	if (_isItem) then
	{
		_vestItems pushback _x;
	};

} forEach vestItems _unit;
// Search in backpack for items
{
	_isItem = true; // Is an item
	_isItem = (!(_x isKindOf ["Pistol", configFile >> "CfgWeapons"]) // Not a pistol
	&& !(_x isKindOf ["Rifle", configFile >> "CfgWeapons"]) // Not a rifle
	&& !(_x isKindOf ["Launcher", configFile >> "CfgWeapons"]) // Not a launcher 
	&& !(_x isKindOf ["Default", configFile >> "CfgMagazines"])); // Not a magazine
	if (_isItem) then
	{
		_backpackItems pushback _x;
	};

} forEach backpackItems _unit;

// Writing primary weapons and attachments
["write", ["Weapons", "PrimaryWeapon", _primaryWeapon]] call _inidbi;
["write", ["Weapons", "PrimaryWeaponAttachments", _primaryAttachments]] call _inidbi;
// writing secondary weapon and attachments
["write", ["Weapons", "SecondaryWeapon", _secondaryWeapon]] call _inidbi;
["write", ["Weapons", "SecondaryWeaponAttachments", _secondaryAttachments]] call _inidbi;
// writing  handgun weapon and attachments
["write", ["Weapons", "HandgunWeapon", _handgunWeapon]] call _inidbi;
["write", ["Weapons", "HandgunAttachments", _handgunAttachments]] call _inidbi;
// write stuff in uniform
["write", ["UniformCargo", "Magazines", _magazinesInUniform]] call _inidbi;
["write", ["UniformCargo", "Weapons", _weaponsInUniform]] call _inidbi;
["write", ["UniformCargo", "Items", _uniformItems]] call _inidbi;
// write stuff in vest
["write", ["VestCargo", "Magazines", _magazinesInVest]] call _inidbi;
["write", ["VestCargo", "Weapons", _weaponsInVest]] call _inidbi;
["write", ["VestCargo", "Items", _vestItems]] call _inidbi;
// write stuff in uniform
["write", ["BackpackCargo", "Magazines", _magazinesInBackpack]] call _inidbi;
["write", ["BackpackCargo", "Weapons", _weaponsInBackpack]] call _inidbi;
["write", ["BackpackCargo", "Items", _backpackItems]] call _inidbi;
