/* ----------------------------------------------------------------------------
Description:
    Alert all Sub-AOIs and call in their garrison units

Parameters:
	_AOI			- The AOI that needs reinforcements	
	_noSupport 		- Do not send reinforcements

Returns:
    None

Examples:
    [_AOI, false] call aso_fnc_alertSubs

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
params ["_AOI", ["_noSupport", false]];

// Make sure we respect previous state
waitUntil {!(isNil "paramsArray")};
_load = ["LoadMission", 0] call BIS_fnc_getParamValue;

// Do not call for reinforcements in the first few minutes after a mission has been loaded
if (_load == 1 && time < 0) exitWith {hint "too early: wait for cooldown";}; // 180 = 3 Minutes

["Trying to find subs for", _AOI] call aso_fnc_debug;
// Get all AOIs
_aoiArray = ASO_AOIs select 2;
// Get only the subs 
_subs = [];
{
	if ((_x select 0) != (_x select 5) && (_x select 5) == _AOI) then
	{
		_subs pushBack _x;
	};
	
} forEach _aoiArray;
// get groups for each aoi and make them ready for combat
{
	["Getting Groups from", _x select 0] call aso_fnc_debug;
	_groups = [_x select 0] call aso_fnc_getAOIGroups;
	{
		_orders = [_x] call aso_fnc_getGroupOrders;
		if (count _orders == 2) then 
		{
			_orders = _orders select 0; // extract orders only
		} 
		else 
		{
			_orders = "UNKNOWN"; // this Unit has no orders	
		};
		["Evaluating group", _x] call aso_fnc_debug;
		// Use this group only if it has the right type and is a garrison unit
		if (_orders == "GARRISON") then 
		{
			[_x, _AOI, "ATTACK"] spawn aso_fnc_addGroupToAOIReinforcements;
			["reinforcments sent", _x] call aso_fnc_debug;	
		}
		else
		{
			_x setBehaviour "AWARE";
			["Unit is cautious now", _x] call aso_fnc_debug;
		};
		
	} forEach _groups;
	
} forEach _subs;