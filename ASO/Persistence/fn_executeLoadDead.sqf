/* ----------------------------------------------------------------------------
Description:
    Remotly executes all function that are needed to load all dead units state.
	That includes:
	- Position
	- Inventory	
	- Health
	- Vehicle/w. Seat
	- Linked mines
	- Waypoints

Parameters:
    none

Returns:
    nothing

Example:
    [] call aso_fnc_executeLoadDead;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};
{
	private _position = ["DeadMen", _x, "Position"] call aso_fnc_readValue;
	private _inventory = ["DeadMen", _x, "Inventory"] call aso_fnc_readValue;
	private _health = ["DeadMen", _x, "Health"] call aso_fnc_readValue;
	private _mount = ["DeadMen", _x, "Mount"] call aso_fnc_readValue;
	private _explosives = ["DeadMen", _x, "Explosives"] call aso_fnc_readValue;

	[_x, _position] call aso_fnc_setPosition;
	[_x, _inventory] call aso_fnc_setInventory;
	[_x, _health] call aso_fnc_setHealth;
	[_x,_mount] call aso_fnc_setMount;
	[_x, _explosives] call aso_fnc_setExplosives;

} forEach ASO_UNITS;
true;