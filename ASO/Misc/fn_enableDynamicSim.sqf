/* ----------------------------------------------------------------------------
Description:
    Enables dynamic simulation after a specified amount of time. This usually makes the mission run more smoothly.
    But sometimes its a good ide to let the group wander around for a while to make things more random.
	Works only if ASO_DYNAMICSIM is true.

Parameters:
    _group	- Group to track
	_timer	- Wait this ammount of seconds before activating dynamic simulation

Returns:
    None

Examples:
    [_group, time] spawn aso_fnc_enableDynamicSim

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
params ["_group", "_timer"];
uiSleep _timer;
// Enable dynmic simulation if needed
if (ASO_DYNAMICSIM) then
{
    _group enableDynamicSimulation true;
}