/* ----------------------------------------------------------------------------
Description:
    Sets the status for this AOI

Parameters:
    _trigger				- The trigger that defines the location and size of this AOI
	_status					- can be one of the following values "ENEMY_DETECTED", "DISTRESS", "SAFE", "OBJECTIVE_LOST"

Returns:
    None

Examples:
    [_thisTrigger, _status] call aso_fnc_setAOIStatus

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_trigger", "_status"];

switch (_status) do {
	case "ENEMY_DETECTED": { _trigger setVariable ["ASO_DETECTED", true, true]; };
	case "DISTRESS": { _trigger setVariable ["ASO_DISTRESS", true, true]; };
	case "OBJECTIVE_LOST": { _trigger setVariable ["ASO_LOST", true, true]; };
	default 
	{
		_trigger setVariable ["ASO_SAFE", true, true];
		_trigger setVariable ["ASO_DETECTED", false, true];
		_trigger setVariable ["ASO_DISTRESS", false, true];
	}; // Safe means safe
};
["AOI status set", _status] call aso_fnc_debug;