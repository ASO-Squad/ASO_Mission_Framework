/* ----------------------------------------------------------------------------
Description:
    Remotly executes all function that are needed to load a groups state.
	That includes:
	- Position
	- Inventory	
	- Health
	- Vehicle/w. Seat
	- Linked mines
	- Waypoints

Parameters:
    _group			- The group that we want to save.

Returns:
    nothing

Example:
    [_group] call aso_fnc_executeLoadGroup;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group"];

if (typeName _group != "GROUP") exitWith 
{
	["Not a group but of type", typeName _this] call aso_fnc_debug;
};
// If the unit array is empty, save all players
{
	if (isServer) then
	{
		// save the stuff
		private _position = [groupId _group, _x, "Position"] call aso_fnc_readValue;
		private _inventory = [groupId _group, _x, "Inventory"] call aso_fnc_readValue;
		private _health = [groupId _group, _x, "Health"] call aso_fnc_readValue;
		private _mount = [groupId _group, _x, "Mount"] call aso_fnc_readValue;
		private _explosives = [groupId _group, _x, "Explosives"] call aso_fnc_readValue;

		[_x, _position] call aso_fnc_setPosition;
		[_x, _inventory] call aso_fnc_setInventory;
		[_x, _health] call aso_fnc_setHealth;
		[_x,_mount] call aso_fnc_setMount;
		[_x, _explosives] call aso_fnc_setExplosives;
	}
	else
	{
		private _position = [groupId _group, _x, "Position"] remoteExecCall ["aso_fnc_readValue", 2, false];
		private _inventory = [groupId _group, _x, "Inventory"] remoteExecCall ["aso_fnc_readValue", 2, false];
		private _health = [groupId _group, _x, "Health"] remoteExecCall ["aso_fnc_readValue", 2, false];
		private _mount = [groupId _group, _x, "Mount"] remoteExecCall ["aso_fnc_readValue", 2, false];
		private _explosives = [groupId _group, _x, "Explosives"] remoteExecCall ["aso_fnc_readValue", 2, false];
		// save the stuff
		[_x, _position] remoteExecCall ["aso_fnc_setPosition", 2, false];
		[_x, _inventory] remoteExecCall ["aso_fnc_setInventory", 2, false];
		[_x, _health, true] remoteExecCall ["aso_fnc_setHealth", 2, false];
		[_x, _mount] remoteExecCall ["aso_fnc_setMount", 2, false];
		[_x, _explosives] remoteExecCall ["aso_fnc_setExplosives", 2, false];
	};
} forEach units _group;
if (isServer) then
{
	private _waypoints = [groupId _group, "Group", "Waypoints"] call aso_fnc_readValue;
	[_group, _waypoints] spawn aso_fnc_setWaypoints;
}
else 
{
	private _waypoints = [groupId _group, "Group", "Waypoints"] remoteExecCall ["aso_fnc_readValue", 2, false];
	[_group, _waypoints] remoteExec ["aso_fnc_setWaypoints", 2, false];
};
true;