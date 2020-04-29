/* ----------------------------------------------------------------------------
Description:
   Check if a variable may be the result of a faulty read attempt. 
   This can happen wen we fist start a mission without any prior saves. 

Parameters:
    _value		- Group we want the waypoints from

Returns:
    bool

Examples:
    [_value] call aso_fnc_isReadError;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_value"];
private _return = false;

if ((typeName _value) == "OBJECT") then 
{
	if ((isNull _value)) then 
	{
		_return = true;
	};
};
_return;
