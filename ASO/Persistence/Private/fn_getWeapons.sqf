/* ----------------------------------------------------------------------------
Description:
    Returns all the weapons and ammo of the given vehicle.

Parameters:
    _vehicle	- The vehicle that we want to track

Returns:
    Weapons and Ammo count

Example:
    [_vehicle] call aso_fnc_saveWeapons;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_vehicle"];

// Variables
_mags = magazinesAllTurrets _vehicle;
// Just save data we needReload
_magazines = [];
{
    _magazines pushBack [(_x select 0), (_x select 1), (_x select 2)];    
} forEach _mags;

_magazines;