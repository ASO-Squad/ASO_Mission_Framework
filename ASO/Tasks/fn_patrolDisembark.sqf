/* ----------------------------------------------------------------------------
Description:
    Let a unit leave its vehicle behind and do other waypoints

Parameters:
    _group

Returns:
    None

Example:
    [this] call aso_fnc_patrolDisembark;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_group"];

private _leader = leader _group;
private _vehicle = assignedVehicle _leader;

if (isNull _vehicle) exitWith {false;};

_group setVariable ["ASO_assignedVehicle", _vehicle];

_group leaveVehicle _vehicle;
units _group allowGetIn false;
true;