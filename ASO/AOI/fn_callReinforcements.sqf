/* ----------------------------------------------------------------------------
Description:
    Gets reinforcements from the nearest possible AOI

Parameters:
	_AOI			- The AOI that needs reinforcements	
    _types			- This is supposed to be an array of the format: [[Type, Count]]
					  The desired unit type can be one of the following values:
					  "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"
	_task			- what is their task
	_maxDistance	- from how far away can we call reinforcements

Returns:
    None

Examples:
    [_AOI, [["MECHANIZED", 2], ["INFANTRY", 1]], "ATTACK", 1500] call aso_fnc_callReinforcements

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
params ["_AOI", "_types", "_task", "_maxDistance"];

// Make sure we respect previous state
waitUntil {!(isNil "paramsArray")};
_load = ["LoadMission", 0] call BIS_fnc_getParamValue;
// Do not call for reinforcements in the first few minutes after a mission has been loaded
if (_load == 1 && time < 0) exitWith {hint "too early: wait for cooldown";}; // 180 = 3 Minutes

["Trying to find reinforcements for", _AOI] call aso_fnc_debug;
// Get all AOIs
_aoiArray = ASO_AOIs select 1; // all keys from the hash the old fashioned way. Getting non-string keys is currently broken, thanks CBA
_aoiArray = [_aoiArray] call CBA_fnc_shuffle; // Shuffle randomly to keep things spicey. It might be a good idea to sort by distance later on
// remove the AOI we are calling support for
_aoiArray = _aoiArray - [_AOI];
_allReinforcements = []; // Found reinforcements are stored here

{
	scopeName "TypeLoop";
	_desiredType = _x select 0;
	_count = _x select 1;
	_reinforcements = [];
	{
		scopeName "AOILoop";
		_distance = _AOI distance2D _x;
		
		// Consider this AOI only if its not too far away
		if (_distance <= _maxDistance && _AOI != _x) then 
		{
			["AOI for support found", _x] call aso_fnc_debug;
			_possibleReinforcements = [_x] call aso_fnc_getAOIGroups; // Get all Groups from that AOI
			{
				["Candidate:", _x] call aso_fnc_debug;
				// get unit type and orders
				_type = [_x] call aso_fnc_getGroupType;
				_orders = [_x] call aso_fnc_getGroupOrders;
				if (count _orders == 2) then 
				{
					_orders = _orders select 0; // extract orders only
				} 
				else 
				{
					_orders = "UNKNOWN"; // this Unit has no orders	
				};
				// Use this group only if it has the right type and is a garrison unit
				if (_type == _desiredType && _orders == "GARRISON") then 
				{
					["Found reinforcment", _x] call aso_fnc_debug;
					_reinforcements pushBackUnique _x;	
				};
				if (count _reinforcements >= _count) then {breakOut "AOILoop"};
			} forEach _possibleReinforcements;
		}
		else
		{
			["Too far away", _x] call aso_fnc_debug;
			["Distance is", _distance] call aso_fnc_debug;
		};
	} forEach _aoiArray;
	_allReinforcements append _reinforcements; // Add found reinforcements to the pool
} forEach _types;
// We collected every unit we need (out of the ones available) and now we can send them into battle
{
	[_x, _AOI, _task] spawn aso_fnc_addGroupToAOIReinforcements;
	["reinforcments send", _x] call aso_fnc_debug;	
} forEach _allReinforcements;