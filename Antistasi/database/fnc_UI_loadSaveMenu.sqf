disableSerialization;
createDialog "AS_SaveLoadMenu";

[] call AS_database_fnc_UI_updateSaveGameList;

if (isNil "placementDone") then {
    private _backButton = ((findDisplay 1601) displayCtrl (72));
    _backButton ctrlSetText "New game";

    // catch the escape
    private _escapeKey = (findDisplay 1601) displayAddEventHandler ["KeyDown", {
        if ((_this select 1) == 1) then {  // escape pressed
            [] spawn AS_fnc_HQselect;
        };
        false
    }];
    waitUntil {!isNil "placementDone"};
    (findDisplay 1601) displayRemoveEventHandler ["KeyDown", _escapeKey];
};
