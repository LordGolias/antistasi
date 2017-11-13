["Rifleman"] call AS_fnc_recruitFIAunit;
["Rifleman"] call AS_fnc_recruitFIAunit;

if not hayACE then {
    [] spawn {
        sleep 1;
        private _unit = (units group player) select 1;
        [_unit, "", 0.98, _unit] call handleDamage;
        _unit setDammage 0.98;
        [_unit, "", 0.98, _unit] call handleDamage;
        _unit setDammage 0.98;
        sleep 1;
        diag_log format ["[AS] Test other_unconscious: %1", !(_unit call AS_medical_fnc_isUnconscious)];
        sleep 20;
        diag_log format ["[AS] Test other_conscious: %1", _unit call AS_medical_fnc_isUnconscious];
    };

    [] spawn {
        sleep 1;
        private _unit = player;
        [_unit, "", 0.98, _unit] call handleDamage;
        _unit setDammage 0.98;
        [_unit, "", 0.98, _unit] call handleDamage;
        _unit setDammage 0.98;
        sleep 1;
        diag_log format ["[AS] Test self_unconscious: %1", !(_unit call AS_medical_fnc_isUnconscious)];
        sleep 20;
        diag_log format ["[AS] Test self_conscious: %1", _unit call AS_medical_fnc_isUnconscious];
    };
} else {
    private _damageBody = (_unit getHitPointDamage "HitBody") + 10;
	[_unit, _damageBody, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
};
