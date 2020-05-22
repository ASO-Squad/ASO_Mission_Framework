/* ----------------------------------------------------------------------------
Description:
    Allow movement of the group members.

Parameters:
    _group			- Group to track

Returns:
    None

Examples:
    [_group] spawn aso_fnc_doMove;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group"];

{
	_x enableAIFeature ["PATH", true];
	_cargo allowGetIn true;
	
} forEach units _group;
true;