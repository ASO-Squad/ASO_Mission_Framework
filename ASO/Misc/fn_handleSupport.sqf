/* ----------------------------------------------------------------------------
Description:
    Enables, or disables UAV Control and Support dpending on the units inventory
    Note: This muss be called again after a respawn!

Parameters:
    _obj			- The object that we want to track.
    _items          - Array of items that enables support
    _requester      - An Array of requesters Modules
    _provider       - An Array of provider modules
    _uav            - List of uavs the player is allowed to control
    _frq            - long range frequence that needs to be set to enable support

Returns:
    nothing

Examples:
    [this, [], [], [], [uav], -1] spawn aso_fnc_handleSupport;

Author:
    Papa Mike
---------------------------------------------------------------------------- */
params ["_obj", ["_items", []], "_requester", "_provider", ["_uav", []], ["_frq", ""]];

if (isNil "ASO_INIT") then
{
	[] call aso_fnc_init_aso;
};

_obj setVariable ["aso_observer", true, true];
_obj setVehicleReportRemoteTargets true;

// Disable all UAV Support by default
{
    _obj disableUAVConnectability [_x, true];
    
} forEach allUnitsUAV;

while {alive _obj} do 
{
    private _allowSupport = false;
    private _itemFound = false;
    private _frequency = false;
    if (count _items > 0) then
    {
        _itemFound = [_obj, _items] call aso_fnc_checkForItem;
    }
    else 
    {
        _itemFound = true;
    };
    if (ASO_USE_TFR && _frq != "") then 
    {
        _tfr = player getVariable ["tfar_handlersset", false];
		while {!_tfr} do 
		{
			sleep 1;
			_tfr = player getVariable ["tfar_handlersset", false];
		};
        if (([player] call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency == _frq) then 
        {
            _frequency = true;
        }
        else 
        {
            _frequency = false;
        };
    } 
    else 
    {
        _frequency = true;        
    };
    if (_itemFound && _frequency) then 
    {
        _allowSupport = true;    
    };
    if (_allowSupport) then 
    {
        // Enable the right UAVs
        {
            _obj enableUAVConnectability [_x, true];
        } forEach _uav;
        // Adding Support Provider
        _islinked = synchronizedObjects _requester;
        if (!(_provider in _islinked)) then
        {
            [_obj, _requester, _provider] call BIS_fnc_addSupportLink; 
        };       
    }
    else 
    {
        // Disable the UAVs
        {
            _obj disableUAVConnectability [_x, true];
            _obj connectTerminalToUAV objNull;
            
        } forEach allUnitsUAV;
        // Adding Support Provider
        [_requester, _provider] call BIS_fnc_removeSupportLink;
    };
    sleep 5;
};