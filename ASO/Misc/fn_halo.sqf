/* ----------------------------------------------------------------------------
Description:
   Lets the player do a parachute jump. The player must have a parachute for this 
   so make sure your team is properly equiped.  

Parameters:
    _unit		- The unit we want to perform jump
	_height 	- The height of the jump
	_position 	- Leave this blank to let the player decide on where to jump
				 (does not work with AI)

Returns:
    nothing

Examples:
    [this, 10000] call aso_fnc_halo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_unit", "_height", ["_position", []]];

if (count _position == 0) then 
{
	openMap true;
	[_unit, _height] onMapSingleClick 
	{
		onMapSingleClick {}; // Remove the code after first click
		(_this select 0) setPosASL [_pos select 0, _pos select 1, (_this select 1)];
		openMap false;
	};
}
else
{
	_unit setPosASL [_position select 0, _position select 1, _height];
};