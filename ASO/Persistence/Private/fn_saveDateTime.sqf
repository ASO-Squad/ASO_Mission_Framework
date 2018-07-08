/* ----------------------------------------------------------------------------
Description:
   Save the Date and Time of the current mission
	
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
["deleteSection", "DateTime"] call _inidbi; // cleanup

_dateTime = date;
_year = _dateTime select 0;
_month = _dateTime select 1;
_day = _dateTime select 2;
_hour = _dateTime select 3;
_minute = _dateTime select 4;

["write", ["DateTime", "Year", _year]] call _inidbi;
["write", ["DateTime", "Month", _month]] call _inidbi;
["write", ["DateTime", "Day", _day]] call _inidbi;
["write", ["DateTime", "Hour", _hour]] call _inidbi;
["write", ["DateTime", "Minute", _minute]] call _inidbi;
