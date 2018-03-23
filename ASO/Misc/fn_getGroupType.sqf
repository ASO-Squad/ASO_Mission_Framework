/* ----------------------------------------------------------------------------
Description:
    Returns the defined type of a group

Parameters:
    _group  - The group that we want to know stuff about

Returns:
    one of the following results: "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"

Example:
    [myGroup] call aso_fnc_getGroupType

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group"];

_group getVariable ["ASO_TYPE", "INFANTRY"];