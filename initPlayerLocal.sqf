waitUntil { !(isNil "paramsArray") };
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
if (_load == 1) then
{
	if (isNil "ASO_INIT") then
	{
		[] call aso_fnc_init_aso;
	};
	_unit = _this select 0;
	[[_unit], false, false] call aso_fnc_executeLoadMan;
	if (ASO_USE_TFR) then
	{
		[_unit, "tf_handlers_set"] spawn aso_fnc_propagateLocalVar;
	};
};

