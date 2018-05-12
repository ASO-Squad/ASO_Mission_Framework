/* ----------------------------------------------------------------------------
Description:
   Returns a valid DB Name for the given object
	
Parameters:
    _object
	_preferName

Returns:
    nothing

Example:
    [_object, _preferName] call aso_fnc_getDbName;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_object", "_preferName"];

// Use the appropriate name for the database 
_db = "";
if (_preferName) then 
{
	_db = vehicleVarName _object;
	if (_db == "") then
	{
		_fallback = format["%1", _object];
		_fallback = [_fallback, " ", "_"] call CBA_fnc_replace;
		_fallback = [_fallback, ":", "_"] call CBA_fnc_replace;
		_db = _fallback;
	}
}
else
{
	_uid = getPlayerUID _object;
	if (_uid == "" || _uid == "_SP_AI_") then
	{
		// Fallback if the unit is not a player
		_fallback = format["%1", _object];
		_fallback = [_fallback, " ", "_"] call CBA_fnc_replace;
		_fallback = [_fallback, ":", "_"] call CBA_fnc_replace;
		_db = _fallback;
	}
	else
	{
		_db = _uid;
	};
};
_db;