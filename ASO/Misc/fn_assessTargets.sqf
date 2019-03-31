/* ----------------------------------------------------------------------------
Description:
    Returns all units from a trigger, and shares that information with the given AOI.

Parameters:
	_trigger		- the trigger that assesses the targets
	_AOI			- The AOI that this information is shared with
	_shareDistance	- Share information with reinforcments this far away. Mounted troops will disembark at this distance.  
	_keepTracking 	- Keep tracking until deactivated

Returns:
    [ListOfUnits]

Example:
    arrayOfUnits = [_trigger, _AOI, 1000, true] spawn aso_fnc_assessTargets

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_trigger", "_AOI", "_shareDistance", "_keepTracking"];

// let the world know we started tracking enemies
_trigger setVariable ["ASO_ASSESSING", true, true];
while {(_trigger getVariable ["ASO_ASSESSING", false])} do 
{
	_targets = list _trigger;
	// Quit if there is nothing to do
	if ((isNil "_targets")) exitWith {};
	_targets = _targets - [objNull];
	if (ASO_DEBUG) then
	{
		//delete previous markers
		{
			deleteMarker _x;
			
		} forEach ASO_DEBUG_TRACKER;
		{
			_name = format["unit_%1_%2", _x, time];
			_debugMarker = createMarker [_name, getPos _x];
			_debugMarker setMarkerShape "ICON";
			_debugMarker setMarkerType "o_unknown";
			//_name setMarkerText _name;
			ASO_DEBUG_TRACKER pushBack _name;

		} forEach _targets;
	};
	// All units detected by the provided trigger
	_detectedUnits = list _trigger;
	// All groups that I want to share the detected units with
	_AOITroops = [_AOI] call aso_fnc_getAOIGroups;
	_reinforcements = [_AOI] call aso_fnc_getAOIReinforcementGroups;
	//_AOITroops = _AOITroops + _reinforcements;
	// show targets to everyone in the AOI
	{
		_toWhom = leader _x;
		{
			_toWhom reveal [_x, 1.2];	
		} forEach _detectedUnits;
	} forEach _AOITroops;
	// show targets to reinforcments
	{
		_toWhom = leader _x;
		if ((_toWhom distance2D _AOI) <= _shareDistance) then
		{
			{
				_toWhom reveal [_x, 1.2];	
			} forEach _detectedUnits;
		};
	} forEach _reinforcements;
	["Targets ASSESSED", _targets] call aso_fnc_debug;
	// Keep tracking after first loop if desired 
	_trigger setVariable ["ASO_ASSESSING", _keepTracking, true];
	// stop tracking if there are no more enemies
	if ((count _targets) == 0) then 
	{
		_trigger setVariable ["ASO_ASSESSING", false, true];
	};
	if (!_keepTracking) exitWith {}; // immediatly exit if we do not continue to track
	sleep 30;
};
// Return the triggers list
list _trigger;