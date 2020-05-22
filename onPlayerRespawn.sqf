params ["_newUnit",	"_oldUnit", "_respawn", "_respawnDelay"];

if (isNull _oldUnit) exitWith {[];}; // Begin of the mission, do nothing here

_whitelist = ["rhsusf_weap_m9","rhsusf_weap_m1911a1","rhsusf_weap_glock17g4","hgun_Pistol_heavy_02_F","hgun_Pistol_Signal_F","rhs_weap_tt33","rhs_weap_kar98k","rhs_weap_Izh18","sgun_HunterShotgun_01_F","sgun_HunterShotgun_01_sawedoff_F","rhs_weap_m1garand_sa43","LOP_Weap_LeeEnfield_railed","rhs_weap_M590_8RD","rhs_weap_M590_5RD","rhs_weap_m24sws","rhs_weap_m24sws_d","rhs_weap_m24sws_wd","optic_KHS_old","rhs_weap_l1a1_wood","rhsusf_acc_omega9k","ACE_muzzle_mzls_smg_02","muzzle_snds_L","rhsusf_acc_m24_silencer_black","rhsusf_acc_m24_silencer_d","rhsusf_acc_m24_silencer_wd","rhsusf_acc_m24_muzzlehider_black","rhsusf_acc_m24_muzzlehider_d","rhsusf_acc_m24_muzzlehider_wd","rhsgref_acc_falMuzzle_l1a1","rhsusf_acc_aac_scarh_silencer","rhsusf_acc_aac_762sd_silencer","rhsusf_acc_aac_762sdn6_silencer","muzzle_snds_B","muzzle_snds_B_khk_F","muzzle_snds_B_snd_F","muzzle_snds_B_arid_F","muzzle_snds_B_lush_F","ACE_muzzle_mzls_B","rhsgref_sdn6_suppressor","rhsusf_acc_harris_swivel","rhsusf_mag_15Rnd_9x19_JHP","rhsusf_mag_15Rnd_9x19_FMJ","rhsusf_mag_7x45acp_MHP","rhsusf_mag_17Rnd_9x19_JHP","rhsusf_mag_17Rnd_9x19_FMJ","6Rnd_45ACP_Cylinder","6Rnd_GreenSignal_F","6Rnd_RedSignal_F","rhs_mag_762x25_8","rhsgref_5Rnd_792x57_kar98k","rhsgref_1Rnd_00Buck","rhsgref_1Rnd_Slug","2Rnd_12Gauge_Pellets","2Rnd_12Gauge_Slug","ACE_2Rnd_12Gauge_Pellets_No0_Buck","ACE_2Rnd_12Gauge_Pellets_No1_Buck","ACE_2Rnd_12Gauge_Pellets_No2_Buck","ACE_2Rnd_12Gauge_Pellets_No3_Buck","ACE_2Rnd_12Gauge_Pellets_No4_Buck","ACE_2Rnd_12Gauge_Pellets_No4_Bird","rhsgref_8Rnd_762x63_M2B_M1rifle","rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle","rhs_mag_m1garand_ads","LOP_10rnd_77mm_mag","20Rnd_762x51_Mag","10Rnd_Mk14_762x51_Mag","rhsusf_20Rnd_762x51_m118_special_Mag","rhsusf_20Rnd_762x51_m993_Mag","rhsusf_20Rnd_762x51_m80_Mag","rhsusf_20Rnd_762x51_m62_Mag","ACE_20Rnd_762x51_Mag_Tracer","ACE_20Rnd_762x51_Mag_Tracer_Dim","ACE_20Rnd_762x51_Mag_SD","ACE_10Rnd_762x51_M118LR_Mag","ACE_10Rnd_762x51_Mk316_Mod_0_Mag","ACE_10Rnd_762x51_Mk319_Mod_0_Mag","ACE_10Rnd_762x51_M993_AP_Mag","ACE_20Rnd_762x51_M118LR_Mag","ACE_20Rnd_762x51_Mk316_Mod_0_Mag","ACE_20Rnd_762x51_Mk319_Mod_0_Mag","ACE_20Rnd_762x51_M993_AP_Mag","rhsusf_8Rnd_00Buck","rhsusf_8Rnd_doomsday_Buck","rhsusf_8Rnd_Slug","rhsusf_8Rnd_HE","rhsusf_8Rnd_FRAG","rhs_mag_fakeMuzzle1","rhsusf_5Rnd_00Buck","rhsusf_5Rnd_doomsday_Buck","rhsusf_5Rnd_Slug","rhsusf_5Rnd_HE","rhsusf_5Rnd_FRAG","rhsusf_5Rnd_762x51_m118_special_Mag","rhsusf_5Rnd_762x51_m993_Mag","rhsusf_5Rnd_762x51_m62_Mag","rhs_mag_20Rnd_762x51_m80_fnfal","rhs_mag_20Rnd_762x51_m61_fnfal","rhs_mag_20Rnd_762x51_m62_fnfal","rhs_mag_20Rnd_762x51_m80a1_fnfal","rhs_mag_30Rnd_762x51_m61_fnfal","rhs_mag_30Rnd_762x51_m62_fnfal","rhs_mag_30Rnd_762x51_m80_fnfal","rhs_mag_30Rnd_762x51_m80a1_fnfal","ACE_EarPlugs","ACE_epinephrine","ACE_Flashlight_XL50","ACE_MapTools","ACE_morphine","ACE_microDAGR","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_RangeCard","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500","ACE_splint","ToolKit","ACE_tourniquet","ItemMap","ItemCompass","ItemWatch","ACE_fieldDressing","ACE_elasticBandage","ACE_packingBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500"];

private _oldLoadout = getUnitLoadout _oldUnit;
private _primary = (_oldLoadout select 0);
private _secondary = (_oldLoadout select 1);
private _handgun = _oldLoadout select 2;
private _uniform = _oldLoadout select 3;
private _uniformType = _uniform select 0;
private _uniformItems = _uniform select 1;
private _vest = _oldLoadout select 4;
private _vestType = _vest select 0;
private _vestItems = _vest select 1;
private _backpack = _oldLoadout select 5;
private _backpackType = _backpack select 0;
private _backpackItems = _backpack select 1;
private _helmet = _oldLoadout select 6;
private _face = _oldLoadout select 7;
private _bino = _oldLoadout select 8;
private _items = _oldLoadout select 9;

//["Primary", _primary select 0, true] call aso_fnc_debug;

// Reset loadout
if (!((_primary select 0) in _whitelist)) then 
{
	_primary = []; // punish the greedy
};

_secondary = [];

// Discard most items in uniform
private _newItems = [];
{
	if (_x select 0 in _whitelist) then 
	{
		_newItems pushBack _x;
	};
	
} forEach _uniformItems;
_uniformItems = _newItems;
// Discard most items in vest
_newItems = [];
{
	if (_x select 0 in _whitelist) then 
	{
		_newItems pushBack _x;
	};
	
} forEach _vestItems;
_vestItems = _newItems;

// Discard most items in backpack
_newItems = [];
{
	if (_x select 0 in _whitelist) then 
	{
		_newItems pushBack _x;
	};
	
} forEach _backpackItems;
_backpackItems = _newItems;

// Discard fancy items
_newItems = [];
{
	if (_x in _whitelist) then 
	{
		_newItems pushBack _x;
	}
	else 
	{
		_newItems pushBack "";
	};
	
} forEach _items;
_items = _newItems;

private _newLoadout = [];
_newLoadout pushBack _primary;
_newLoadout pushBack _secondary;
_newLoadout pushBack _handgun;
_newLoadout pushBack [_uniformType, _uniformItems];
_newLoadout pushBack [_vestType, _vestItems];
_newLoadout pushBack [_backpackType, _backpackItems];
_newLoadout pushBack _helmet;
_newLoadout pushBack _face;
_newLoadout pushBack [];
_newLoadout pushBack _items;

_newUnit setUnitLoadout _newLoadout;
loadout = _newLoadout;
