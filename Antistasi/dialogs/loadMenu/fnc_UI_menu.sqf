disableSerialization;
createDialog "AS_loadMenu";

[] call AS_fnc_UI_loadMenu_update;

if isNil "placementDone" then {
    // catch the escape so that the player returns to the previous menu
    (findDisplay 1601) displayAddEventHandler ["KeyDown", {
        if ((_this select 1) == 1) exitWith {  // escape pressed
            [] spawn AS_fnc_UI_loadMenu_close;
            true
        };
        false
    }];
};
