/* ----------------------------------------------------------------------------
Description:
    Gets reinforcements from the nearest possible AOI

Parameters:
	_AOI			- The AOI that need reinforcements	
    _type			- The desired unit type can be one of the following values:
					  "INFANTRY", "MOBILE", "MECHANIZED", "ARMORED", "ARTILLERY", "AIR"
	_count			- How many groups are needed
	_task			- what is their task
	_maxDistance	- from how far away can we call reinforcements

Returns:
    None

Examples:
    [_AOI, "MECHANIZED", 1, "ATTACK", 1500] call aso_fnc_callReinforcements

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
params ["_AOI", "_type", "_count", "_task", "_maxDistance"];

["Trying to find reinforcements for", _AOI] call aso_fnc_debug;
// Get all AOIs
_aoiArray = ASO_AOIs select 1; // all keys from the hash the old fashioned way. Getting non-string keys is currently broken, thanks CBA
_aoiArray = [_aoiArray] call CBA_fnc_shuffle; // Shuffle randomly to keep things spicey. It might be a good idea to sort by distance later on
_reinforcements = []; // Found reinforcements are stored here

// Look for a AOI that is not too far away and try to get as much of the desired reinforcements as possible
// if there is not at least one reinforcement go to the next AOI
{
	_distance = _AOI distance2D _x;
	
	// Consider this AOI only if its not too far away
	if (_distance <= _maxDistance && _AOI != _x) then 
	{
		["AOI for support found", _x] call aso_fnc_debug;
		["Distance is: ", _distance] call aso_fnc_debug;
		["Distance is within max distance of", _maxDistance] call aso_fnc_debug;
		_possibleReinforcements = [_x] call aso_fnc_getAOIGroups; // Get all Groups from that AOI
		{
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
			if (_type == _type && _orders == "GARRISON") then 
			{
				["Found reinforcment", _x] call aso_fnc_debug;
				_reinforcements pushBackUnique _x;
			};
			if (count _reinforcements >= _count) exitWith {}; // enough is enough
		} forEach _possibleReinforcements;
	};
	if (count _reinforcements >= _count) exitWith {}; // enough is enough
} forEach _aoiArray;
// Add groups to reeinforcements and order them to support their new objective
{
	[_x, _AOI, _task] spawn aso_fnc_addGroupToAOIReinforcements;
	["reinforcments send", _x] call aso_fnc_debug;	
} forEach _reinforcements;