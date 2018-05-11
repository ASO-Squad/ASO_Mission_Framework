/* ----------------------------------------------------------------------------
Description:
    Can be used to safely call aso_fnc_executeSaveCargo from the action menu.  

Parameters:
    _objects		- The objects that we want to keep the cargos of
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_target, _caller, _id, [_params]] call aso_fnc_actionSaveCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
(_this select 3) call aso_fnc_executeSaveCargo;