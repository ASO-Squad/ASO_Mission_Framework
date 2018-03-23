/* ----------------------------------------------------------------------------
Description:
    gets the taskname for this AOI

Parameters:
    _trigger    - The trigger that defines the location and size of this AOI

Returns:
    A taskname

Examples:
    [_trigger] call aso_fnc_getAOITask

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_trigger"];

_trigger getVariable ["ASO_TASK", false];