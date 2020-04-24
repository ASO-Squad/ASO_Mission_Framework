/* ----------------------------------------------------------------------------
Description:
    This function is used to let a group guard a certain trigger. 
	The trigger has to be either provided by a parameter or sychronized
	to the groups leader. 
	If you call this function from the init-field of a group, the orders
	given here will be overwritten by any load-function called from initServer.sqf
	See initialization order here:
	https://community.bistudio.com/wiki/Initialization_Order


Parameters:
    _group      - the group guarding the area
	_answer		- if false, this group does not answer calls for help
    _trigger   	- trigger that is to be defended, should be a circle

Returns:
    None

Example:
    [_group] call aso_fnc_garrison;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group",["_answer", true], ["_trigger", objNull]];

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
[_group, _position, _radius, 1, false, 0.5] call CBA_fnc_taskDefend;

// Add group to group list
[_group] call aso_fnc_collectGroup;

// Use dynamic simulation
[_group, 60] spawn aso_fnc_enableDynamicSim;

// make them ignore calls for help 
if (!_answer) then 
{
	(_group) setVariable ["VCM_NORESCUE",true];
}
else 
{
	[_group, _position, _radius, false, true, true] spawn aso_fnc_unGarrison;
};
true;
