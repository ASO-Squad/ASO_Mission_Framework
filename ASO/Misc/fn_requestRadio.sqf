// This should be executed on the players machine
params ["_unit"];
//waitUntil { _unit getVariable ["tf_handlers_set", false]; }; // Wait for TFAR to settle down
[] spawn TFAR_fnc_requestRadios;