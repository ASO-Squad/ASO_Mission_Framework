/* ----------------------------------------------------------------------------
Description:
    Remotly executes all function that are needed to save a groups state.
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
    [_group] call aso_fnc_executeSaveGroup;

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
		private _position = [_x] call aso_fnc_getPosition;
		private _inventory = [_x] call aso_fnc_getInventory;
		private _health = [_x] call aso_fnc_getHealth;
		private _mount = [_x] call aso_fnc_getMount;
		private _explosives = [_x] call aso_fnc_getExplosives;

		// save the stuff
		[groupId _group, _x, "Position", _position] call aso_fnc_writeValue;
		[groupId _group, _x, "Inventory", _inventory] call aso_fnc_writeValue;
		[groupId _group, _x, "Health", _health] call aso_fnc_writeValue;
		[groupId _group, _x, "Mount", _mount] call aso_fnc_writeValue;
		[groupId _group, _x, "Explosives", _explosives] call aso_fnc_writeValue;
	}
	else
	{
		private _position = [_x] remoteExecCall ["aso_fnc_getPosition", 2, false];
		private _inventory = [_x] remoteExecCall ["aso_fnc_getInventory", 2, false];
		private _health = [_x] remoteExecCall ["aso_fnc_getHealth", 2, false];
		private _mount = [_x] remoteExecCall ["aso_fnc_getMount", 2, false];
		private _explosives = [_x] remoteExecCall ["aso_fnc_getExplosives", 2, false];
		// save the stuff
		[groupId _group, _x, "Position", _position] remoteExecCall ["aso_fnc_writeValue", 2, false];
		[groupId _group, _x, "Inventory", _inventory] remoteExecCall ["aso_fnc_writeValue", 2, false];
		[groupId _group, _x, "Health", _health] remoteExecCall ["aso_fnc_writeValue", 2, false];
		[groupId _group, _x, "Mount", _mount] remoteExecCall ["aso_fnc_writeValue", 2, false];
		[groupId _group, _x, "Explosives", _explosives] remoteExecCall ["aso_fnc_writeValue", 2, false];
	};
} forEach units _group;
if (isServer) then
{
	private _waypoints = [_group] call aso_fnc_getWaypoints;
	[groupId _group, "Group", "Waypoints", _waypoints] call aso_fnc_writeValue;
}
else 
{
	private _waypoints = [_group] remoteExecCall ["aso_fnc_getWaypoints", 2, false];
	[groupId _group, "Group", "Waypoints", _waypoints] remoteExecCall ["aso_fnc_writeValue", 2, false];
};
true;