/* ----------------------------------------------------------------------------
Description:
    Saves which vehicle or static weapon the given unit is using, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _unit			- The unit that we want to track
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_saveMount;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_saveByName", "_prefix"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Use the appropriate name for the database 
_db = [_unit, _saveByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Mount"] call _inidbi; // cleanup

// Variables
_vehicle = vehicle _unit;
_crewPositions = fullCrew _vehicle;
_role = "";
_cargoIndex = -1;
_turretPath = [];
_personTurret = false;
if (_vehicle == _unit) then
{
	_vehicle = ""; // This unit is not inside a vehicle
}
else
{
	_vehicle = vehicleVarName _vehicle; // getting var name
	{
		scopeName "searchCrew";
		if ((_x select 0) == _unit) then
		{
			_role = (_x select 1);
			_cargoIndex = (_x select 2);
			_turretPath = (_x select 3);
			_personTurret = (_x select 4);
			breakOut "searchCrew";
		};		
	} forEach _crewPositions;
};

// Write information down
["write", ["Mount", "Vehicle", _vehicle]] call _inidbi;
["write", ["Mount", "Role", _role]] call _inidbi;
["write", ["Mount", "Cargo", _cargoIndex]] call _inidbi;
["write", ["Mount", "Turret", _turretPath]] call _inidbi;
["write", ["Mount", "PersonTurret", _personTurret]] call _inidbi;