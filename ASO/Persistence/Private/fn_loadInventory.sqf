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

params ["_unit", "_loadByName", "_prefix"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Check if the inventory got already loaded
if (_unit getVariable ["ASO_P_Inventory", false]) exitWith {};

// Use the appropriate name for the database 
_db = [_unit, _loadByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};

// reading item slots
_primary = ["read", ["Inventory", "Primary"]] call _inidbi;
_secondary = ["read", ["Inventory", "Secondary"]] call _inidbi;
_handgun = ["read", ["Inventory", "Handgun"]] call _inidbi;
_uniform = ["read", ["Inventory", "Uniform"]] call _inidbi;
_vest = ["read", ["Inventory", "Vest"]] call _inidbi;
_backpack = ["read", ["Inventory", "Backpack"]] call _inidbi;
_helmet = ["read", ["Inventory", "Helmet"]] call _inidbi;
_facewear = ["read", ["Inventory", "Facewear"]] call _inidbi;
_binocular = ["read", ["Inventory", "Binocular"]] call _inidbi;
_items = ["read", ["Inventory", "Items"]] call _inidbi;
_earplugs = ["read", ["Inventory", "Earplugs"]] call _inidbi;

// Putting back together loadout array 
_fullInventory = [];
_fullInventory pushBack _primary;
_fullInventory pushBack _secondary;
_fullInventory pushBack _handgun;
_fullInventory pushBack _uniform;
_fullInventory pushBack _vest;
_fullInventory pushBack _backpack;
_fullInventory pushBack _helmet;
_fullInventory pushBack _facewear;
_fullInventory pushBack _binocular;
_fullInventory pushBack _items;

// Use earplugs if needed
if (_earplugs) then
{
	[_unit] call ace_hearing_fnc_putInEarplugs;
};

// Wait for TFR if we can and only if the unit is a player (fuck those AI radios!)
if (ASO_USE_TFR) then
{
	if (canSuspend && isPlayer _unit) then
	{
		_tfr = _unit getVariable ["tf_handlers_set", false];
		while {!_tfr} do 
		{
			sleep 1;
			_tfr = _unit getVariable ["tf_handlers_set", false];
		};
	};
};

// Apply loadout 
_unit setUnitLoadout [_fullInventory, false];

// Done
_unit setVariable ["ASO_P_Inventory", true, true];
