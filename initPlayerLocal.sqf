waitUntil { !(isNil "paramsArray") };
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
_armory = ["LoadArmory", 1] call BIS_fnc_getParamValue;
if (_load == 1) then
{
	if (isNil "ASO_INIT") then
	{
		[] call aso_fnc_init_aso;
	};
	_unit = _this select 0;
	//[[_unit], false, ASO_PREFIX] call aso_fnc_executeLoadMan;
	if (ASO_USE_TFR) then
	{
		[_unit, "tfar_handlersset"] spawn aso_fnc_propagateLocalVar;
	};
};
if (_armory == 1) then
{
	if (isNil "ASO_INIT") then
	{
		[] call aso_fnc_init_aso;
	};
	_unit = _this select 0;
	[[_unit], false, "aso_arm"] call aso_fnc_executeLoadInventory;
	if (ASO_USE_TFR) then
	{
		[_unit, "tfar_handlersset"] spawn aso_fnc_propagateLocalVar;
	};
};
