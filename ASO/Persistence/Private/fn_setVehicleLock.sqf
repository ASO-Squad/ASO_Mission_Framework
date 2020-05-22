/* ----------------------------------------------------------------------------
Description:
    Sets the lock state of the specified vehicle

Parameters:
    _vehicle    - the Vehicle that we want to set the lock for
    _lock       - Lock state

Returns:
    none

Example:
    [_vehicle, _lock] call aso_fnc_setVehicleLock;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_vehicle", "_lock"];

if (([_lock] call aso_fnc_isReadError)) exitWith {false;}; 
_vehicle lock _lock;
true;