/* ----------------------------------------------------------------------------
Description:
    restores the initial direction of this unit, if possible.

Parameters:
    _obj	- Group to track

Returns:
    None

Examples:
    [_obj] spawn aso_fnc_restoreDir

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};
params ["_obj"];

private _dir = _obj getVariable ["ASO_InitialUnitDir", -1];
if (_dir != -1) then 
{
    private _watchPos = (getPos _obj) getPos [50, _dir];  
    _obj commandWatch _watchPos;
};
true;