/* ----------------------------------------------------------------------------
Description:
    Saves everything dropped on the ground.

Parameters:
	nothing

Returns:
    nothing

Example:
    [] call aso_fnc_executeSaveDropped;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

// Gather all containers on the ground ... this may take a while.
private _container = ((allMissionObjects "GroundWeaponHolder") + (entities "WeaponHolderSimulated"));
private _weaponHolders = 0;
{
	private _name = format["weaponHolder_%1", _forEachIndex];
	_x setVehicleVarName _name;
	if (isServer) then
	{
		private _position = [_x] call aso_fnc_getPosition;
		private _items = [_x] call aso_fnc_getCargo;

		["GroundItems", _name, "Position", _position] call aso_fnc_writeValue;
		["GroundItems", _name, "Items", _items] call aso_fnc_writeValue;
	}
	else
	{
		private _position = [_x] remoteExecCall ["aso_fnc_getPosition", 2, false]; 
		private _items = [_x] remoteExecCall ["aso_fnc_getCargo", 2, false];

		["GroundItems", _name, "Position", _position] remoteExecCall ["aso_fnc_writeValue", 2, false]; 
		["GroundItems", _name, "Items", _items] remoteExecCall ["aso_fnc_writeValue", 2, false];
	};
	_weaponHolders = _forEachIndex;
} forEach _container;
true;