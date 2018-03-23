/* ----------------------------------------------------------------------------
Description:
    Reveals a group to another group

Parameters:
    _revealed   - the revealed group
    _revealer  	- the group that is reveald to
	_strength 	- how much the revealer knows about the revealed

Returns:
    None

Example:
    [myGroup, myGroup2, 2.5] call aso_fnc_revealToGroup

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_revealed", "_revealer", "_strength"];
// Reveal all units of the group
{
	_revealer reveal [_x, _strength];
    // enable the revealer so that even inside huge AOIs all units can react to a threat
    _revealer enableDynamicSimulation false; 
} forEach units _revealed;

// Show Debug Output
["Group REVEALED", groupId _revealed] call aso_fnc_debug;
["REVEALED TO", groupId _revealer] call aso_fnc_debug;