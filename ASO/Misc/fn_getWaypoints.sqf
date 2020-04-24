/* ----------------------------------------------------------------------------
Description:
   Returns the Waypoints of a given group.
   TODO: Add the other waypoint attributes when neccessary

Parameters:
    _group	- Group we want the waypoints from

Returns:
    Waypoint array

Examples:
    [_group] call aso_fnc_getWaypoints;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group"];
private _waypoints = [];
private _wpList = waypoints _group;

// Adding the current WP first
_waypoints pushBack currentWaypoint _group;

{
	private _name = waypointName _x;
	private _pos = waypointPosition _x;
	private _type = waypointType _x;
	private _behave = waypointBehaviour _x;
	private _formation = waypointFormation _x;
	private _combat = waypointCombatMode _x;
	private _comRad = waypointCompletionRadius _x;
	private _speed = waypointSpeed _x;
	_waypoints pushBack [_name, _pos, _type, _behave, _formation, _combat, _comRad, _speed]; 
	
} forEach _wpList;
_waypoints;