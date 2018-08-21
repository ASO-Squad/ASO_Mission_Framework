/* ----------------------------------------------------------------------------
Description:
    Loads the position for the given unit, and does this with INIDBI2.
	Files are loaded from the server machine.
	The unit in question should be of the type MEN.

Parameters:
    _unit			- The unit that we want to load the position of
	_loadByName		- If true, we are loading this by the units name, otherwise it is loaded by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
	_db				- DB Name differs from object Name (needed to support groundWeaponHolders)
	_vehicle		- target the vehicle, true or false

Returns:
    nothing

Example:
    [_unit, false, _prefix, _db, false] call aso_fnc_loadPosition;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_loadByName", "_prefix", ["_db", ""], ["_vehicle", false]];

// Check if the position got already loaded
if (_unit getVariable ["ASO_P_Position", false]) exitWith {};

// Use the appropriate name for the database
if (_vehicle) then
{
	_db = [vehicle _unit, true] call aso_fnc_getDbName;
}
else
{
	_db = [_unit, _loadByName] call aso_fnc_getDbName;
};

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {};

// reading position
_position = ["read", ["Position", "Location"]] call _inidbi;
_direction = ["read", ["Position", "Direction"]] call _inidbi;
_stance = ["read", ["Position", "Stance"]] call _inidbi;

// Apply data
if (local _unit) then
{
	_unit setDir _direction;
	_unit playAction _stance;
	_unit setPosATL _position;
}
else
{
	[_unit, _direction] remoteExec ["setDir", _unit, false]; // setDir needs local parameters
	[_unit, _stance] remoteExec ["playAction", _unit, false];// playAction needs local parameters
	[_unit, _position] remoteExec ["setPosATL", _unit, false];// this needs to be called remotly in case a player starts in a vehicle
};
_unit setPosATL _position; // Position seems to be synced, so this call needs to be done on the server too
_unit setVariable ["ASO_P_Position", true, true];
// Return the position to use it with other functions
_position;
