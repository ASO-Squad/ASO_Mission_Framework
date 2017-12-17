/* ----------------------------------------------------------------------------
Description:
    Returns the defined type of a group

Parameters:
    _group  - The group that we want to know stuff about

Returns:
    should be an array with one of the following strings: "ATTACK", "GARRISON", "GUARD", "PATROL", "SEARCH"
    and the AOI for that order. eg.: ["ATTACK", tempest]

Example:
    [myGroup] call aso_fnc_getGroupOrders

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group"];

_group getVariable ["ASO_ORDERS", []];