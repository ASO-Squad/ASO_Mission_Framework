if (!isServer) exitWith {};
["Saving Mission ..."] remoteExecCall ["hint", 0, false];
// Save mission state
[] call aso_fnc_executeSaveEnvironment;
// Save anything that might do some stuff
["Saving Vehicles ..."] remoteExecCall ["hint", 0, false];
[ASO_VEHICLES] call aso_fnc_executeSaveVehicle;
["Saving Players ..."] remoteExecCall ["hint", 0, false];
[[], false] call aso_fnc_executeSaveMan;
["Saving Units ..."] remoteExecCall ["hint", 0, false];
[ASO_UNITS, true] call aso_fnc_executeSaveMan;
["Saving Objectives ..."] remoteExecCall ["hint", 0, false];
[(ASO_AOIs select 1)] call aso_fnc_executeSaveAOI;
["Saving AI Orders ..."] remoteExecCall ["hint", 0, false];
[ASO_GROUPS] call aso_fnc_executeSaveOrders;
// Keep track of those crates
[ASO_CRATES] call aso_fnc_executeSaveCargo;
// Save loot and markers
["Saving Loot ..."] remoteExecCall ["hint", 0, false];
[] call aso_fnc_executeSaveDropped;
[false] call aso_fnc_executeSaveMarkers;
// Keep track of mission progress
[mission_progress, false] call aso_fnc_executeSaveVar;
// We are done now!
["Mission Saved!"] remoteExecCall ["hint", 0, false];