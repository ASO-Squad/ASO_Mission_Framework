/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to save the mission environment,
	that includes date, time, weather and the weather forecast.
	NOTE: This works best if you leave stuff like rain, lightning and waves on automatic.
	
Parameters:
	none

Returns:
    nothing

Example:
    [] call aso_fnc_executeSaveEnvironment;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

private _dateTime = [] call aso_fnc_getDateTime;
private _weather = [] call aso_fnc_getWeather;

["Environment", "DateTime", "Value", _dateTime] call aso_fnc_writeValue;
["Environment", "Weather", "Value", _weather] call aso_fnc_writeValue;

true;