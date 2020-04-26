/* ----------------------------------------------------------------------------
Description:
    Reads an generic value from the specified INIDBI Database.

Parameters:
    _database		- The database we want to use to load a value from
    _section        - The name of the section inside the specified database
    _name           - The key for the value
    _prefix         - Prefix that is used, leave empty for ASO_PREFIX

Returns:
    value

Example:
    [_database, _section, name] call aso_fnc_readValue;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_database", "_section", "_name", ["_prefix", ASO_PREFIX]];


private _database = format ["%1_%2", _prefix, _database]; 

// creating new database
private _inidbi = ["new", _database] call OO_INIDBI;
// reading
["read", [_section, _name, "empty"]] call _inidbi;