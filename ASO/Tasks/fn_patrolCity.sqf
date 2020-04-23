/* ----------------------------------------------------------------------------
Description:
    This function is used to let a group patrol a certain trigger. It will 
	also search buildings at random. 
	The trigger has to be either provided by a parameter or sychronized
	to the groups leader. 
	If you call this function from the init-field of a group, the orders
	given here will be overwritten by any load-function called from initServer.sqf
	See initialization order here:
	https://community.bistudio.com/wiki/Initialization_Order


Parameters:
    _group      - the group guarding the area
    _trigger   	- trigger that is to be defended, should be a circle

Returns:
    None

Example:
    [_group] call aso_fnc_patrolCity;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", ["_trigger", objNull]];

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
[_group, _trigger, "UNCHANGED", "NO CHANGE", "LIMITED", "FILE", "", [0,3,10]] call CBA_fnc_taskSearchArea;

// Add group to group list
[_group] call aso_fnc_collectGroup;

// Use dynamic simulation
[_group, 120] spawn aso_fnc_enableDynamicSim;
true;
