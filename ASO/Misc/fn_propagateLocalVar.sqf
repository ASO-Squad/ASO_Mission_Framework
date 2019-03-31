/* ----------------------------------------------------------------------------
Description:
    Propagates a local variable to all connected clients and the server, if the variable
    is set to the desired value.

Parameters:
    _varSpace 	- the variable space
    _var        - the variable name
    _value      - the value at which the variable gets propagated
    _iniValue   - the initial value, before the var might exists in the varSpace

Returns:
    None

Example:
    [_unit, "INeedThis", true, false] spawn aso_fnc_propagateLocalVar;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

params ["_varSpace", "_var", ["_value", true], ["_iniValue", false]];

if (isNil "_varSpace") exitWith {};
if (isNil "_var") exitWith {};
if (isNil "_value") exitWith {};

_valueCheck = _varSpace getVariable [_var, _iniValue];
while {!(_value isEqualTo _valueCheck)} do 
{
    sleep 1;
    _valueCheck = _varSpace getVariable [_var, _iniValue];
};
_varSpace setVariable [_var, _valueCheck, true];
