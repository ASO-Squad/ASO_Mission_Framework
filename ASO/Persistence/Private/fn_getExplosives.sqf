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
private _exp = [_unit] call ACE_Explosives_fnc_getPlacedExplosives;
private _explosives = [];
{
	private _position = getPosATL (_x select 0);
	private _direction = getDir (_x select 0);
	private _class = typeOf (_x select 0);
	private _detonator = (_x select 4);
	private _clackerClass = (_x select 3);
	_explosives pushBack [_position, _direction, _class, _detonator, _clackerClass];
} forEach _exp;
_explosives;