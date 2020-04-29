waitUntil { !(isNil "paramsArray") };
_load = ["LoadMission", 1] call BIS_fnc_getParamValue;
_armory = ["LoadArmory", 1] call BIS_fnc_getParamValue;
_unit = _this select 0; // player who called this script

if (_load == 1) then
{
	if (isNil "ASO_INIT") then
	{
		[] call aso_fnc_init_aso;
	};
	[[_unit], false, false] call aso_fnc_executeLoadMan;
	if (ASO_USE_TFR) then
	{
		
		[_unit, "tfar_handlersset"] remoteExec ["aso_fnc_propagateLocalVar", _unit];
	};
};
if (_armory == 1) then
{
	if (isNil "ASO_INIT") then
	{
		[] call aso_fnc_init_aso;
	};
	[[_unit], false, "aso_arm"] call aso_fnc_executeLoadInventory;
	if (ASO_USE_TFR) then
	{
		[_unit, "tfar_handlersset"] remoteExec ["aso_fnc_propagateLocalVar", _unit];
	};
};
