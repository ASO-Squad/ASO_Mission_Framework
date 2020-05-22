/* ----------------------------------------------------------------------------
Description:
    Do not move the group members, this is useful if you hand-place them in certain spots, eg. Buildings.

Parameters:
    _radar			- Group to track

Returns:
    None

Examples:
    [_radar] spawn aso_fnc_animateRadar;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (!canSuspend) exitWith {false;};

params ["_radar"];

_radar setVariable ["ASO_Spin", true, true];

while {(_radar getVariable ["ASO_Spin", true])} do 
{
	_radar animateSource ["Radar_Rotation", 4, 1];
	waitUntil { (_radar animationSourcePhase "Radar_Rotation") == 4 };
	_radar animateSource ["Radar_Rotation", 0, true];
};
_radar animateSource ["Radar_Rotation", 6, 1];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 0.2 };
_radar animateSource ["Radar_Rotation", 6, 0.90];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 0.4 };
_radar animateSource ["Radar_Rotation", 6, 0.70];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 0.6 };
_radar animateSource ["Radar_Rotation", 6, 0.50];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 1.0 };
_radar animateSource ["Radar_Rotation", 6, 0.40];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 2.0 };
_radar animateSource ["Radar_Rotation", 6, 0.30];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 3.0 };
_radar animateSource ["Radar_Rotation", 6, 0.20];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 4.0 };
_radar animateSource ["Radar_Rotation", 6, 0.10];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 5.0 };
_radar animateSource ["Radar_Rotation", 6, 0.06];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 5.5 };
_radar animateSource ["Radar_Rotation", 6, 0.03];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 5.7 };
_radar animateSource ["Radar_Rotation", 6, 0.02];
waitUntil { (_radar animationSourcePhase "Radar_Rotation") >= 6.0 };
_radar animateSource ["Radar_Rotation", 0, true];
true;




