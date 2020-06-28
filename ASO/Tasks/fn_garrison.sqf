/* ----------------------------------------------------------------------------
Description:
    This function is used to let a occupy guard a certain trigger. 
	The trigger has to be either provided by a parameter or sychronized
	to the groups leader. 
	If you call this function from the init-field of a group, the orders
	given here will be overwritten by any load-function called from initServer.sqf
	See initialization order here:
	https://community.bistudio.com/wiki/Initialization_Order


Parameters:
    _group      - the group guarding the area
	_answer		- if false, this group does not answer calls for help
	_time 		- Time until dynamicSim is enabled. -1 for never.
    _trigger   	- trigger that is to be defended, should be a circle
	_radius		- if you can't provide a trigger, the starting position and 
				this radius is used

Returns:
    None

Example:
    [this] spawn aso_fnc_garrison;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", ["_answer", true], ["_time", 90], ["_radius", 50], ["_trigger", objNull]];

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
private _position = getPos leader _group;
private _radius = _radius;
// trigger found or given
if (!isNull _trigger) then 
{
	_position = getPos _trigger;
	_radius = (triggerArea _trigger) select 0;
};
// Give them their new order
_task = [_group, _position, _radius, 2, false, 0.5] spawn CBA_fnc_taskDefend;

// Add group to group list
[_group, _time] call aso_fnc_collectGroup;

// make them ignore calls for help 
if (!_answer) then 
{
	(_group) setVariable ["VCM_NORESCUE",true];
}
else 
{
	// we need to wait until taskDefend is done
	[_group, _position, _radius, true, true, true, _task] spawn aso_fnc_unGarrison;
};

//Track group for debug purposes
[_group] spawn aso_fnc_trackGroup;
true;
