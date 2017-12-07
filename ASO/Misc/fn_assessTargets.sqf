/* ----------------------------------------------------------------------------
Description:
    Ask the leader of a group for units of a side he knows

Parameters:
    _trigger - the trigger that assesses the targets

Returns:
    None

Example:
    [_group, east] call aso_fnc_assessTargets

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_trigger"];

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
["Targets ASSESSED", _targets] call aso_fnc_debug;