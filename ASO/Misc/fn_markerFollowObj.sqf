/* ----------------------------------------------------------------------------
Description:
    Set the position according to a target object. This is useful to have a respawn follw a certain object.
	This code should be executed on the server only.

Parameters:
    _markerName  	- The marker that has to change its position
    _object  		- The object we want to follow
	_interval		- how often positions are updated (in seconds)

Returns:
    None

Example:
    ["marker", object, 60] call aso_fnc_markerFollowObj

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_markerName", "_object", "_interval"];

while {true} do 
{
	_markerName setMarkerPos (getPos _object);
	sleep _interval;	
};