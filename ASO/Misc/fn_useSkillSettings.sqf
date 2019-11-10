/* ----------------------------------------------------------------------------
Description:
    Uses the skill settings found in init_aso

Parameters:
    _group  - The group that we want to know stuff about;
	_sf 	- optional use sf setting for this group

Returns:
    nothing

Example:
    [myGroup, false] call aso_fnc_useSkillSettings;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
params ["_group", ["_sf", false]];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};
["Skill applied to", _group] call aso_fnc_debug;
{
	if (_sf) then
	{
		_x setSkill ["aimingAccuracy", ASO_AI_SF select 0];
		_x setSkill ["aimingShake", ASO_AI_SF select 0];
		_x setSkill ["aimingSpeed", ASO_AI_SF select 1];
		_x setSkill ["spotDistance", ASO_AI_SF select 2];
		_x setSkill ["spotTime", ASO_AI_SF select 3];
		_x setSkill ["courage", ASO_AI_SF select 4];
		_x setSkill ["reloadSpeed", ASO_AI_SF select 5];
		_x setSkill ["commanding", ASO_AI_SF select 6];

	} else 
	{
		if (_x == (leader (group _x))) then 
		{
			_x setSkill ["aimingAccuracy", ASO_AI_Officer select 0];
			_x setSkill ["aimingShake", ASO_AI_Officer select 0];
			_x setSkill ["aimingSpeed", ASO_AI_Officer select 1];
			_x setSkill ["spotDistance", ASO_AI_Officer select 2];
			_x setSkill ["spotTime", ASO_AI_Officer select 3];
			_x setSkill ["courage", ASO_AI_Officer select 4];
			_x setSkill ["reloadSpeed", ASO_AI_Officer select 5];
			_x setSkill ["commanding", ASO_AI_Officer select 6];

		} else 
		{
			_x setSkill ["aimingAccuracy", ASO_AI_Soldier select 0];
			_x setSkill ["aimingShake", ASO_AI_Soldier select 0];
			_x setSkill ["aimingSpeed", ASO_AI_Soldier select 1];
			_x setSkill ["spotDistance", ASO_AI_Soldier select 2];
			_x setSkill ["spotTime", ASO_AI_Soldier select 3];
			_x setSkill ["courage", ASO_AI_Soldier select 4];
			_x setSkill ["reloadSpeed", ASO_AI_Soldier select 5];
			_x setSkill ["commanding", ASO_AI_Soldier select 6];
			
		};
	};
} forEach units _group;
