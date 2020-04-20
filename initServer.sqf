waitUntil { !(isNil "paramsArray") };
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
if (_load == 1) then
{
	if (isNil "ASO_INIT") then
	{
		[] call aso_fnc_init_aso;
	};
	[] call aso_fnc_executeLoadEnvironment;
	[ASO_VEHICLES] call aso_fnc_executeLoadVehicle;
};

