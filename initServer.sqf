_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
if (_load == 1) then
{
	[[], false] call aso_fnc_executeLoadVehicle;
	[[TestAI], true, true] call aso_fnc_executeLoadMan;
	[] call aso_fnc_executeLoadDropped;
	[] call aso_fnc_executeLoadMarkers;
};

