/* ----------------------------------------------------------------------------
Description:
    Do not move the group members, this is useful if you hand-place them in certain spots, eg. Buildings.

Parameters:
    _group			- Group to track
	_moveOnContact	- Allow the Group to move on contact

Returns:
    None

Examples:
    [_group, false] spawn aso_fnc_doNotMove;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", ["_moveOnContact", true]];

{
	_x enableAIFeature ["PATH", false];
	
} forEach units _group;

if (_moveOnContact) then
{
	_noContact = true;
	while {!(isNULL _group)} do
	{
		scopeName "loop";
		_contacts = leader _group targetsQuery [objNull, sideUnknown, "", [], 0];
		{

			if ((_x select 0) >= 0.95 && [side _group, _x select 2] call BIS_fnc_sideIsEnemy) then 
			{
				breakOut "loop";
			};
			
		} forEach _contacts;
		uiSleep 10;
	};
	{
		_x enableAIFeature ["PATH", true];
		
	} forEach units _group;
};
true;