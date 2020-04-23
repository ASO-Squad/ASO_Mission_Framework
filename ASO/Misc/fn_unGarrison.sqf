/* ----------------------------------------------------------------------------
Description:
    Do not move the group members, this is useful if you hand-place them in certain spots, eg. Buildings.

Parameters:
    _group			- Group to track
	_position		- where to we start to patrol
	_radius			- how far do we move on our patrol
	_onContact		- UnGarrison on contact
	_onAid			- Allow movement if VCOM AI has called for aid 

Returns:
    None

Examples:
    [_group] spawn aso_fnc_unGarrison;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
params ["_group", "_position", "_radius", ["_onContact", true], ["_onAid", true]];

private _allowMovement = false;
while {!_allowMovement} do 
{
	["Check", "OK", true] call aso_fnc_debug;
	if (_onContact) then 
	{
		_contacts = leader _group targetsQuery [objNull, ASO_BLUFOR, "", [], 0];
		{
			if ((_x select 0) >= 0.90) then 
			{
				_allowMovement = true;
				["Contact", "OK", true] call aso_fnc_debug;
			};
			
		} forEach _contacts;
	};
	if (_onAid) then 
	{
		private _request = _group getVariable ["VCM_MOVE2SUP", false];
		if (_request) then 
		{
			_allowMovement = true;
			{
				_x enableAIFeature ["PATH", true];
			} forEach units _group;
			["Support", "OK", true] call aso_fnc_debug;
		};
	};
	sleep 5;	
};