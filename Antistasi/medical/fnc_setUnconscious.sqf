params ["_unit", "_unconscious"];
if not hasACEMedical then {
    _unit setUnconscious _unconscious;
    if _unconscious then {
        _unit switchMove "";
        _unit playActionNow "Unconscious";
        _unit disableAI "ALL";
    } else {
        _unit playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
        _unit enableAI "ALL";
    };
    _unit setVariable ["AS_medical_isUnconscious", _unconscious, true];
} else {
    [_unit, _unconscious, 10, true] call ACE_medical_fnc_setUnconscious;
};
