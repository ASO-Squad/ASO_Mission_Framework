/* ----------------------------------------------------------------------------
Description:
    Removes all reinforcments from a AOI and lets them return to their home. 

Parameters:
    _trigger 	- The AOI that is to be abandoned

Returns:
    None

Examples:
    [_trigger] spawn aso_fnc_retreatReinforcements

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_trigger"];
// Wait until bis_fnc_init is ready
waitUntil {!isnil "bis_fnc_init"};

_reinforcements = [_trigger] call aso_fnc_getAOIReinforcementGroups;

{
    [_x, _trigger] spawn aso_fnc_recallReinforcements;

} forEach _reinforcements;