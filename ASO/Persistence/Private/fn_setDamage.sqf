/* ----------------------------------------------------------------------------
Description:
    Loads the damage of the given vehicle, and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
    _vehicle		- The vehicle that we want to load
	_damageArray	- Damage array
Returns:
    nothing

Example:
    [_vehicle, _damage] call aso_fnc_loadDamage;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_vehicle", "_damageArray"];

if (([_damageArray] call aso_fnc_isReadError)) exitWith {false;}; 

// Load information
private _hitpoints = _damageArray select 0;
private _damages = _damageArray select 1;
private _damage = _damageArray select 2;
// Apply dammage
if (typeName _hitpoints != "ARRAY") exitWith {};
// This vehicle is most probably already burnt down
_vehicle setVariable ["ace_cookoff_enable", false, true];
_vehicle setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
_vehicle setDamage [_damage, false];
if (local _vehicle) then
{
	{
        _vehicle setHitPointDamage [_x, (_damages select _forEachIndex), true];
    } forEach _hitpoints;
}
else
{
    {
        [_x, (_damages select _forEachIndex), false] remoteExec ["setHitPointDamage", _x, false]; // setHitPointDamage needs local parameters  
    } forEach _hitpoints;
};
if (alive _vehicle) then 
{
    _vehicle setVariable ["ace_cookoff_enable", true, true];
    _vehicle setVariable ["ace_cookoff_enableAmmoCookoff", true, true];
};
true;