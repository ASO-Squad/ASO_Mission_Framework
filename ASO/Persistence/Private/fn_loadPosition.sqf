/* ----------------------------------------------------------------------------
Description:
    Loads the inventory for the given unit, and does this with INIDBI2.
	InventoryFiles are loaded from the server machine.
	The unit in question should be of the type MEN.

Parameters:
    _unit			- The unit that we want to load the inventory of
	_loadByName		- If true, we are loading this by the units name, otherwise it is loaded by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
	_db				- DB Name differs from object Name (needed to support groundWeaponHolders)

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_loadInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_loadByName", "_prefix", ["_db", ""]];

// Check if the position got already loaded
if (_unit getVariable ["ASO_P_Position", false]) exitWith {};

// Use the appropriate name for the database 
if (_db == "") then
{
	if (_loadByName) then 
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
};

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};

// reading item slots
_position = ["read", ["Position", "Location"]] call _inidbi;
_direction = ["read", ["Position", "Direction"]] call _inidbi;
_stance = ["read", ["Position", "Stance"]] call _inidbi;

// Apply data
if (local _unit) then
{
	_unit setDir _direction;
	_unit playAction _stance;
}
else
{
	[_unit, _direction] remoteExec ["setDir", _unit, false]; // setDir needs local parameters
	[_unit, _stance] remoteExec ["playAction", _unit, false];// playAction needs local parameters
};
_unit setPosATL _position;
_unit setVariable ["ASO_P_Position", true, true];
// Return the position to use it with other functions
_position;
