/* ----------------------------------------------------------------------------
Description:
    This function is used to let a group patrol a certain trigger. 
	The trigger has to be either provided by a parameter or sychronized
	to the groups leader. 
	If you call this function from the init-field of a group, the orders
	given here will be overwritten by any load-function called from initServer.sqf
	See initialization order here:
	https://community.bistudio.com/wiki/Initialization_Order


Parameters:
    _group      - the group guarding the area
	_time 		- Time until dynamicSim is enabled. -1 for never.
    _trigger   	- trigger that is to be defended, should be a circle

Returns:
    None

Example:
    [this] call aso_fnc_patrol;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", ["_time", 120], ["_trigger", objNull]];

//find a syncronized trigger
private _sync = synchronizedObjects leader _group;

{
	scopeName "main";
	if (_x isKindOf "EmptyDetector") then 
	{
		_trigger = _x;
		breakOut "main";
	};
	
} forEach _sync;

// no trigger found or given
if (isNull _trigger) exitWith {false;};

private _position = getPos _trigger;
private _radius = (triggerArea _trigger) select 0;

// Give them their new order
[_group, _position, _radius, 10, "MOVE", "SAFE", "YELLOW", "LIMITED", "FILE", "", [0,3,10]] call CBA_fnc_taskPatrol;

// Add group to group list
[_group, _time] call aso_fnc_collectGroup;

//Track group for debug purposes
[_group] spawn aso_fnc_trackGroup;

true;
