/* ----------------------------------------------------------------------------
Description:
    Searches for the first sycronzized group, stores that information in the
    logic and deletes it. Beware: Modified Loadouts do NOT get stored.
    Spawned units will have their standard loadout.

Parameters:
    _obj            - The object the group is sychronized to
    _multiplier     - How many times should the group be spawned later?
    _task           - What shall they do? Allowed Values are: 
                    "GARRISON", "GUARD", and "PATROL". 

Returns:
    nothing

Examples:
    [this, 1] call aso_fnc_storeSynchronizedGroup;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

//if (!canSuspend) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_obj", ["_multiplier", 1], ["_task", "PATROL"]];

// Get all synchronized objects
private _sync = synchronizedObjects _obj;
private _group = "";
private _units = [];
private _vehicles = [];
private _classes = [];
private _classesV = [];
{
    scopeName "loop";
    if (_x iskindOf "AllVehicles") then
    {
        // Determine if it's empty (it's not a group)
        if (!isNull (group _x)) then 
        {
            _group = group _x;
            _units = units _group;
            breakOut "loop";
        };
    }
    
} forEach _sync;

{
    _vehicle = assignedVehicle _x;
    if (!isNull _vehicle ) then { _vehicles pushBackUnique _vehicle };    
    _classes pushBack [typeOf _x, typeOf assignedVehicle _x, assignedVehicleRole _x];
    
} forEach _units;

{
    _classesV pushBack typeOf _x;
    
} forEach _vehicles;

// Store group info
_obj setVariable ["aso_spawn", [_multiplier, _classes, _classesV , side _group, _task]];

// Delete the group
_group deleteGroupWhenEmpty true;
{
    deleteVehicle _x;
    
} forEach _units;
{
    deleteVehicle _x;
    
} forEach _vehicles;
deleteGroup _group;

