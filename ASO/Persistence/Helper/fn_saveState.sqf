/* ----------------------------------------------------------------------------
Description:
    Used to save the progress of a standard framework mission.
	Call this if you want it to be fast. Spawn it if you want to run it smoothly.

Parameters:
    _endMission  - If true, the the mission ends ...

Returns:
    nothing

Example:
    [true] call aso_fnc_saveState;

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {false;};

params ["_endMission"];

// Save mission state
["Saving Mission ..."] remoteExecCall ["hint", 0, false];
[] call aso_fnc_executeSaveEnvironment;

// Save vehicles
["Saving Vehicles ..."] remoteExecCall ["hint", 0, false];
[ASO_VEHICLES] call aso_fnc_executeSaveVehicle;

// Save all active players
["Saving Players ..."] remoteExecCall ["hint", 0, false];
[[], false] call aso_fnc_executeSaveMan;

// Save all persitent AI Groups
["Saving Groups ..."] remoteExecCall ["hint", 0, false];
{
    [_x] call aso_fnc_executeSaveGroup;
    
} forEach ASO_GROUPS;

// Keep track of those crates
["Saving Crates ..."] remoteExecCall ["hint", 0, false];
//[ASO_CRATES] call aso_fnc_executeSaveCargo;
[ASO_CRATES] call aso_fnc_executeSaveObject;

// Save all mission critical object
["Saving Objects ..."] remoteExecCall ["hint", 0, false];
[ASO_OBJECTS] call aso_fnc_executeSaveObject;

// Save loot and markers
["Saving Loot and Markers ..."] remoteExecCall ["hint", 0, false];
[] call aso_fnc_executeSaveDropped;
[false] call aso_fnc_executeSaveMarkers;

// We are done now!
["Mission State Saved!"] remoteExecCall ["hint", 0, false];

if (_endMission) then 
{
    "ASO_Save" call BIS_fnc_endMissionServer;
};
true;