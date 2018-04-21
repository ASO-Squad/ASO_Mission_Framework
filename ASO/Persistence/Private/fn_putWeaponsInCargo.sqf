/* ----------------------------------------------------------------------------
Description:
    Puts Weapons in a cargo container

Parameters:
    _obj		- Cargo Container
	_weapons	- Weapons with attached items

Returns:
    nothing

Example:
    [_obj, _weapons] call aso_fnc_putWeaponsInCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_obj", "_weapons"];
// I have to add the base weapon and their attachments seperatly this is currently an engine limitation
if (typeName _weapons == "ARRAY") then
{
	{
		_weapon = (_x select 0);
		_supressor = (_x select 1);
		_laser = (_x select 2);
		_optic = (_x select 3);
		_bipod = (_x select ((count _x)-1)); // We may have more than one magazine so the last spot may not be 5

		_obj addWeaponCargoGlobal [_weapon, 1];
		_obj addItemCargoGlobal [_supressor, 1];
		_obj addItemCargoGlobal [_laser, 1];
		_obj addItemCargoGlobal [_optic, 1];
		_obj addItemCargoGlobal [_bipod, 1];
		// Adding magazines loaded to the weapon
		{
			if ((typeName _x) == "ARRAY") then
			{
				if ((count _x) == 2) then
				{
					_class = (_x select 0);
					_ammo = (_x select 1);
					_obj addMagazineAmmoCargo [_class, 1, _ammo];
				};			
			};

		} forEach _x;

	} forEach _weapons;
};
