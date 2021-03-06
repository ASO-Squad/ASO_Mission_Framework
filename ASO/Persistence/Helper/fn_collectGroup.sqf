/* ----------------------------------------------------------------------------
Description:
    Pushes this group and its vehicles to ASO_GROUPS, ASO_UNITS and ASO_VEHICLES

Parameters:
    0   - A group.
    1   - Time after which dynamic simulation is enabled

Returns:
    nothing

Example:
    [this] call aso_fnc_collectGroup;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_group", ["_time", 0]];

// Get out, there is nothing to do
if (isNil "_group") exitWith {false;};

// Keep this group in mind for saving
ASO_GROUPS pushBackUnique _group;

{
    // use group id as the units name, just in case it dies
    [_x] call aso_fnc_setVehicleName;

    // Use this group
    ASO_UNITS pushBackUnique _x;

    if ((vehicle _x) != _x) then
    {
        // Track the vehicle, used by this unit
        ASO_VEHICLES pushBackUnique (vehicle _x);
    };

} forEach units _group;
if (_time != -1) then 
{
    [_group, _time] spawn aso_fnc_enableDynamicSim;  
};
true;