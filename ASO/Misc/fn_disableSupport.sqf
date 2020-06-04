/* ----------------------------------------------------------------------------
Description:
    Disables UAV Control and Support except when it is a designated forward oberserver

Parameters:
    _obj			- The object that we want to track.

Returns:
    nothing

Examples:
    [this] spawn aso_fnc_disableSupport;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_obj"];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

while {true} do 
{
    private _isObserver = _obj getVariable ["aso_observer", false];
    if (!_isObserver) then 
    {
        // Disable all UAV Support by default
        {
            _obj disableUAVConnectability [_x, true];
            _obj connectTerminalToUAV objNull;
            
        } forEach allUnitsUAV;
    };
    sleep 10;
};