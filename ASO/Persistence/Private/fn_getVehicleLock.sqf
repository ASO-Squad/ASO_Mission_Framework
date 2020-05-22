/* ----------------------------------------------------------------------------
Description:
    Gets the lock state of the specified vehicle

Parameters:
    _vehicle

Returns:
    lock

Example:
    [_vehicle] call aso_fnc_getVehicleLock;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_vehicle"];

// Variables
private _lock = locked _vehicle;
_lock;