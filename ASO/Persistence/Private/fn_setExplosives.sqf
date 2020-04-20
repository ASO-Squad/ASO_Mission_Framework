/* ----------------------------------------------------------------------------
Description:
    Set ACE explosives associated with this unit.
	ACE cellphone triggers and BI mines are not supported

Parameters:
    _unit			- The unit that we want to track
	_explosives		- The explosives we want to attach to the unit

Returns:
    nothing

Example:
    [_unit, _explosives] call aso_fnc_setExplosives;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit", "_explosives"];

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
	[_unit, _explosive, _clackerClass, [ConfigFile >> "ACE_Triggers" >> _clacker]] call ACE_Explosives_fnc_addClacker;
} forEach _explosives;
true;