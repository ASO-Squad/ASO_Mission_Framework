/* ----------------------------------------------------------------------------
Description:
    Gets the damage of the given vehicle or object.

Parameters:
    _vehicle		- The vehicle that we want to track

Returns:
    Dammage array

Example:
    [_vehicle] call aso_fnc_getDamage;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_vehicle"];

// Variables
private _allDamages = getAllHitPointsDamage _vehicle;
private _hitpoints = [];
private _damages = [];
if ((count _allDamages) > 0) then
{
    _hitpoints = (_allDamages select 0);
    _damages = (_allDamages select 2); 
};
private _damage = damage _vehicle;

[_hitpoints, _damages, _damage]