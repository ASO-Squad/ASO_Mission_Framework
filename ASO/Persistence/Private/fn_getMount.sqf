/* ----------------------------------------------------------------------------
Description:
    gets which vehicle or static weapon the given unit is using.

Parameters:
    _unit			- The unit that we want to track

Returns:
    Vehicle

Example:
    [_unit] call aso_fnc_getMount;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit"];

// Check if the unit is of the right type
if (!(_unit isKindOf "Man")) exitWith {};

// Variables
_vehicle = objectParent _unit;
_crewPositions = fullCrew _vehicle;
_role = "";
_cargoIndex = -1;
_turretPath = [];
_personTurret = false;
if (isNull objectParent _unit) then
{
	_vehicle = ""; // This unit is not inside a vehicle
}
else
{
	_varName = vehicleVarName _vehicle;
	if (_varName == "") then
	{
		_vehicle = format ["%1", _vehicle];
	}
	else
	{
		_vehicle = _varName;
	};	
	
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
[_vehicle, _role, _cargoIndex, _turretPath, _personTurret];