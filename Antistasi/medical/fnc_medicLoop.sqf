params ["_unit"];
private _wasUnconscious = false;
while {alive _unit} do {
    sleep 2;
    private _isUnconscious = _unit call AS_medical_fnc_isUnconscious;

    if (not _wasUnconscious and _isUnconscious) then {
        // became unconscious
        _unit setCaptive true;
        if not isPlayer _unit then {
            _unit stop true;
        };
        _wasUnconscious = true;
    };

    private _medic = (_unit call AS_medical_fnc_getAssignedMedic);
    if (not isNull _medic and {not alive _medic or _medic call AS_medical_fnc_isUnconscious}) then {
        _unit setVariable ["ace_medical_ai_assignedMedic", objNull];
        _medic setVariable ["ace_medical_ai_healQueue", []];
    };

    if (_isUnconscious and {isNull (_unit call AS_medical_fnc_getAssignedMedic)}) then {
        // Choose a medic.
        private _bestDistance = 81; // best distance of the current medic (max distance for first medic)

        private _canHeal = {
            params ["_candidate"];
            (alive _candidate) and
            {not isPlayer _candidate} and
            {not (_candidate call AS_medical_fnc_isUnconscious)} and
            {_candidate call AS_medical_fnc_canHeal} and
            {vehicle _candidate == _candidate} and
            {_candidate distance _unit < _bestDistance}
        };

        private _medic = objNull;
        {
            if (_x call _canHeal) then {
                _medic = _x;
                _bestDistance = _x distance _unit;
            };
        } forEach units group _unit;
        if not isNull _medic then {
            [_medic, _unit] call AS_medical_fnc_healUnit;
        };
    };
    if _isUnconscious then {
        if not hayACEmedical then {
            if (_unit call AS_medical_fnc_isHealed) then {
                [_unit, false] call AS_medical_fnc_setUnconscious;
            };
        } else {
            // this would not be needed, but currently the medic does not use epipen.
            // See https://github.com/acemod/ACE3/pull/5433
            // So, we just do it ourselves (without animations and stuff)
            private _hasBandaging = ([_unit] call ACE_medical_fnc_getBloodLoss) == 0;
            private _hasMorphine  = (_unit getVariable ["ACE_medical_pain", 0]) <= 0.2;
            if (_hasBandaging and _hasMorphine) then {
                [_unit, false] call AS_medical_fnc_setUnconscious;
            };
        };
    };

    if (_wasUnconscious and not _isUnconscious) then {
        // became conscious
        _unit setCaptive false;
        if not isPlayer _unit then {
            _unit stop false;
        };
        _wasUnconscious = false;
    };
};
