params ["_newUnit",	"_oldUnit", "_respawn", "_respawnDelay"];

if (isNull _oldUnit) exitWith {[];}; // Begin of the mission, do nothing here

private _isObserver = _oldUnit getVariable ["aso_observer", false];
if (_isObserver) then 
{
	[_newUnit, [], requester, provider_1, [uav_1], "42.6"] spawn aso_fnc_handleSupport;
};