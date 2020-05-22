/* ----------------------------------------------------------------------------
Description:
    Check if a unit has a specific item in its inventory

Parameters:
    _obj			- The object (usually a player) that we want to check for a specific item
	_evidence		- list of classnames of the Item that we want to check for
                    Usual Values for "evidence" are:
                    "DocumentsSecret" for "Item_SecretDocument" 
                    "Files" for "Item_Files"
                    "FilesSecret" for "Item_SecretFiles"
                    "FileTopSecret" for "Item_FileTopSecret"

Returns:
    None

Examples:
    [_obj, [_evidence]] call aso_fnc_checkForItem;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_obj", "_evidence"];
private _hasItem = false;

{
    scopeName "loop";
    if ([_obj, _x, false] call BIS_fnc_hasItem) then 
    {
        _hasItem = true;
        breakOut "loop"
    };
    
} forEach _evidence;
_hasItem;