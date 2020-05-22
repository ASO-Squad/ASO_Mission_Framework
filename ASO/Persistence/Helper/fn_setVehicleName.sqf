/* ----------------------------------------------------------------------------
Description:
    If the unit has no vehicle name, set its group designation as vehicle name 
	to make sure we can prevent loss of identification when it dies.

Parameters:
    _object	- A object

Returns:
    nothing

Example:
    [this] call aso_fnc_setVehicleName;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_object"];

_name = "";
_name = vehicleVarName _object;

if (_name != "") exitWith {_name};

// Get the DB-Name. Im most cases this will be the objects group id
_name = [_object, true] call aso_fnc_getDbName;
// Keep the name
_object setVehicleVarName _name;
// Determine if its an unknown vehicle with no name
_length = count _name;
_ending = [_name, _length-4, 4] call CBA_fnc_substr;
if (_ending == ".p3d") then 
{
    _name = "*NoNameV*"; // Return the magic name
};
_name;