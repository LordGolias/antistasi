params ["_unit"];
if !hasACEmedical then {
    _unit addEventHandler ["HandleDamage", AS_fnc_EH_handleDamage];
    if isPlayer _unit then {
        [_unit] spawn AS_medical_fnc_effectsLoop;
    };
} else {
    _unit addEventHandler ["HandleDamage", AS_fnc_EH_handleDamageACE];
};
// loop for AI functionality
[_unit] spawn AS_medical_fnc_medicLoop;
