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
private _fog = fogParams;
private _fogValue = _fog select 0;
private _fogDecay = _fog select 1;
private _fogBase = _fog select 2;
private _fogForecast = fogForecast;
// overcast
private _overcast = overcast;
private _overcastForecast = overcastForecast;
private _lightning = lightnings;
private _rain = rain;
// wind
private _gusts = gusts;
private _wind = wind;
private _windDir = windDir;
private _windStrength = windStr;
//waves
private _waves = waves;
// Next weather change
private _change = nextWeatherChange;

[[_fogValue, _fogDecay, _fogBase, _fogForecast], [_overcast, _overcastForecast, _lightning, _rain], [_gusts, _wind, _windDir, _windStrength], [_waves], [_change]];