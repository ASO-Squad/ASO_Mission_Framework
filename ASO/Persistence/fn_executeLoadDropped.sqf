/* ----------------------------------------------------------------------------
Description:
    Loads everything dropped on the ground and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
	_prefix		- Prefix to be used for the database. This is usually used to identify different missions
				If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_prefix] call aso_fnc_executeLoadDropped;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_prefix", ASO_PREFIX]];

// How many weaponHolders do we need to create?
_inidbi = ["new", format["%1_%2", _prefix, "WeaponHolders"]] call OO_INIDBI;
// Check if there is something to load
if (!("exists" call _inidbi)) exitWith {};
// We must know how many weapon holders to use
_weaponHolders = ["read", ["Info", "Count"]] call _inidbi;

_count = 0;
while {_count <= _weaponHolders} do 
{
	_name = format["weaponHolder_%1", _count];
	_holder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, ""];
	_holder setVehicleVarName _name;
	[_holder, _prefix, false, _name] call aso_fnc_loadCargo;
	[_holder, true, _prefix, _name] call aso_fnc_loadPosition;
	_count = _count + 1;
};