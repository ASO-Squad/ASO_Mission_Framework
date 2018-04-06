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


