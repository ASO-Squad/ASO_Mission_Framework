/* ----------------------------------------------------------------------------
Description:
    Displays the given Mission name and world name and the currentdate

Parameters:
    _name			- Mission Title

Returns:
    nothing

Examples:
    ["Generic Combat 2020"] spawn aso_fnc_displayMissionText;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_name", briefingName]];

waitUntil { !isNil {BIS_fnc_init}; };
waitUntil { BIS_fnc_init; };

_curDate = date;
_ddMMyyyy = format ["%3.%2.%1",
_curDate select 0,
(if (_curDate select 1 < 10) then { "0" } else { "" }) + str (_curDate select 1),
(if (_curDate select 2 < 10) then { "0" } else { "" }) + str (_curDate select 2)];

_headline = parseText ( format ["<t color='#ffdf00' font='PuristaBold' size='2'>%1</t><br />", _name]);
_subline0 = parseText (format ["<t font='PuristaMedium' size='1.6'>%1, %2</t>", worldName, _ddMMyyyy]);
_title = [composeText [_headline, _subline0], [0,0,1,1], 10, 5, 1, 0] spawn BIS_fnc_textTiles;

waitUntil { scriptDone _title; };
sleep 1;
[] spawn aso_fnc_displayNamePosTime;