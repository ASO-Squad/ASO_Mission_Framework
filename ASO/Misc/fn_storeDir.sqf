/* ----------------------------------------------------------------------------
Description:
    Stores the initial directiin a Unit was facing when set in editor to "ASO_InitialUnitDir"
    Which is used by Task Stationary to correct the direction each unit is watching if available.

Parameters:
    _obj			- The Object that we want a direction from

Returns:
    direction

Examples:
    [this] call aso_fnc_storeDir;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {-1;};

params ["_obj"];

private _dir = getDir _obj;
_obj setVariable ["ASO_InitialUnitDir", _dir, false];
_dir;