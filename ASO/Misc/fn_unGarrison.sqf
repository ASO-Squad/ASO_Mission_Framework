/* ----------------------------------------------------------------------------
Description:
    Do not move the group members, this is useful if you hand-place them in certain spots, eg. Buildings.

Parameters:
    _group			- Group to track
	_position		- where to we start to patrol
	_radius			- how far do we move on our patrol
	_onContact		- UnGarrison on contact
	_onAid			- Allow movement if VCOM AI has called for aid
	_onDistance		- If the group is too far away, allow them to move on
	_waitFor		- Wait for another script to finish eg. taskDefend

Returns:
    None

Examples:
    [_group] spawn aso_fnc_unGarrison;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};
params ["_group", "_position", "_radius", ["_onContact", true], ["_onAid", true], ["_onDistance", true], ["_waitFor", false]];

if (typeName _waitfor != "BOOL") then 
{
	["Wait", "DONE", true] call aso_fnc_debug;
	waitUntil { scriptDone _waitFor }; // we need to wait here
};

private _allowMovement = false;
while {!_allowMovement} do 
{
	if (_onContact) then 
	{
		_contacts = leader _group targetsQuery [objNull, ASO_BLUFOR, "", [], 0];
		{
			if ((_x select 0) >= 0.90) then 
			{
				_allowMovement = true;
			};
			
		} forEach _contacts;
	};
	if (_onAid) then 
	{
		private _request = _group getVariable ["VCM_MOVE2SUP", false];
		if (_request) then 
		{
			_allowMovement = true;
		};
	};
	if (_onDistance) then 
	{
		_groupPos = leader _group;
		_distance = _groupPos distance2D _position;
		// When the units are too far away, let them run further
		if (_distance > _radius) then 
		{
			_allowMovement = true;
		};
	};
	sleep 20;	
};
// move at least the leader out of its static weapon
_leader = leader _group;
_vehicle = vehicle _leader;
if (_vehicle isKindOf "StaticWeapon") then
{
	unassignVehicle _leader;
};
//using ACE unGarrison Script
["UnGarrison", "YES", true] call aso_fnc_debug;
[units _group] call ace_ai_fnc_unGarrison;
// Refreshing waypoints so that the units start moving
private _wp = [_group] call aso_fnc_getWaypoints;
[_group, _wp, true] spawn aso_fnc_setWaypoints;
// just to make sure (yes i am desperate at this point)
sleep 20;
[units _group] call ace_ai_fnc_unGarrison;
true;
