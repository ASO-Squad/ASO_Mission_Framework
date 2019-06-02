/* ----------------------------------------------------------------------------
Description:
    Sets a variable that can be used to let this group land.

Parameters:
    _group      - The group that can flyInHeight
    _landingPad - The landing pad for this group. Should be some kind of object.

Returns:
    landingpad position

Example:
    [group, landPad] call aso_fnc_setLandingPad

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_group", "_landingPad"];

_group setVariable ["ASO_LANDING", (getPos _landingPad)];
(getPos _landingPad);