/* ----------------------------------------------------------------------------
Description:
    Track a group on the map with a marker, so you can see what it is doing

Parameters:
    _group	- Group to track

Returns:
    None

Examples:
    [_group] call aso_fnc_trackGroup

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};
if (ASO_DEBUG) then
{
	params ["_group"];
	_name = format["track_%1", (groupId _group)];
	_pos = getPos leader _group;
	_debugMarker = createMarker [_name, _pos];
	_debugMarker setMarkerShape "ICON";
	_debugMarker setMarkerType "o_unknown";
	_name setMarkerText _name;

	while {!(isNULL _group)} do
	{
		_debugMarker setMarkerPos (getPos leader _group);
		uiSleep 10;
	};
};