/* ----------------------------------------------------------------------------
Description:
    Let a unit embmark its and do other waypoints

Parameters:
    _group

Returns:
    None

Example:
    [this] spawn aso_fnc_patrolEmbark;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_group"];

_vehicle = _group getVariable ["ASO_assignedVehicle", objNull];
units _group allowGetIn true;

if (isNull _vehicle) then 
{
    {
	    scopeName "loop";
		if (_x iskindof "LandVehicle" && {crew _x isEqualTo []} && {_x distance leader _group < 50} && {locked _x != 2}) then
		{
			_this addvehicle _x;
            breakOut "loop";
		};
	
	} foreach vehicles;
}
else 
{
    _group addvehicle _vehicle;

};
if (canSuspend) then 
{
    private _embarked = false;
    private _inside = 0;
    hint "waiting ...";
    while {!_embarked} do 
    {
        if ((count units _group) == (count crew _vehicle)) then
        {
            _embarked = true;
        };
    };
    // Refreshing waypoints so that the units start moving
    private _wp = [_group] call aso_fnc_getWaypoints;
    [_group, _wp, true] spawn aso_fnc_setWaypoints;
    hint "Go!";
};
true;