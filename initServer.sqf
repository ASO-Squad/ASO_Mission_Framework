waitUntil { !(isNil "paramsArray") };
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
if (_load == 1) then
{
	if (isNil "ASO_INIT") then
	{
		[] call aso_fnc_init_aso;
	};
	[] call aso_fnc_loadState;
	// Make sure empty weapon holders are beeing deleted during the mission
	[] spawn aso_fnc_deleteEmptyWH;
}
else
{
	// set datetime and weather according to mission parameter
	_hour = ["CustomDaytime", 12] call BIS_fnc_getParamValue;
	_fog = (["CustomFog", 0] call BIS_fnc_getParamValue) / 10.0;
	_overcast = (["CustomOvercast", 0] call BIS_fnc_getParamValue) / 10.0;
	_weather = [[_fog, 0.1, 0, _fog], [_overcast, _overcast, 0, 0], [0.1, [0,0,0], 0, 0.1], [0.1], [1800]];
	
	[[2020, 05, 22, _hour, 00]] call aso_fnc_setDateTime;
	[_weather] call aso_fnc_setWeather;
};

