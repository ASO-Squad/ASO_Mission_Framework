/* ----------------------------------------------------------------------------
Description:
    Gets all actived ACE explosives associated with this unit.
	ACE cellphone triggers and BI mines are not supported

Parameters:
    _unit			- The unit that we want to track

Returns:
    Explosives array

Example:
    [_unit] call aso_fnc_getExplosives;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_unit"];

// Variables
_exp = [_unit] call ACE_Explosives_fnc_getPlacedExplosives;
_explosives = [];
{
	_position = getPosATL (_x select 0);
	_direction = getDir (_x select 0);
	_class = typeOf (_x select 0);
	_detonator = (_x select 4);
	_clackerClass = (_x select 3);
	_explosives pushBack [_position, _direction, _class, _detonator, _clackerClass];
} forEach _exp;
_explosives;