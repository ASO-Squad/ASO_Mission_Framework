/* ----------------------------------------------------------------------------
Description:
   Sets the weather for the current mission
	
Parameters:
	_weather    - The weather array

Returns:
    nothing

Example:
    [_weather] call aso_fnc_setWeather;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_weather"];

// fog
_newFog = _weather select 0;
_fogValue = _newFog select 0;
_fogDecay = _newFog select 1;
_fogBase = _newFog select 2;
_fogForecast = _newFog select 3;

// overcast
_newOvercast = _weather select 1;
_overcast = _newOvercast select 0;
_overcastForecast = _newOvercast select 1;
_lightning = _newOvercast select 2;
_rain = _newOvercast select 3;

// wind
_newWind = _weather select 2;
_gusts = _newWind select 0;
_wind = _newWind select 1;
_windDir = _newWind select 2;
_windStrength = _newWind select 3;

//waves
_newWaves = _weather select 2;
_waves = _newWaves select 0; 
// Next weather change
_newChange = weather select 3;
_change = _newChange select 0;

// Set current weather
0 setFog [_fogValue, _fogDecay, _fogBase];
0 setOvercast _overcast;
0 setLightnings _lightning;
0 setRain _rain;
0 setGusts _gusts;
setWind [_wind select 0, _wind select 1];
0 setWindDir _windDir;
0 setwindstr _windStrength;
0 setWaves _waves;
forceWeatherChange;

// Maybe we want to use our custom forecast
_edit = ["CustomForecastEnabled", 0] call BIS_fnc_getParamValue;
if (_edit == 1) then
{
	_fogForecast = ["CustomFog", 4] call BIS_fnc_getParamValue;
    _fogForecast = _fogForecast / 10.0;
    _overcastForecast = ["CustomOvercast", 0] call BIS_fnc_getParamValue;
    _overcastForecast = _overcastForecast / 10.0;
};

// Let the weather change according to the forecast
_change setFog _fogForecast;
_change setOvercast _overcastForecast;
true;