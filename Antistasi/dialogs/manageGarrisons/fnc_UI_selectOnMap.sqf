disableSerialization;
closeDialog 0;
openMap true;
map_location = "";
onMapSingleClick "_pos call AS_fnc_UI_manageGarrisons_onMapClick;";
waitUntil {sleep 0.5; (map_location != "") or !visibleMap};
openMap false;

call AS_fnc_UI_manageGarrisons_menu;
if (map_location != "") then {
    ((findDisplay 1602) displayCtrl 2) ctrlSetText (map_location);
    call AS_fnc_UI_manageGarrisons_updateList;
};
map_location = nil;
