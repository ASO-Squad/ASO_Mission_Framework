/* ----------------------------------------------------------------------------
Description:
   Loads one or all variables of a given namespace
	
Parameters:
    _varspace		- Can be any object
	_variables 		- A variable array ["name", value]

Returns:
    nothing

Example:
    [_varspace, _variables] call aso_fnc_setVariables;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_varspace", "_variables"];

if (([_variables] call aso_fnc_isReadError)) exitWith {false;}; 

if (typeName _variables == "ARRAY") then 
{
	{
		_varspace setVariable [(_x select 0), (_x select 1)];

	} forEach _variables;
};
true;