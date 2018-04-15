/* ----------------------------------------------------------------------------
Description:
    Sets all groups currently assigned to an AOI 

Parameters:
    _thisGroupList  - The new groups
    _AOIObject      - The AOI I want the groups to be set for

Returns:
    None

Examples:
    [[_newGroups], _thisAOI] call aso_fnc_setAOIGroups

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_thisGroupList", "_AOIObject"];

// Get AOI from global hash
_thisAOI = [ASO_AOIs, _AOIObject] call CBA_fnc_hashGet;
// Check if there is an AOI, quit quietly if there is not
if ((count _thisAOI) == 0) exitWith {[]};

// index #3 is the groups for an AOI
_thisAOI set [3, _thisGroupList];

// push this AOI back to the global array
[ASO_AOIs, _AOIObject, _thisAOI] call CBA_fnc_hashSet;