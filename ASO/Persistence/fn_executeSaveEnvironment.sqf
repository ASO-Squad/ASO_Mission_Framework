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

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

if (isServer) then
{
	private _dateTime = [] call aso_fnc_getDateTime;
	private _weather = [] call aso_fnc_getWeather;

	["Environment", "DateTime", "Value", _dateTime] call aso_fnc_writeValue;
	["Environment", "Weather", "Value", _weather] call aso_fnc_writeValue;
}
else
{
	private _dateTime = [] remoteExecCall ["aso_fnc_getDateTime", 2, false];
	private _weather = [] remoteExecCall ["aso_fnc_getWeather", 2, false];
		
	["Environment", "DateTime", "Value", _dateTime] remoteExecCall ["aso_fnc_writeValue", 2, false];
	["Environment", "Weather", "Value", _weather] remoteExecCall ["aso_fnc_writeValue", 2, false];
};
true;