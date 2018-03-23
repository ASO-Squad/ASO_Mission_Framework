/* ----------------------------------------------------------------------------
Description:
    gets the current status for this AOI

Parameters:
    _trigger				- The trigger that defines the location and size of this AOI
	_status					- status that I want to know about. Can be one of the following values:
							  "ASO_SAFE", "ASO_DETECTED", "ASO_DISTRESS", "ASO_LOST"
    Explanation:    TRUE                    FALSE
	ASO_SAFE 	    The AOI is safe         The AOI is under attack
	ASO_DETECTED    Enemies are detected	No known enemy in the AOI	
	ASO_DISTRESS	The AOI is in distress  There is no cause for alarm
                    and calling for help
    ASO_LOST        This AOI is lost        This AOI is still worth fighting for

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