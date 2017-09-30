params ["_unit"];
private _wasUnconscious = false;

private _clean = {
    deadCam camSetPos position player;
    deadCam camCommit 1;
    sleep 1;
    deadCam cameraEffect ["terminate", "BACK"];
    camDestroy deadCam;
    (findDisplay -1) displayRemoveEventHandler ["KeyDown", respawnMenu];
};

while {alive _unit} do {
    sleep 2;
    private _isUnconscious = _unit call AS_medical_fnc_isUnconscious;

    if (not _wasUnconscious and _isUnconscious) then {
        // start
        closeDialog 0;
        openMap false;
        disableUserInput true;
        titleText ["", "BLACK FADED"];
        sleep 2;
        respawnMenu = (findDisplay -1) displayAddEventHandler ["KeyDown", {
            if (_this select 1 == 57) then {
                [player] spawn AS_fnc_respawnPlayer;
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
        private _medic = _unit call AS_medical_fnc_getAssignedMedic;
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
        call _clean;
        _wasUnconscious = false;
    };
};

// if the player died while unconscious, we need to clean ourselves
if _wasUnconscious then _clean;
