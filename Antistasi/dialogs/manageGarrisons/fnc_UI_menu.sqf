disableSerialization;

createDialog "AS_manageGarrisons";

((findDisplay 1602) displayCtrl 2) ctrlSetText "FIA_HQ";
call AS_fnc_UI_manageGarrisons_updateList;
