params ["_unit"];
if not hasACEmedical then {
    _unit addEventHandler ["HandleDamage", AS_fnc_EH_handleDamage];
} else {
    _unit addEventHandler ["HandleDamage", AS_fnc_EH_handleDamageACE];
};
// loop for AI functionality
[_unit] spawn AS_medical_fnc_medicLoop;

// loop for player effects
if isPlayer _unit then {
    [_unit] spawn AS_medical_fnc_effectsLoop;
};
