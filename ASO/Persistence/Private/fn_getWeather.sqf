/* ----------------------------------------------------------------------------
Description:
   Returns the weather and the weather forecast of the current mission
	
Parameters:
	none

Returns:
    nothing

Example:
    [] call aso_fnc_getWeather;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

// fog
_fog = fogParams;
_fogValue = _fog select 0;
_fogDecay = _fog select 1;
_fogBase = _fog select 2;
_fogForecast = fogForecast;
// overcast
_overcast = overcast;
_overcastForecast = overcastForecast;
_lightning = lightnings;
_rain = rain;
// wind
_gusts = gusts;
_wind = wind;
_windDir = windDir;
_windStrength = windStr;
//waves
_waves = waves;
// Next weather change
_change = nextWeatherChange;

[[_fogValue, _fogDecay, _fogBase, _fogForecast], [_overcast, _overcastForecast, _lightning, _rain], [_gusts, _wind, _windDir, _windStrength], [_waves], [_change]];