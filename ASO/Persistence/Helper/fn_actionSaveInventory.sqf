/* ----------------------------------------------------------------------------
Description:
    Can be used to safely call aso_fnc_executeSaveInventory from the action menu.  

Parameters:
    _units			- The units that we want to keep the inventory of.
					If you leave this array empty, all players get saved.
	_saveByName		- If true, we are saving this by the units name, otherwise it is saved by the players name
	_prefix			- Prefix to be used for the database. This is usually used to identify different missions
					If you don not provide a prefix, ASO_PREFIX will be used. 

Returns:
    nothing

Example:
    [_target, _caller, _id, [_params]] call aso_fnc_actionSaveInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
(_this select 3) call aso_fnc_executeSaveInventory;