/* ----------------------------------------------------------------------------
Description:
    Calls for reinforcements from a specific AOI

Parameters:
	_AOI			- The AOI that needs reinforcements	
    _task			- what is their task
	_source			- AOI that is providing the reinforcments 

Returns:
    None

Examples:
    [_AOI, "ATTACK", _source] call aso_fnc_callReinforcementsFrom

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
params ["_AOI", "_task", "_source"];

// Make sure we respect previous state
waitUntil {!(isNil "paramsArray")};
_load = ["LoadMission", 0] call BIS_fnc_getParamValue;
// Do not call for reinforcements in the first few minutes after a mission has been loaded
if (_load == 1 && time < 0) exitWith {hint "too early: wait for cooldown";}; // 180 = 3 Minutes

["Trying to find reinforcements for", _AOI] call aso_fnc_debug;

_reinforcements = []; // Found reinforcements are stored here

["AOI for support found", _source] call aso_fnc_debug;
_possibleReinforcements = [_source] call aso_fnc_getAOIGroups; // Get all Groups from that AOI
{
	["Candidate:", _x] call aso_fnc_debug;
	// get units orders
	_orders = [_x] call aso_fnc_getGroupOrders;
	if (count _orders == 2) then 
	{
		_orders = _orders select 0; // extract orders only
	} 
	else 
	{
		_orders = "UNKNOWN"; // this Unit has no orders	
	};
	// Use this group only if it is a garrison unit
	if (_orders == "GARRISON") then 
	{
		["Found reinforcment", _x] call aso_fnc_debug;
		_reinforcements pushBackUnique _x;	
	};
} forEach _possibleReinforcements;

// We collected every unit we need (out of the ones available) and now we can send them into battle
{
	[_x, _AOI, _task] spawn aso_fnc_addGroupToAOIReinforcements;
	["reinforcments send", _x] call aso_fnc_debug;	
} forEach _reinforcements;