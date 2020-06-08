/* ----------------------------------------------------------------------------
Description:
    Show information about current position and time to the given player

Parameters:
    _name			- Player Name

Returns:
    nothing

Examples:
    [] spawn aso_fnc_displayNamePosTime;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

params [["_name", player]];

waitUntil { !isNil {BIS_fnc_init}; };
waitUntil { BIS_fnc_init; };

private _headline = name _name;
private _subline0 = mapGridPosition _name;
private _subline1 = ["J"] call aso_fnc_milTime;

_headline = parseText ( format ["<t color='#a1f542' font='PuristaBold' size='1.2'>%1</t><br />", name _name]);
_subline0 = parseText (format ["<t color='#a1f542' font='PuristaLight' size='1'>Grid: </t><t font='PuristaMedium' size='1'>%1</t><br />", mapGridPosition _name]);
_subline1 = parseText (format ["<t color='#a1f542' font='PuristaLight' size='1'>Time: </t><t font='PuristaMedium' size='1'>%1</t>", ["J"] call aso_fnc_milTime]);

[composeText [_headline, _subline0, _subline1], true, 10, 5, 2, 0] spawn BIS_fnc_textTiles;
playsound "FD_Finish_F";
