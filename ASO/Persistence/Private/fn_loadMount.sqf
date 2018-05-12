/* ----------------------------------------------------------------------------
Description:
    Loads the mount, meaning vehicle or static weapon of the given unit, and does this with INIDBI2.
	Files are read on the server machine.

Parameters:
    _unit			- The unit that we want to track
	_loadByName		- If true, we are saving this by the units name, otherwise it is loaded by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_loadMount;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_loadByName", "_prefix"];

// Check if the health got already loaded
if (_unit getVariable ["ASO_P_Mount", false]) exitWith {};

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Use the appropriate name for the database 
_db = [_unit, _loadByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
// Check if there is something to load
if (!("exists" call _inidbi)) exitWith {};

// Read information 
_vehicle = ["read", ["Mount", "Vehicle"]] call _inidbi;
_role = ["read", ["Mount", "Role"]] call _inidbi;
_cargoIndex = ["read", ["Mount", "Cargo"]] call _inidbi;
_turretPath = ["read", ["Mount", "Turret"]] call _inidbi;
_personTurret = ["read", ["Mount", "PersonTurret"]] call _inidbi;

_vehicle = missionNamespace getVariable [_vehicle, objNull];
if (isNull _vehicle) exitWith {};

// Make sure we removed all editor set crew, but only once
if (!(_vehicle getVariable ["ASO_P_CrewRemoved", false])) then
{
	{
		unassignVehicle _x;
		_x setVehiclePosition [(getPosATL _vehicle), [], 10, ""];

	} forEach crew _vehicle;
	_vehicle setVariable ["ASO_P_CrewRemoved", true, true];
};
// Apply variables
switch (_role) do {
	case "driver": { [_unit, _vehicle] remoteExec ["moveInDriver", _unit, false]; };
	case "gunner": { [_unit, _vehicle] remoteExec ["moveInGunner", _unit, false]; };
	case "commander": { [_unit, _vehicle] remoteExec ["moveInCommander", _unit, false]; };
	case "Turret": { [_unit, [_vehicle, _turretPath]] remoteExec ["moveInTurret", _unit, false] };
	case "cargo": { [_unit, [_vehicle, _cargoIndex]] remoteExec ["moveInCargo", _unit, false] };
	default { [_unit, [_vehicle, _cargoIndex]] remoteExec ["moveInCargo", _unit, false] };
};
_unit setVariable ["ASO_P_Mount", true, true];