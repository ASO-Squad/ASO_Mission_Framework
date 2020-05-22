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
if (!isServer) exitWith {false;};

params ["_weather"];

if (([_weather] call aso_fnc_isReadError)) exitWith {false;}; 

// fog
private _newFog = _weather select 0;
private _fogValue = _newFog select 0;
private _fogDecay = _newFog select 1;
private _fogBase = _newFog select 2;
private _fogForecast = _newFog select 3;

// overcast
private _newOvercast = _weather select 1;
private _overcast = _newOvercast select 0;
private _overcastForecast = _newOvercast select 1;
private _lightning = _newOvercast select 2;
private _rain = _newOvercast select 3;

// wind
private _newWind = _weather select 2;
private _gusts = _newWind select 0;
private _wind = _newWind select 1;
private _windDir = _newWind select 2;
private _windStrength = _newWind select 3;

//waves
private _newWaves = _weather select 3;
private _waves = _newWaves select 0; 
// Next weather change
private _newChange = _weather select 4;
private _change = _newChange select 0;

// Set current weather
0 setFog [_fogValue, _fogDecay, _fogBase];
[0,_overcast] remoteExec ["setOvercast"]; 
0 setLightnings _lightning;
0 setRain _rain;
[0, _gusts] remoteExec ["setGusts"];
setWind [_wind select 0, _wind select 1, false];
//0 setWindDir _windDir; // not needed?
0 setwindstr _windStrength;
0 setWaves _waves;
forceWeatherChange;

// Maybe we want to use our custom forecast
private _edit = ["CustomForecastEnabled", 0] call BIS_fnc_getParamValue;
if (_edit == 1) then
{
	_fogForecast = ["CustomFog", 4] call BIS_fnc_getParamValue;
    _fogForecast = _fogForecast / 10.0;
    _overcastForecast = ["CustomOvercast", 0] call BIS_fnc_getParamValue;
    _overcastForecast = _overcastForecast / 10.0;
    _change = 3600;
};
// Let the weather change according to the forecast
_change setFog _fogForecast;
_change setOvercast _overcastForecast;
true;