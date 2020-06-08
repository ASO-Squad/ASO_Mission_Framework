/* ----------------------------------------------------------------------------
Description:
    Remotly execute all functions that are needed to save dead units
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
    [] call aso_fnc_executeSaveDead;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

// If the unit array is empty, save all players
{
	if (!("CivilianPresence" in (typeOf _x))) then
	{
		private _position = [_x] call aso_fnc_getPosition;
		private _inventory = [_x, "DeadMen"] call aso_fnc_getInventory;
		private _health = [_x] call aso_fnc_getHealth;
		private _mount = [_x] call aso_fnc_getMount;
		private _explosives = [_x] call aso_fnc_getExplosives;

		// save the stuff
		["DeadMen", _x, "Position", _position] call aso_fnc_writeValue;
		["DeadMen", _x, "Health", _health] call aso_fnc_writeValue;
		["DeadMen", _x, "Mount", _mount] call aso_fnc_writeValue;
		["DeadMen", _x, "Explosives", _explosives] call aso_fnc_writeValue;	
	};
	
} forEach allDeadMen;
true;