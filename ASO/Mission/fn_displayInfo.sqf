/* ----------------------------------------------------------------------------
Description:
    Show information about current position and time to the given player

Parameters:
    _headline       - Headline will be green and big
    _line0			- next line
    _line1		    - next line

Returns:
    nothing

Examples:
    [_headline, _title, _location] spawn aso_fnc_displayInfo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_headline", ""], ["_line0", ""], ["_line1", ""]];

waitUntil { !isNil {BIS_fnc_init}; };
waitUntil { BIS_fnc_init; };

_headline = parseText ( format ["<t color='#a1f542' font='PuristaBold' size='1.2'>%1</t><br />",_headline]);
_line0 = parseText (format ["<t font='PuristaMedium' size='1'>%1</t><br />", _line0]);
_line1 = parseText (format ["<t font='PuristaMedium' size='1'>%1</t>", _line1]);

[composeText [_headline, _line0, _line1], true, 10, 5, 2, 0] spawn BIS_fnc_textTiles;
playsound "FD_Finish_F";