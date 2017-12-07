/* ----------------------------------------------------------------------------
Description:
    Adds a group to the global garrison.
    BE ADVISED: If a unit previously belonged to an AOI, it is still considered to be part of that AOI.

Parameters:
    _group	- The group that needs to be assigned to an AOI

Returns:
    None

Examples:
    [_thisGroup] spawn aso_fnc_addGroupToGarrison

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_group"];
// Wait until bis_fnc_init is ready
waitUntil {!isnil "bis_fnc_init"};

ASO_GARRISON pushBackUnique _group;
["Group is now in garrison", _group] call aso_fnc_debug;