/* ----------------------------------------------------------------------------
Description:
    Returns all units from a trigger, and shares that information with the given AOI.

Parameters:
    _trigger	- the trigger that assesses the targets
	_AOI		- The AOI that this information is shared with

Returns:
    [ListOfUnits]

Example:
    arrayOfUnits = [_trigger, _AOI] call aso_fnc_assessTargets

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_trigger", "_AOI"];

_targets = list _trigger; 
if (ASO_DEBUG) then
{
	{
		_name = format["unit_%1_%2", _x, time];
		_debugMarker = createMarker [_name, getPos _x];
		_debugMarker setMarkerShape "ICON";
		_debugMarker setMarkerType "o_unknown";
		_name setMarkerText _name;

	} forEach _targets;
};
// All units detected by the provided trigger
_detectedUnits = list _trigger;
// All groups that I want to share the detected units with
_AOITroops = [_AOI] call aso_fnc_getAOIGroups;
// show thyself!
{
	_toWhom = leader _x;
	{
		_toWhom reveal [_x, 2.2];	
	} forEach _detectedUnits;
} forEach _AOITroops;
["Targets ASSESSED", _targets] call aso_fnc_debug;
// Return the triggers list
_detectedUnits