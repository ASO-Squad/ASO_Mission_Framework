/* ----------------------------------------------------------------------------
Description:
    Load all ACE explosives associated with this unit.
	ACE cellphone triggers and BI mines are not supported

Parameters:
    _unit			- The unit that we want to track
	_loadByName		- If true, we are saving this by the units name, otherwise it is loaded by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions

Returns:
    nothing

Example:
    [_unit, false, _prefix] call aso_fnc_saveExplosives;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_loadByName", "_prefix"];

// Check if the explosives got already loaded
if (_unit getVariable ["ASO_P_Exp", false]) exitWith {};

// Use the appropriate name for the database 
_db = [_unit, _loadByName] call aso_fnc_getDbName;
// creating new database
_inidbi = ["new", format["%1_%2", _prefix, _db]] call OO_INIDBI;
// Check if there is something to load
if (!("exists" call _inidbi)) exitWith {};

// Load information
_explosives = ["read", ["Explosives", "Array"]] call _inidbi;

// Place explosives
{
	_position = (_x select 0);
	_direction = (_x select 1);
	_class = (_x select 2);
	_detonator = (_x select 3);
	_clacker = (_x select 3);
	_clackerClass = (_x select 4);
	//Those are the three options we have with ACE right now
	switch (_detonator) do 
	{
		case "Command": { _detonator = "ACE_Clacker"};
		case "MK16_Transmitter": { _detonator = "ACE_M26_Clacker" };
		case "DeadManSwitch": { _detonator = "ACE_DeadManSwitch"};
		default { _detonator = "ACE_Clacker" };
	};
	_explosive = createVehicle [_class, _position, [], 0, "NONE"];
	_explosive setDir _direction;
	//[_unit, _explosive, "_detonator"] call ace_explosives_fnc_connectExplosive;
	[_unit, _explosive, _clackerClass, [ConfigFile >> "ACE_Triggers" >> _clacker]] call ACE_Explosives_fnc_addClacker;
} forEach _explosives;
_unit setVariable ["ASO_P_Exp", true, true];