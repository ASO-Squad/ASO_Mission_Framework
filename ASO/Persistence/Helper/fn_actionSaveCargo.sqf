/* ----------------------------------------------------------------------------
Description:
    Can be used to safely call aso_fnc_executeSaveCargo from the action menu.  

Parameters:
    _objects		- The objects that we want to keep the cargos of

Returns:
    nothing

Example:
    [_target, _caller, _id, [_params]] call aso_fnc_actionSaveCargo;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
(_this select 3) call aso_fnc_executeSaveCargo;