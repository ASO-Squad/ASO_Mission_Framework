/* ----------------------------------------------------------------------------
Description:
    Used to load the progress of a standard framework mission.
	Call this if you want it to be fast. Spawn it if you want to run it smoothly.
    Beware: Players are not loaded here, do that in initPlayerLocal.sqf

Parameters:
    none

Returns:
    nothing

Example:
    [] call aso_fnc_loadState;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {false;};

[] call aso_fnc_executeLoadEnvironment;

[] call aso_fnc_executeLoadMarkers;

[] call aso_fnc_executeLoadDropped;

[ASO_VEHICLES] call aso_fnc_executeLoadVehicle;

//[ASO_CRATES] call aso_fnc_executeLoadCargo;
[ASO_CRATES] call aso_fnc_executeLoadObject;

[ASO_OBJECTS] call aso_fnc_executeLoadObject;

{
    [_x] call aso_fnc_executeLoadGroup;
    
} forEach ASO_GROUPS;

[] call aso_fnc_executeLoadDead;

["Loading Complete!"] remoteExecCall ["hint", 0, false];
true;