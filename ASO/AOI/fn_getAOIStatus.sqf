/* ----------------------------------------------------------------------------
Description:
    gets the current status for this AOI

Parameters:
    _trigger				- The trigger that defines the location and size of this AOI
	_status					- status that I want to know about. Can be one of the following values:
							  "ASO_SAFE", "ASO_DETECTED", "ASO_DISTRESS", "ASO_LOST"

Returns:
    None

Examples:
    [_thisTrigger, _status] call aso_fnc_getAOIStatus

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_trigger", "_status"];

_trigger getVariable [_status, false];