/* ----------------------------------------------------------------------------
Description:
    Counts the murder (killed civilians) by each side to ASO_MURDER. 
    The kill counts are written to that object as variables.
    
    ASO_Murders_Opfor
    ASO_Murders_Blufor
    ASO_Murders_Independent
    ASO_Murders_Other 

Parameters:
    none

Returns:
    None

Examples:
    [] call aso_fnc_countMurder;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

if (isNull ASO_MURDER) exitWith {false;};

params ["_space"];

// Create initial values
private _opfor = 0;
private _blufor = 0;
private _independent = 0;
private _other = 0;

addMissionEventHandler ["EntityKilled",
{
	params ["_killed", "_killer", "_instigator"];
    if (isNull _killed) exitWith {false;};
    
    if (isNull _instigator) then 
    {
        _instigator = _killed getVariable ["ace_medical_lastDamageSource", _killer];
    };
    if (_killed isKindOf "Man" && 
    (faction _killed isEqualTo "CIV_F" || 
    faction _killed isEqualTo "LOP_AFR_Civ" || 
    faction _killed isEqualTo "LOP_CHR_Civ" || 
    faction _killed isEqualTo "LOP_TAK_Civ" || 
    faction _killed isEqualTo "CIV_IDAP_F")) then
    {
        switch (side _instigator) do 
        {
            case opfor: { _opfor = (ASO_MURDER getVariable ["ASO_Murders_Opfor", 0]); _opfor = _opfor + 1; ASO_MURDER setVariable ["ASO_Murders_Opfor", _opfor, true]; };
            case blufor: { _blufor = (ASO_MURDER getVariable ["ASO_Murders_Blufor", 0]); _blufor = _blufor + 1; ASO_MURDER setVariable ["ASO_Murders_Blufor", _blufor, true]; };
            case independent: { _independent = (ASO_MURDER getVariable ["ASO_Murders_Independent", 0]); _independent = _independent + 1; ASO_MURDER setVariable ["ASO_Murders_Independent", _independent, true]; };
            default { _other = (ASO_MURDER getVariable ["ASO_Murders_Other", 0]); _other = _other + 1; ASO_MURDER setVariable ["ASO_Murders_Other", _other, true]; };
        };
    };
}];




