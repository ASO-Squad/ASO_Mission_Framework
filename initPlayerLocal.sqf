waitUntil { !(isNil "paramsArray") };
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
if (_load == 1) then
{
	_unit = _this select 0;
	[[_unit], false, false] call aso_fnc_executeLoadMan;
	[[], false] call aso_fnc_executeLoadVehicle;
};

