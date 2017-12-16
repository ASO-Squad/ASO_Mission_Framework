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

// Look for a AOI that is not too far away and try to get as much of the desired reinforcements as possible
// if there is not at least one reinforcement go to the next AOI
{
	// Current result is saved in variable _x
	["AOI for support found", _x] call aso_fnc_debug;
	_distance = _AOI distance2D _x;
	["Distance is: ", _distance] call aso_fnc_debug;
	
} forEach _aoiArray;


//tempest distance2D as_mike;