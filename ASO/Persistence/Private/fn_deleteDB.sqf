/* ----------------------------------------------------------------------------
Description:
    Deletes a database file that is no longer needed

Parameters:
    _database		- The database we want to delete

Returns:
    nothing

Example:
    [_database] call aso_fnc_deleteDB;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_database"];

private _database = format ["%1_%2", ASO_PREFIX, _database]; 

// delete database
private _inidbi = ["new", _database] call OO_INIDBI;
"delete" call _inidbi;