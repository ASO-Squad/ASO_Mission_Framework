/* ----------------------------------------------------------------------------
Description:
    Saves everything dropped on the ground and does this with INIDBI2.
	Files are written on the server machine.

Parameters:
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_prefix] call aso_fnc_executeSaveDropped;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_prefix", ASO_PREFIX]];

// Gather all containers on the ground ... this may take a while.
_container = ((allMissionObjects "GroundWeaponHolder") + (entities "WeaponHolderSimulated"));
_weaponHolders = 0;
{
	_name = format["weaponHolder_%1", _forEachIndex];
	_x setVehicleVarName _name;
	if (isServer) then
	{
		[_x, _prefix] call aso_fnc_saveCargo;
		[_x, true, _prefix] call aso_fnc_savePosition;
	}
	else
	{
		[_x, _prefix] remoteExecCall ["aso_fnc_saveCargo", 2, false]; // Call this on the server
		[_x, true, _prefix] remoteExecCall ["aso_fnc_savePosition", 2, false]; // Call this on the server
	};
	_weaponHolders = _forEachIndex;
} forEach _container;

// creating new database
_inidbi = ["new", format["%1_%2", _prefix, "WeaponHolders"]] call OO_INIDBI;
["deleteSection", "Info"] call _inidbi; // cleanup
// We must know how many weapon holders to use
["write", ["Info", "Count", _weaponHolders]] call _inidbi;