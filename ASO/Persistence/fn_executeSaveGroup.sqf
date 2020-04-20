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
		_inventory = [_x, _saveByName, _prefix] call aso_fnc_getInventory;
		_position = [_x, _saveByName, _prefix] call aso_fnc_getPosition;
		//[_x, _saveByName, _prefix] call aso_fnc_saveHealth;
		_mount = [_x, _saveByName, _prefix] call aso_fnc_getMount;
		_explosives = [_x, _saveByName, _prefix] call aso_fnc_getExplosives;

		// save the stuff
		[_position, "Position", groupId _group, _x] call aso_fnc_writeValue;
		[_inventory, "Inventory", groupId _group, _x] call aso_fnc_writeValue;
		[_mount, "Mount", groupId _group, _x] call aso_fnc_writeValue;
		[_explosives, "Explosives", groupId _group, _x] call aso_fnc_writeValue;
	}
	else
	{
		_inventory = [_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_getInventory", 2, false]; // Call this on the server
		_position = [_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_getPosition", 2, false]; // Call this on the server
		//[_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_saveHealth", 2, false]; // Call this on the server
		_mount = [_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_getMount", 2, false]; // Call this on the server
		_explosives = [_x, _saveByName, _prefix] remoteExecCall ["aso_fnc_getExplosives", 2, false]; // Call this on the server
		// save the stuff
		[_position, "Position", groupId _group, _x] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server
		[_inventory, "Inventory", groupId _group, _x] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server	
		[_mount, "Mount", groupId _group, _x] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server	
		[_explosives, "Explosives", groupId _group, _x] remoteExecCall ["aso_fnc_writeValue", 2, false]; // Call this on the server	
	};
} forEach units _group;