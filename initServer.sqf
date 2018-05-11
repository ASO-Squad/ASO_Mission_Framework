_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
if (_load == 1) then
{
	[[TestAI], true, "framework", true] call aso_fnc_executeLoadMan;
	["framework"] call aso_fnc_executeLoadDropped;
	["framework"] call aso_fnc_executeLoadMarkers;
};

