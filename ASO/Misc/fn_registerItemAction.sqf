/* ----------------------------------------------------------------------------
Description:
    Create a ACE menu entry for colleting some intel. It automaticly flags 
    the object as mission critical and puts it in ASO_OBJECTS.

Parameters:
    _obj			- the object we want to attach this action to
	_items          - an array of arrays of format ["name", "menuEntry", "title", time, "itemClass"]

Returns:
    None

Examples:
    [_obj, _items] call aso_fnc_registerItemAction;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_obj", "_items"];

private _progress = { params ["_target", "_caller", "_params"]; [_params select 0, _params select 1, _params select 2, _params select 3, _parasm select 4] call aso_fnc_showProgress; };

private _itemList = [];

{
    _itemList pushBack (_x select 4);
    
} forEach _items;

private _check = { params ["_target", "_caller", "_params"]; [_caller, _params select 5] call aso_fnc_checkForItem;};

{
    private _name = _x select 0;
    private _menu = _x select 1;
    private _title = _x select 2;
    private _time = _x select 3;
    private _item = _x select 4;
    
    _var = format ["ASO_%1", _name];
    _obj setVariable [_var, false, true];


    _action = [_name, _menu,"", _progress, _check, {}, [_title, _time, _obj, _var, false, _itemList]] call ace_interact_menu_fnc_createAction; 
    [_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;    
    
} forEach _items;

[_obj] call aso_fnc_collectObject;
true;