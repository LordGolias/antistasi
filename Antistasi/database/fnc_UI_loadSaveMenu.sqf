disableSerialization;
createDialog "AS_SaveLoadMenu";

[] call AS_database_fnc_UI_updateSaveGameList;

if isNil "placementDone" then {
    // catch the escape so that the player returns to the previous menu
    (findDisplay 1601) displayAddEventHandler ["KeyDown", {
        if ((_this select 1) == 1) exitWith {  // escape pressed
            [] spawn AS_fnc_UI_closeSaveLoadMenu;
            true
        };
        false
    }];
};
