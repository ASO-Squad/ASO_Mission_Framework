/* ----------------------------------------------------------------------------
Description:
    Reads an generic value from the specified INIDBI Database.

Parameters:
    _database		- The database we want to use to load a value from
    _section        - The name of the section inside the specified database
    _name           - The key for the value

Returns:
    value

Example:
    [_database, _section, name] call aso_fnc_readValue;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_database", "_section", "_name", "_value"];

_database = format ["%1_%2", ASO_PREFIX, _database]; 

// creating new database
_inidbi = ["new", _database] call OO_INIDBI;
//["deleteSection", "Position"] call _inidbi; // cleanup

// Write information down
["write", [_section, _name, _value]] call _inidbi;