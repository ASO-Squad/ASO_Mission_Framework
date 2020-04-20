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
					If you leave this array empty, all players get saved.

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
		_position = [_x] call aso_fnc_getPosition;
		_inventory = [_x] call aso_fnc_getInventory;
		_health = [_x] call aso_fnc_getHealth;
		_mount = [_x] call aso_fnc_getMount;
		_explosives = [_x] call aso_fnc_getExplosives;

		// save the stuff
		[groupId _group, _x, "Position", _position] call aso_fnc_writeValue;
		[groupId _group, _x, "Inventory", _inventory] call aso_fnc_writeValue;
		[groupId _group, _x, "Health", _health] call aso_fnc_writeValue;
		[groupId _group, _x, "Mount", _mount] call aso_fnc_writeValue;
		[groupId _group, _x, "Explosives", _explosives] call aso_fnc_writeValue;
	}
	else
	{
		_position = [_x] remoteExecCall ["aso_fnc_getPosition", 2, false]; // Call this on the server
		_inventory = [_x] remoteExecCall ["aso_fnc_getInventory", 2, false]; // Call this on the server
		_health = [_x] remoteExecCall ["aso_fnc_getHealth", 2, false]; // Call this on the server
		_mount = [_x] remoteExecCall ["aso_fnc_getMount", 2, false]; // Call this on the server
		_explosives = [_x] remoteExecCall ["aso_fnc_getExplosives", 2, false]; // Call this on the server
		// save the stuff
		[groupId _group, _x, "Position", _position] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server
		[groupId _group, _x, "Inventory", _inventory] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server
		[groupId _group, _x, "Health", _health] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server	
		[groupId _group, _x, "Mount", _mount] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server	
		[groupId _group, _x, "Explosives", _explosives] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server	
	};
} forEach units _group;