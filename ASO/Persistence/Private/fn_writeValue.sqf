/* ----------------------------------------------------------------------------
Description:
    Writes an generic value into the specified INIDBI Database.

Parameters:
    _database		- The database we want to use to save a value to
    _section        - The name of the section inside the specified database
    _name           - The key for the value
    _value			- The value that need to be written down

Returns:
    nothing

Example:
    [_value, _name, _database, _section] call aso_fnc_writeValue;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_database", "_section", "_value", "_name"];

_database = format ["%1_%2", ASO_PREFIX, _database]; 

// creating new database
_inidbi = ["new", _database] call OO_INIDBI;

// Write information down
["write", [_section, _name, _value]] call _inidbi;