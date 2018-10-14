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
	if (typeName _object == "OBJECT") then
	{
		_db = vehicleVarName _object;
	};
}
else
{
	if (typeName _object == "OBJECT") then
	{
		_db = getPlayerUID _object;
	};
};
if (_db == "" || _db == "_SP_AI_") then
{
	// no player id fall back to vehicleVarName
	if (typeName _object == "OBJECT") then
	{
		_db = vehicleVarName _object;
	};
	if (_db == "") then
	{
		// Fallback if the unit is not a player and there is no name
		// Note: You fucked up big time if you land here.
		_fallback = format["%1", _object];
		_fallback = [_fallback, " ", "_"] call CBA_fnc_replace;
		_fallback = [_fallback, ":", "_"] call CBA_fnc_replace;
		_db = _fallback;
	};
};
_db;