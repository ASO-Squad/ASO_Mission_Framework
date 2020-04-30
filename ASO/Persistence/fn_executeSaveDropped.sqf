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
if (!isServer) exitWith {false;};

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
	private _position = [_x] call aso_fnc_getPosition;
	private _items = [_x] call aso_fnc_getCargo;

	["GroundItems", _name, "Position", _position] call aso_fnc_writeValue;
	["GroundItems", _name, "Items", _items] call aso_fnc_writeValue;
	_weaponHolders = _forEachIndex;
	
} forEach _container;
true;