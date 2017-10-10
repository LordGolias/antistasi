disableSerialization;
createDialog "AS_newGameMenu";

["west"] call AS_fnc_UI_newGame_update;

// catch the escape so the player returns to the previous menu
(findDisplay 1601) displayAddEventHandler ["KeyDown", {
    if ((_this select 1) == 1) exitWith {  // escape pressed
        [] spawn AS_fnc_UI_newGame_close;
        true
    };
    false
}];
