/* ----------------------------------------------------------------------------
Description:
    Removes a reinforcment from its assignment and lets it return to its home 

Parameters:
    _group		- The group that moves into that AOI as reinforcments
    _trigger 	- The AOI this Group is currently reinforcing

Returns:
    None

Examples:
    [_thisGroup, _trigger] spawn aso_fnc_recallReinforcements

Author:
    Papa Mike
---------------------------------------------------------------------------- */

if (!isServer) exitWith {};
params ["_group", "_trigger"];
// Wait until bis_fnc_init is ready
waitUntil {!isnil "bis_fnc_init"};

// Retrieve home of this group 
_home = _group getVariable "ASO_HOME";

if (isNil "_home") exitWith {};

// give orders to group
[_group, _home, "MECHANIZED", false] call aso_fnc_garrison;

// remove from reinforcments list of the current AOI
[_group, _trigger] spawn aso_fnc_removeGroupFromAOIReinforcements;

["Group has been recalled", _group] call aso_fnc_debug;