/* ----------------------------------------------------------------------------
Description:
    Set the mount, meaning vehicle or static weapon of the given unit.

Parameters:
    _unit			- The unit that we want to track
	_mount			- The information about the units mount

Returns:
    nothing

Example:
    [_unit, _mount] call aso_fnc_setMount;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_mount"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Read information 
private _vehicle = _mount select 0;
private _role = _mount select 1;
private _cargoIndex = _mount select 2;
private _turretPath = _mount select 3;
private _personTurret = _mount select 4;

// check if that vehicle even exists
_vehicle = missionNamespace getVariable [_vehicle, objNull];
if (isNull _vehicle) exitWith {false;};

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
true;