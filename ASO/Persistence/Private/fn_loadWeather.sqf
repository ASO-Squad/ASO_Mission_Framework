/* ----------------------------------------------------------------------------
Description:
   Load the Date and Time of the current mission
	
Parameters:
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_prefix] call aso_fnc_SaveDateTime;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_prefix"];

// Use the appropriate name for the database 
_db = "Environment";
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
// Check if there is something to load
if (!("exists" call _inidbi)) exitWith {};

// let the db return current values if something goes wrong
// fog
_fogNow = fogParams;
_fogValue = _fogNow select 0;
_fogDecay = _fogNow select 1;
_fogBase = _fogNow select 2;
_fogForecast = fogForecast;
// Try reading from db
_fogValue = ["read", ["Weather", "FogValue", _fogValue]] call _inidbi;
_fogDecay = ["read", ["Weather", "FogDecay", _fogDecay]] call _inidbi;
_fogBase = ["read", ["Weather", "FogBase", _fogBase]] call _inidbi;
_fogForecast = ["read", ["Weather", "FogForecast", _fogForecast]] call _inidbi;
// overcast
_overcast = overcast;
_overcastForecast = overcastForecast;
_lightning = lightnings;
_rain = rain;
_overcast = ["read", ["Weather", "Overcast", _overcast]] call _inidbi;
_overcastForecast = ["read", ["Weather", "OvercastForecast", _overcastForecast]] call _inidbi;
_lightning = ["read", ["Weather", "Lightnings", _lightning]] call _inidbi;
_rain = ["read", ["Weather", "Rain", _rain]] call _inidbi;
// wind
_gusts = gusts;
_wind = wind;
_windDir = windDir;
_windStrength = windStr;
_gusts = ["read", ["Weather", "Gusts", _gusts]] call _inidbi;
_wind = ["read", ["Weather", "Wind", _wind]] call _inidbi;
_windDir = ["read", ["Weather", "WindDirection", _windDir]] call _inidbi;
_windStrength = ["read", ["Weather", "WindStrength", _windStrength]] call _inidbi;
//waves
_waves = waves; 
_waves = ["read", ["Weather", "Waves", _waves]] call _inidbi;
// Next weather change
_change = nextWeatherChange;
_change = ["read", ["Weather", "NextChange", _change]] call _inidbi;
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
