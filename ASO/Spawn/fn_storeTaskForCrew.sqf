/* ----------------------------------------------------------------------------
Description:
    Stores a task in an empty vehicle, that will be executed when the crew spawns.

Parameters:
    _obj            - The empty vehicle
    _task           - What shall they do? Allowed Values are: 
                    "GUARD" and "PATROL" 
    _radius         - radius around which to perform the task

Returns:
    nothing

Examples:
    [this, "PATROL", 100] call aso_fnc_storeTaskForCrew;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

//if (!canSuspend) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_obj", ["_task", "PATROL"], ["_radius", 50]];

_obj setVariable ["aso_vehicletask", [_task, _radius]];
true;

