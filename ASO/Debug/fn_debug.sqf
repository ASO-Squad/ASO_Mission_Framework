/* ----------------------------------------------------------------------------
Description:
    Write a debug output to systemchat

Parameters:
    _description	- Description of the value
    _value   		- value to output
    _force          - force debug output

Returns:
    None

Examples:
    [_description, _value, true] call aso_fnc_debug

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
params ["_description", "_value", ["_force", false]];
if (ASO_DEBUG || _force) then
{
	systemChat format ["%1: %2", _description, _value];
};
