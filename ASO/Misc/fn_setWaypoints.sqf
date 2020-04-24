/* ----------------------------------------------------------------------------
Description:
   Sets the Waypoints of a given group.
   TODO: Add the other waypoint attributes when neccessary

Parameters:
    _group		- Group we want the waypoints from
	_waypoints	- A waypoint array
	_overwrite 	- Overwrite existing waypoints

Returns:
    nothing

Examples:
    [_group _waypoints, true] spawn aso_fnc_setWaypoints;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_group", "_waypoints", ["_overwrite", true]];

private _currentWp = 1;
private _wp = [];

if (_overwrite) then 
{
	// delete all previous waypoints
	while {(count (waypoints _group)) > 0} do
	{
		deleteWaypoint ((waypoints _group) select 0);
	};
	sleep 2; // This is somehow needed to actually work
};

{
	if (typeName _x != "ARRAY") then 
	{
		_currentWp = _x;
	}
	else 
	{
		private _name = _x select 0;
		private _pos = _x select 1;
		private _type = _x select 2;
		private _behave = _x select 3;
		private _formation = _x select 4;
		private _combat = _x select 5;
		private _comRad = _x select 6;
		private _speed = _x select 7;

		_wp = _group addWaypoint [_pos, 0];
		_wp setWaypointType _type;
		_wp setWaypointBehaviour _behave;
		_wp setWaypointFormation _formation;
		_wp setWaypointCombatMode _combat;
		_wp setWaypointCompletionRadius _comRad;
		_wp setWaypointSpeed _speed;
	};
} forEach _waypoints;
_group setCurrentWaypoint [_group, _currentWp];
true;
