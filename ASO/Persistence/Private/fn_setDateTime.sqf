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
if (!isServer) exitWith {false;};

params ["_dateTime"];

if (([_dateTime] call aso_fnc_isReadError)) exitWith {false;}; 

// Set Date and Time
[_dateTime] remoteExec ["setDate"];
true;