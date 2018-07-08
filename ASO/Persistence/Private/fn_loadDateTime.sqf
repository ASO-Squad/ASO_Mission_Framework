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
_dateTimeNow = date;
_year = _dateTimeNow select 0;
_month = _dateTimeNow select 1;
_day = _dateTimeNow select 2;
_hour = _dateTimeNow select 3;
_minute = _dateTimeNow select 4;
// Try reading from db
_year = ["read", ["DateTime", "Year", _year]] call _inidbi;
_month = ["read", ["DateTime", "Month", _month]] call _inidbi;
_day = ["read", ["DateTime", "Day", _day]] call _inidbi;
_hour = ["read", ["DateTime", "Hour", _hour]] call _inidbi;
_minute = ["read", ["DateTime", "Minute", _minute]] call _inidbi;
// Set Date and Timer
setDate [_year, _month, _day, _hour, _minute];