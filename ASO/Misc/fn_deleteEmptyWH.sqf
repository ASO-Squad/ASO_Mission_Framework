/* ----------------------------------------------------------------------------
Description:
    Deletes all empty WeaponHolders every 120 seconds

Parameters:
    none

Returns:
    nothing

Example:
    [] spawn aso_fnc_deleteEmptyWH;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

while {true} do 
{
	private _allWH = (allMissionObjects "GroundWeaponHolder_Scripted");
	{
		private _count = (count (magazinesAmmoCargo _x) + count(weaponsItemsCargo _x) + count (itemCargo _x));
		["WH", _count, true] call aso_fnc_debug;
		if (_count == 0) then
		{
			deleteVehicle _x;
		};
	} forEach _allWH;
	sleep 120;
};