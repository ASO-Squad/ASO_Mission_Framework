/* ----------------------------------------------------------------------------
Description:
    Saves an inventory array and attaches it to the given object/man
    This is primarily used for a workaround for the failing getUnitLoadout
    command. Use it carefully!

Parameters:
    _obj        - The object taht we want the inventory toe be saved to
    _inventory  - A complete inventory array, most likly coming from a client   

Returns:
    nothing

Example:
    [this, array] call aso_fnc_saveInventory;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
if (!isServer) exitWith {false;};

params ["_obj", "_inventory"];


_return;