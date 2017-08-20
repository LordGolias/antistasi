AS_fnc_initMedical = {
    params ["_unit"];
    if not hayACEmedical then {
        _unit addEventHandler ["HandleDamage", handleDamage];
    };
    // loop for AI functionality
    [_unit] spawn AS_fnc_medicLoop;

    // loop for player effects
    if isPlayer _unit then {
        [_unit] spawn AS_fnc_medicEffectsLoop;
    };
};

AS_fnc_isUnconscious = {
    params ["_unit"];
    if (not hayACEMedical) then {
        _unit getVariable ["inconsciente", false]
    } else {
        _unit getVariable ["ACE_isUnconscious", false]
    };
};

AS_fnc_canHeal = {
    params ["_medic"];
    if not hayACEmedical exitWith {
        "FirstAidKit" in (items _medic)
    };
    true
};

AS_fnc_healUnit = {
    params ["_medic", "_target"];
    if (not hayACEMedical) then {
        _target setVariable ["assignedMedic", _medic];
        _medic setVariable ["assignedPatient", _target];
        [_medic, _target] spawn AS_fnc_healAction;
    } else {
        _target setVariable ["ace_medical_ai_assignedMedic", _medic];
        private _healQueue = _medic getVariable ["ace_medical_ai_healQueue", []];
        _healQueue pushBack _target;
        _medic setVariable ["ace_medical_ai_healQueue", _healQueue];
    };
};

AS_fnc_assignedMedic = {
    params ["_target"];
    if (not hayACEMedical) then {
        _target getVariable ["assignedMedic", objNull]
    } else {
        _target getVariable ["ace_medical_ai_assignedMedic", objNull]
    };
};

AS_fnc_clearAssigned = {
    params ["_unit", "_medic"];
    if not hayACEmedical then {
        _unit setVariable ["assignedMedic", nil];
        _medic setVariable ["assignedPatient", nil];
    } else {
        _unit setVariable ["ace_medical_ai_assignedMedic", objNull];
        _medic setVariable ["ace_medical_ai_healQueue", []];
    };
};

AS_fnc_medicLoop = {
    params ["_unit"];
    private _wasUnconscious = false;
    while {alive _unit} do {
        sleep 2;
        private _isUnconscious = _unit call AS_fnc_isUnconscious;

        if (not _wasUnconscious and _isUnconscious) then {
            // became unconscious
            _unit setCaptive true;
            if not isPlayer _unit then {
                _unit stop true;
            };
            _wasUnconscious = true;
        };

        private _medic = (_unit call AS_fnc_assignedMedic);
        if (not isNull _medic and {not alive _medic or _medic call AS_fnc_isUnconscious}) then {
            _unit setVariable ["ace_medical_ai_assignedMedic", objNull];
            _medic setVariable ["ace_medical_ai_healQueue", []];
        };

        if (_isUnconscious and {isNull (_unit call AS_fnc_assignedMedic)}) then {
            // Choose a medic.
            private _bestDistance = 81; // best distance of the current medic (max distance for first medic)

            private _canHeal = {
                params ["_candidate"];
                (alive _candidate) and
                {not isPlayer _candidate} and
                {not (_candidate call AS_fnc_isUnconscious)} and
                {_candidate call AS_fnc_canHeal} and
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
                [_medic, _unit] call AS_fnc_healUnit;
            };
        };
        if _isUnconscious then {
            if not hayACEmedical then {
                if (_unit call AS_fnc_isHealed) then {
                    [_unit, false] call AS_fnc_setUnconscious;
                };
            } else {
                // this would not be needed, but currently the medic does not use epipen.
                // See https://github.com/acemod/ACE3/pull/5433
                // So, we just do it ourselves (without animations and stuff)
                private _hasBandaging = ([_unit] call ACE_medical_fnc_getBloodLoss) == 0;
                private _hasMorphine  = (_unit getVariable ["ACE_medical_pain", 0]) <= 0.2;
                if (_hasBandaging and _hasMorphine) then {
                    [_unit, false] call AS_fnc_setUnconscious;
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
};

AS_fnc_medicEffectsLoop = {
    params ["_unit"];
    private _wasUnconscious = false;
    while {alive _unit} do {
        sleep 2;
        private _isUnconscious = _unit call AS_fnc_isUnconscious;

        if (not _wasUnconscious and _isUnconscious) then {
            // start
            closeDialog 0;
            openMap false;
            disableUserInput true;
            titleText ["", "BLACK FADED"];
            sleep 2;
            respawnMenu = (findDisplay -1) displayAddEventHandler ["KeyDown", {
                if (_this select 1 == 57) then {
                    [player] spawn respawn;
                };
                false;
            }];
            titleText ["", "BLACK IN", 1];
            disableUserInput false;
            deadCam = "camera" camCreate (player modelToWorld [0,0,2]);
            deadCam camSetTarget player;
            deadCam cameraEffect ["internal", "BACK"];
            deadCam camCommit 0;
            _wasUnconscious = true;
        };

        if _isUnconscious then {
            if (random 10 < 3) then {
                playSound3D [selectRandom injuredSounds,_unit,false, getPosASL _unit, 1, 1, 50];
            };
            private _camTarget = player;
    		private _text = "";
            private _medic = _unit call AS_fnc_assignedMedic;
            if isNull _medic then {
                _text = format ["<t size='0.6'>There is no AI near to help you.<t size='0.5'><br/>Hit SPACE to Respawn"];
                _camTarget = player;
            } else {
                _text = format ["<t size='0.6'>%1 is on the way to help you.<t size='0.5'><br/>Hit SPACE to Respawn", name _medic];
                _camTarget = _medic;
            };
            [_text,0,0,2,0,0,4] spawn bis_fnc_dynamicText;
            deadCam camSetPos [(position player select 0), (position player select 1), (position player select 2) + 10];
    		deadCam camSetTarget _camTarget;
    		deadCam camCommit 2;
        };

        if (_wasUnconscious and not _isUnconscious) then {
            deadCam camSetPos position player;
            deadCam camCommit 1;
            sleep 1;
            deadCam cameraEffect ["terminate", "BACK"];
            camDestroy deadCam;
            (findDisplay -1) displayRemoveEventHandler ["KeyDown", respawnMenu];
            _wasUnconscious = false;
        };
    };
};

AS_fnc_setUnconscious = {
    params ["_unit", "_unconscious"];
    if not hayACEMedical then {
        if _unconscious then {
            _unit switchMove "";
            _unit playActionNow "Unconscious";
        } else {
            _unit playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
        };
        _unit setVariable ["inconsciente",_unconscious,true];
    } else {
        [_unit, _unconscious, 10, true] call ACE_medical_fnc_setUnconscious;
    };
};

// Used by non-ACE to direct a medic to heal a unit
AS_fnc_healAction = {
    params ["_medic", "_unit"];

    // lock the units so others cannot help
    _unit setVariable ["assignedMedic", _medic];
    _medic setVariable ["assignedPatient", _unit];
    [_medic, _unit] call cubrirConHumo;

    if (_medic == _unit) exitWith {
    	_medic groupChat "I am patching myself";
    	_medic action ["HealSoldierSelf",_medic];
        sleep 10;
        [_unit, false] call AS_fnc_setUnconscious;
    	[_unit, _medic] call AS_fnc_clearAssigned;
    	_unit groupChat "I am ready";
    };

    private _canHeal = {(!alive _medic) or (!alive _unit) or (_medic distance _unit < 3)};

    _medic groupChat format ["Hold on %1, on my way to help you",name _unit];
    private _timeOut = time + 60;

    while {true} do {
        _medic doMove getPosATL _unit;
        if ((_timeOut < time) or _canHeal or (_medic call AS_fnc_isUnconscious) or (_unit != vehicle _unit) or (_medic != vehicle _medic)) exitWith {};
        sleep 1;
    };
    if (call _canHeal) then {
        _medic stop true;
        _unit stop true;
        _medic action ["HealSoldier",_unit];
        sleep 10;
        [_unit, false] call AS_fnc_setUnconscious;
        _medic stop false;
        _unit stop false;
        _unit dofollow leader group _unit;
        _medic doFollow leader group _unit;
        _medic groupChat format ["You are ready, %1", name _unit];
    };
    // release the units so others can help
    [_unit, _medic] call AS_fnc_clearAssigned;
    _unit groupChat "I am ready";
};

// Used by non-ACE to test whether the unit is healed or not
AS_fnc_isHealed = {
    params ["_unit"];
    {
        if ((_unit getHit _x) > 0.8) exitWith {false};
        true
    } forEach ["neck","head","pelvis","spine1","spine2","spine3","body",""]
};
