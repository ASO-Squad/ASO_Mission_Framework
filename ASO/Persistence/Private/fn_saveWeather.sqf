/* ----------------------------------------------------------------------------
Description:
   Save the weather and the weather forecast of the current mission
	
Parameters:
	_prefix     - Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_prefix] call aso_fnc_SaveWeather;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_prefix"];

// Use the appropriate name for the database 
_db = "Environment";
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
["deleteSection", "Weather"] call _inidbi; // cleanup
// fog
_fog = fogParams;
_fogValue = _fog select 0;
_fogDecay = _fog select 1;
_fogBase = _fog select 2;
_fogForecast = fogForecast;
["write", ["Weather", "FogValue", _fogValue]] call _inidbi;
["write", ["Weather", "FogDecay", _fogDecay]] call _inidbi;
["write", ["Weather", "FogBase", _fogBase]] call _inidbi;
["write", ["Weather", "FogForecast", _fogForecast]] call _inidbi;
// overcast
_overcast = overcast;
_overcastForecast = overcastForecast;
_lightning = lightnings;
_rain = rain;
["write", ["Weather", "Overcast", _overcast]] call _inidbi;
["write", ["Weather", "OvercastForecast", _overcastForecast]] call _inidbi;
["write", ["Weather", "Lightnings", _lightning]] call _inidbi;
["write", ["Weather", "Rain", _rain]] call _inidbi;
// wind
_gusts = gusts;
_wind = wind;
_windDir = windDir;
_windStrength = windStr;
["write", ["Weather", "Gusts", _gusts]] call _inidbi;
["write", ["Weather", "Wind", _wind]] call _inidbi;
["write", ["Weather", "WindDirection", _windDir]] call _inidbi;
["write", ["Weather", "WindStrength", _windStrength]] call _inidbi;
//waves
_waves = waves;
["write", ["Weather", "Waves", _waves]] call _inidbi;
// Next weather change
_change = nextWeatherChange;
["write", ["Weather", "NextChange", _change]] call _inidbi;
