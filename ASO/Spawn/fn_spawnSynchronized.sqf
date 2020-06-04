/* ----------------------------------------------------------------------------
Description:
    Spawns  Groups, Vehicles or Crew on synchronized objects, designated 
    as a spawnspoint. It uses the largest sychronized trigger as the area
    of operation. And spawns there randomly. 
    Attention: Only one distinct Group or Vehicle per spawnpoint is allowed, 
    but you can spawn as many crews as you like.

Parameters:
    _taskObj    - The task module that is used to sychronize spawn points to.

Returns:
    nothing

Examples:
    [this] call aso_fnc_spawnSynchronized;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params ["_taskObj"];

// Get all synchronized objects
private _sync = synchronizedObjects _taskObj;
{
    if (_x iskindOf "AllVehicles") then
    {
        // Determine if it's empty
        if (isNull (group _x)) then 
        {
            if (locked _x == 2) then 
            {
                _x lock 3; // Make sure AI can get in/out
            };
            // Create crew
            private _group = createVehicleCrew _x;
            _group addVehicle _x;
            _task = _x getVariable ["aso_vehicletask", []];
            if (count _task == 2) then 
            {
                // restore task and do stuff
                switch (toUpper (_task select 0)) do 
                {
                    case "PATROL": { [_group, -1, _task select 1] spawn aso_fnc_patrol; };
                    case "GUARD": { [_group, true, -1, _task select 1] spawn aso_fnc_guard; };
                    default { [_group, -1, _task select 1] spawn aso_fnc_patrol; };
                };  
            };
        };
    }
    else // at this point I assume this thing has some info on about what to spawn
    {
        // determine area of operation
        private _triggers = synchronizedObjects _x;
        private _trigger = "";
        private _area = [];
        private _position = [];
        private _size = 0;
        {
            if (_x iskindOf "EmptyDetector") then 
            {
                _a = triggerArea _x;
                _s = (_a select 0) * (_a select 1);
                if (_s > _size) then 
                {
                    _size = _s;
                    _trigger = _x;
                };
            };
        } forEach _triggers;
        // There is no trigger or it's too small
        if (_size == 0) exitWith {false;};
        
        _position = getPos _trigger;
        _area = triggerArea _trigger;

        _info = _x getVariable ["aso_spawn", [0, [], [], civilian, "NONE"]];
        _multiplier = _info select 0;
        _classes = _info select 1;
        _classesV = _info select 2;
        _side = _info select 3;
        _task = _info select 4;
        for [{_i = 0}, {_i < _multiplier}, {_i = _i+1}] do 
        {
            _position = [getPos _trigger, triggerArea _trigger] call BIS_fnc_randomPosTrigger;
            // create group
            _group = createGroup [_side, false];
            // create vehicles
            _vehicles = [];
            {
                _new = createVehicle [_x, _position, [], 0, "NONE"];
                // assign them to the group
                _group addVehicle _new;
                _vehicles pushBack _new;
                
            } forEach _classesV;     
            // create units
            {
                _unit = _x select 0;
                _vehicle = _x select 1;
                _role = _x select 2;
                _new = _group createUnit [_unit, _position, [], 10, "FORM"];
                if (_vehicle != "") then 
                {
                    {
                        // Check for the right type of vehicle
                        if (typeOf _x == _vehicle) then 
                        {
                            _roleType = _role select 0;
                            _turret = [];
                            if (count _role > 1) then
                            {
                                _turret = _role select 1;
                            };
                            // assign them to the right vehicle if unique position (driver, gunner, commander, turret) is not already set
                            switch (_roleType) do 
                            {
                                case "driver": { if (isNull assignedDriver _x) then { _new assignAsDriver _x; _new moveInDriver _x; }  };
                                case "gunner": { if (isNull assignedGunner _x) then { _new assignAsGunner _x; _new moveInGunner _x; } };
                                case "commander": { if (isNull assignedCommander _x) then { _new assignAsCommander _x; _new moveInCommander _x; } };
                                case "cargo": { if (_x emptyPositions "cargo" > 0) then { _new assignAsCargo _x; _new moveInCargo _x; } }; // This is not ideal, because the first vehicle gets all the cargo units ...
                                case "Turret": { if (isNull (_x turretUnit _turret)) then { _new assignAsTurret [_x, _turret]; _new moveInTurret [_x, _turret]; } };
                                default {["Default", _role, true] call aso_fnc_debug; };
                            };
                        };
                    } forEach _vehicles;
                };
            } forEach _classes;
            // Apply task
            switch (toUpper _task) do
            {
                case "GARRISON": { [_group, true, -1, 0, _trigger] spawn aso_fnc_garrison; };
                case "GARRISONQUICK": { [_group, true, -1, 0, _trigger] spawn aso_fnc_garrisonQuick; };
                case "QUICK": { [_group, true, -1, 0, _trigger] spawn aso_fnc_garrisonQuick; };
                case "GUARD": { [_group, false, -1, 0, _trigger] spawn aso_fnc_guard; };
                case "PATROL": { [_group, -1, 0, _trigger] spawn aso_fnc_patrol; };
                default { };
            };
        };
    }
} forEach _sync;
true;