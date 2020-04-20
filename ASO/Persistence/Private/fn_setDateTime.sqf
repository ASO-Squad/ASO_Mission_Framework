/* ----------------------------------------------------------------------------
Description:
   Load the Date and Time of the current mission
	
Parameters:
	_datetime		- Datetime array

Returns:
    nothing

Example:
    [_dateTime] call aso_fnc_SaveDateTime;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_dateTime"];

// Set Date and Time
setDate _dateTime;
true;