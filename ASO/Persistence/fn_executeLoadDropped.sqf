/* ----------------------------------------------------------------------------
Description:
    Loads everything dropped on the ground.

Parameters:
	nothing

Returns:
    nothing

Example:
    [] call aso_fnc_executeLoadDropped;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};
_database = format ["%1_%2", ASO_PREFIX, "GroundItems"];
_inidbi = ["new", _database] call OO_INIDBI;
if (!("exists" call _inidbi)) exitWith {false};

private _sections = "getSections" call _inidbi;

{
	// preloading information
	private _position = ["GroundItems", _x, "Position"] call aso_fnc_readValue;
	private _items = ["GroundItems", _x, "Items"] call aso_fnc_readValue;

	_holder = createVehicle ["GroundWeaponHolder_Scripted", [0,0,0], [], 0, ""]; // This does not delete itself (at all!)
	[_holder, _items] call aso_fnc_setCargo;
	[_holder, _position] call aso_fnc_setPosition;
	_holder setVehicleVarName _x;

} forEach _sections;
true;