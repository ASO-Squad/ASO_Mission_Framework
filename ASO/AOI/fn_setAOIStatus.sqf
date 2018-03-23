/* ----------------------------------------------------------------------------
Description:
    Sets the status for this AOI

Parameters:
    _AOI		- The trigger that defines the location and size of this AOI
	_status		- can be one of the following values "ENEMY_DETECTED", "DISTRESS", "CONTROL", "SAFE", "OBJECTIVE_LOST"
	Explanation: 
	ENEMY_DETECTED 	- It's obvious
	DISTRESS		- The AOI owner has lost control
	CONTROL			- The AOI owner is in control (again)
	SAFE			- The AOI is safe
	OBJECTIVE_LOST	- The AOI is lost to the original owner for good.

Returns:
    None

Examples:
    [_thisTrigger, _status] call aso_fnc_setAOIStatus

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_AOI", "_status"];

switch (_status) do {
	case "ENEMY_DETECTED": { _AOI setVariable ["ASO_DETECTED", true, true]; };
	case "DISTRESS": { _AOI setVariable ["ASO_DISTRESS", true, true]; };
	case "CONTROL": { _AOI setVariable ["ASO_DISTRESS", false, true]; };
	case "OBJECTIVE_LOST": { _AOI setVariable ["ASO_LOST", true, true]; };
	default 
	{
		_AOI setVariable ["ASO_SAFE", true, true];
		_AOI setVariable ["ASO_DETECTED", false, true];
		_AOI setVariable ["ASO_DISTRESS", false, true];
	}; // Safe means safe
};
["AOI status set", _status] call aso_fnc_debug;