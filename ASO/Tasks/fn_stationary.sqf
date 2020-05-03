/* ----------------------------------------------------------------------------
Description:
    This function is used to let a group be stationary. 
	which means, all group member will stay where they where placed in the editor.
	Enemy contact will eventually allow them to move.
	If you call this function from the init-field of a group, the orders
	given here will be overwritten by any load-function called from initServer.sqf
	See initialization order here:
	https://community.bistudio.com/wiki/Initialization_Order


Parameters:
    _group      - the group guarding the area
	_move		- if true, the units will start moving on enemy contact

Returns:
    None

Example:
    [_group] call aso_fnc_stationary;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group",["_move", true]];

// Give them their new order
[_group, _move] spawn aso_fnc_doNotMove;
(_group) setVariable ["VCM_NORESCUE",true];

// Add group to group list
[_group] call aso_fnc_collectGroup;

// Use dynamic simulation
[_group, 60] spawn aso_fnc_enableDynamicSim;
true;
