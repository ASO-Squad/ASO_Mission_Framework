/*
	Author: Karel Moricky, Papa Mike

	Description:
	Let group members land at the waypoint position

	Parameters:
		0: GROUP
		1: ARRAY - waypoint position

	Returns:
	BOOL
*/

private ["_group","_pos", "_wp"];
_group = _this param [0,grpnull,[grpnull]];
_pos = _this param [1,[],[[]],3];
_wp = [_group,currentwaypoint _group];
_wp setwaypointdescription localize "STR_A3_CfgWaypoints_Land";

private ["_vehsMove","_vehsLand"];
_vehsMove = [];
_vehsLand = [];

waituntil {
	private ["_countReady","_vehsGroup"];
	_countReady = 0;
	_vehsGroup = [];

	//--- Check state of group members
	{
		private ["_veh"];
		_veh = vehicle _x;
		if (_x == effectivecommander _x) then {
			if (!(_veh in _vehsMove)) then {

				//--- Move to landing position
				_veh domove _pos;
				_vehsMove set [count _vehsMove,_veh];
			} else {
				if !(istouchingground _veh) then {
					if (unitready _veh && !(_veh in _vehsLand)) then {

						//--- van 't Land
						_veh land "land";
						_vehsLand set [count _vehsLand,_veh];
					};
				} else {
					//--- Ready (shut down engines)
					_veh engineon false;
					_countReady = _countReady + 1;
				};
			};
			_vehsGroup set [count _vehsGroup,_veh];
		};
	} foreach units _group;

	//--- Remove vehicles which are no longer in the group
	_vehsMove = _vehsMove - (_vehsMove - _vehsGroup);
	_vehsLand = _vehsLand - (_vehsLand - _vehsGroup);

	sleep 1;
	count _vehsGroup == _countReady
};
true