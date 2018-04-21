/* ----------------------------------------------------------------------------
Description:
    Puts Items in a cargo container

Parameters:
    _obj		- Cargo Container
	_Magazines	- Magazines ["Classname", _ammoCount]

Returns:
    nothing

Example:
    [_obj, _magazines] call aso_fnc_putMagazinesInCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_obj", "_magazines"];
if (typeName _magazines == "ARRAY") then
{
    {
        _class = (_x select 0);
        _ammo = (_x select 1);
        _obj addMagazineAmmoCargo [_class, 1, _ammo];

    } forEach _magazines;
};
