/* ----------------------------------------------------------------------------
Description:
    Saves the position and direction of the given unit, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _unit			- The unit that we want to keep the inventory of
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_savePosition;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_saveByName", "_prefix"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

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
["deleteSection", "Position"] call _inidbi; // cleanup

// Using getUnitLoadout for inventory of infantry units
_position = getPosATL _unit;
_direction = getDir _unit;
_stance = stance _unit;

// Write information down
["write", ["Position", "Location", _position]] call _inidbi;
["write", ["Position", "Direction", _direction]] call _inidbi;
["write", ["Position", "Stance", _stance]] call _inidbi;