/* ----------------------------------------------------------------------------
Description:
    Lets a unit refuel, but only if another one is still alive

Parameters:
    _group
    _refueler

Returns:
    None

Example:
    [vehicle, anotherObject, _ammount] call aso_fnc_conditionalRefuel;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_vehicle", "_refueler", "_ammount"];

if (damage _refueler < 1) then 
{
    _vehicle setFuel _ammount;
};
true;