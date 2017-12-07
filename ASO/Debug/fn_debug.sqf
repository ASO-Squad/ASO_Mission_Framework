/* ----------------------------------------------------------------------------
Description:
    Write a debug output to systemchat

Parameters:
    _description	- Description of the value
    _value   		- value to output

Returns:
    None

Examples:
    [_description, _value] call aso_fnc_debug

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (ASO_DEBUG) then
{
	params ["_description", "_value"];
	systemChat format ["%1: %2", _description, _value];
};
