/* ----------------------------------------------------------------------------
Description:
    Remotly executes all functions that are needed to load the mission environment,
	that includes date, time, weather and the weather forecast.
	NOTE: This works best if you leave stuff like rain, lightning and waves on automatic.
	
Parameters:
	none

Returns:
    nothing

Example:
    [_prefix] call aso_fnc_executeLoadEnvironment;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

if (isServer) then
{
	private _dateTime = ["Environment", "DateTime", "Value"] call aso_fnc_readValue;
	private _weather = ["Environment", "Weather", "Value"] call aso_fnc_readValue;

	[_dateTime] call aso_fnc_setDateTime;
	[_weather] call aso_fnc_setWeather;
}
else
{
	private _dateTime = ["Environment", "DateTime", "Value"] remoteExecCall ["aso_fnc_readValue", 2, false];
	private _weather = ["Environment", "Weather", "Value"] remoteExecCall ["aso_fnc_readValue", 2, false];

	[_dateTime] remoteExecCall ["aso_fnc_setDateTime", 2, false];
	[_weather] remoteExecCall ["aso_fnc_setWeather", 2, false];
};
true;	