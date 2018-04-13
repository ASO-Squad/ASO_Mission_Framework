/* ----------------------------------------------------------------------------
Description:
    Returns all groups currently assigned as reinforcments to an AOI 

Parameters:
    _AOI    - The AOI I want the reinforcements from

Returns:
    [Groups]

Examples:
    [Groups] = [_thisAOI] call aso_fnc_getAOIReinforcementGroups

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_AOI"];

// Get AOI from global hash
_thisAOI = [ASO_AOIs, _AOI] call CBA_fnc_hashGet;
// Check if there is an AOI, quit quietly if there is not
if ((count _thisAOI) == 0) exitWith {[]};

// index #4 is the reinforcement groups for an AOI
(_thisAOI select 4);