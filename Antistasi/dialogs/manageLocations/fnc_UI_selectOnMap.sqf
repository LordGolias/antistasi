private _option = _this;
disableSerialization;
AS_map_type = lbData [0, lbCurSel 0];
if (AS_map_type == "") exitWith {
    hint "Select a type from the list";
};

closeDialog 0;

// pick position
switch (AS_map_type) do {
    case "roadblock": {hint "Roadblocks are positioned in roads"};
};
openMap true;
AS_map_position = [];
onMapSingleClick "AS_map_position = _pos;";
waitUntil {sleep 0.5; (count AS_map_position != 0) or !visibleMap};
openMap false;
onMapSingleClick "";

if (count AS_map_position != 0) then {
    switch (_option) do {
        case "add": {[AS_map_type, AS_map_position] call AS_fnc_UI_manageLocations_add};
        case "abandon": {AS_map_position call AS_fnc_UI_manageLocations_abandon};
        case "rename": {AS_map_position call AS_fnc_UI_manageLocations_rename};
    };
} else {
    hint "You have not selected a position";
};

AS_map_position = nil;
AS_map_type = nil;

call AS_fnc_UI_manageLocations_menu;
