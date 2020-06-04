/* ----------------------------------------------------------------------------
Description:
    Returns the military time. 
    See: https://en.wikipedia.org/wiki/List_of_military_time_zones

Parameters:
    _timezone			- The military time zone 

Returns:
    String for the current military time.

Examples:
    [] call aso_fnc_milTime;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params [["_timezone", "J"]];

_hour = date select 3;
_minute = date select 4;

if (_hour < 10) then 
{
    _hour = format ["0%1", _hour];    
}
else 
{
    _hour = format ["%1", _hour];   
};
if (_minute < 10) then 
{
    _minute = format ["0%1", _minute];    
}
else 
{
    _minute = format ["%1", _minute];   
};
format ["%1%2%3", _hour, _minute, _timezone];
