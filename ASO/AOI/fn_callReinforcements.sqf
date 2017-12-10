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
    [_AOI, _type, _count, _task, _maxDistance] call aso_fnc_getReinforcements

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_AOI", "_type", "_count", "_task", "_maxDistance"];

// Get all AOIs
_aoiArray = ASO_AOIs call CBA_fnc_hashKeys;
// Look for a AOI that is not too faar away and tr to get as much of the desired reinforcements as possible
// if there is not at least one reinforcement go to the next AOI
{
	// Current result is saved in variable _x
	
} forEach _aoiArray;


//tempest distance2D as_mike;