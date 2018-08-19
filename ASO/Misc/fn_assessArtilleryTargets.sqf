/* ----------------------------------------------------------------------------
Description:
    Returns all units from a trigger, and returns the one that has the most units around him, 
	which makes him the most valuable target for the artillery. The artillery then starts shooting. 

Parameters:
    _trigger		- the trigger that assesses the targets
	_radius			- radius around each unit to asses MVT 
	_artillery		- the artillery group that is supposed to fire
	_type			- Can be: HE, SMOKE, or ILLUM
	_rounds			- How many rounds are to be fired
	_intervall		- pause between fire missions
	_spread			- artifical inaccuracy in meters
	_modifier		- Number to multiply by to decrase spread with every fire mission
					  This can be used to simluate more accurate spotters, 
					  the longer the artillery attack lasts. Should be somethin below 1.0

Returns:
    None

Example:
    [_trigger, 25, _artillery, "HE", 5, 120, 50, 0.6] spawn aso_fnc_assessArtilleryTargets

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

params ["_trigger", "_radius", "_artillery", "_type", "_rounds", "_intervall", "_spread", "_modifier"];

// INIT
_dangerClose = false;
// Create artillery list
_artilleryVehicles = [];
{
	_artilleryVehicles pushBack vehicle _x;
} forEach (units _artillery);
// List of targets init
_targets = list _trigger;
// Max splash time
_splashTime = 0;

while {count _targets > 0} do // quit if there are no targets left
{
	// First: Find the most valuable target
	_mvt = _targets select 0;
	_highscore = 0;
	
	{
		_score = count (_x nearEntities _radius);
		if (_score > _highscore) then 
		{
			_highscore = _score;
			_mvt = _x;
		};
	} forEach _targets;
	// Write MVT to map
	if (ASO_DEBUG) then
	{
		//delete previous markers
		{
			deleteMarker _x;
			
		
		} forEach ASO_DEBUG_ARTILLERY;
		_name = format["unit_%1_%2", _mvt, time];
		_debugMarker = createMarker [_name, getPos _mvt];
		_debugMarker setMarkerShape "ICON";
		_debugMarker setMarkerType "mil_destroy";
		_name setMarkerText format["MVT with: %1", _highscore];
		ASO_DEBUG_ARTILLERY pushBack _name;
	};
	// Second: Check if friendlies are danger close
	_mvtNearestEnemy = _mvt findNearestEnemy _mvt;
	// check distance
	_distance = _mvtNearestEnemy distance2D _mvt;
	// check if this is too close
	if (_distance > (_spread + 120)) then {_dangerClose = false;} else {_dangerClose = true;};

	// Third: Engage target if possible and not too close to friendlies
	if (!_dangerClose) then
	{
		// Apply random spread to target
		_target = _mvt getPos [_spread * sqrt random 1, random 360];
		if (ASO_DEBUG) then
		{
			_name = format["artilleryTarget_%1_%2", _mvt, time];
			_debugMarker = createMarker [_name, _target];
			_debugMarker setMarkerShape "ICON";
			_debugMarker setMarkerType "mil_destroy";
			_debugMarker setMarkerColor "ColorOrange";
			//_name setMarkerText format["Target spread: %1", _spread];
			ASO_DEBUG_ARTILLERY pushBack _name;
		};
		// check for the right ammunition
		_ammoInGroup = getArtilleryAmmo _artilleryVehicles;
		_desiredAmmo = [];
		_selectedAmmo = "";
		switch (_type) do 
		{
			case "HE": { _desiredAmmo = ASO_ARTILLERY_HE };
			case "SMOKE": { _desiredAmmo = ASO_ARTILLERY_SMOKE };
			case "ILLUM": { _desiredAmmo = ASO_ARTILLERY_HE };
			default { _desiredAmmo = ASO_ARTILLERY_ILLUM };
		};
		{
			if (_x in _ammoInGroup) then 
			{
				_selectedAmmo = _x;
			};
			
		} forEach _desiredAmmo;
		// start fire mission
		["Start Firemission on", _target] call aso_fnc_debug;
		_shots = 0;
		_eta = 0;
		while {_shots <= _rounds} do
		{
			scopeName "fireMission";
			{
				if (_shots >= _rounds) then {breakOut "fireMission"}; // Stop after desired ammount of shots
				_x commandArtilleryFire [_target, _selectedAmmo, 1];
				_shots = _shots + 1;
				// ask for ETA
				_eta = vehicle _x getArtilleryETA [_target, _selectedAmmo];
				if (_eta > _splashTime) then 
				{
					_splashTime = _eta;	
				};
				sleep random 6; // make them not fire at the same time
				
			} forEach units _artillery;
		};
		["Firemission ended with", _shots] call aso_fnc_debug;
	}
	else
	{
		["Danger", "Close"] call aso_fnc_debug;
	};
	// wait on splash
	["Splash", _splashTime] call aso_fnc_debug;
	sleep _splashTime;
	// wait for it ...
	sleep random [(_intervall/2), (_intervall), (_intervall*4)];
	// Update target list
	_targets = list _trigger;
	_targets = _targets - [objNull];
	["Targets left", count _targets] call aso_fnc_debug;
	// Reducing Spread 
	if (_splashTime > 0) then
	{
		_spread = _spread * _modifier;
		["Spread is now", _spread] call aso_fnc_debug;
	};	
};
["Artillery", "Done"] call aso_fnc_debug;