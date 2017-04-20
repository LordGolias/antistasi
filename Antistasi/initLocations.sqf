AS_location setVariable ["all", [], true];
destroyedCities = [];
publicVariable "destroyedCities";

call {
    if (worldName == "Altis") exitwith {
        call compile preprocessFileLineNumbers "templates\world_altis.sqf";
    };
};

// This searches through all the markers in the mission.sqm and adds them.
{
    call {
        if (_x find "AS_powerplant" == 0) exitWith {[_x, "powerplant"] call AS_fnc_location_add};
        if (_x find "AS_base" == 0) exitWith {[_x, "base"] call AS_fnc_location_add};
        if (_x find "AS_airfield" == 0) exitWith {[_x, "airfield"] call AS_fnc_location_add};
        if (_x find "AS_resource" == 0) exitWith {[_x, "resource"] call AS_fnc_location_add};
        if (_x find "AS_factory" == 0) exitWith {[_x, "factory"] call AS_fnc_location_add};
        if (_x find "AS_seaport" == 0) exitWith {[_x, "seaport"] call AS_fnc_location_add};
        if (_x find "AS_outpostAA" == 0) exitWith {[_x, "outpostAA"] call AS_fnc_location_add};
        if (_x find "AS_outpost" == 0) exitWith {[_x, "outpost"] call AS_fnc_location_add};
    };
} forEach allMapMarkers;

side_blue = west; // <<<<<< player side, always, at all times, no exceptions
side_green = independent;
side_red = east;

// set the maker on petros so the HQ position is correct in new games.
grupoPetros = createGroup side_blue;
petros = grupoPetros createUnit ["B_G_Officer_F", getMarkerPos "FIA_HQ", [], 0, "NONE"];
petros setIdentity "amiguete";
petros setName "Petros";
petros forceSpeed 0;
petros setCombatMode "GREEN";
petros addAction [localize "str_act_missionRequest", {nul=CreateDialog "mission_menu";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
publicVariable "petros";
publicVariable "grupoPetros";

fuego = "Land_Campfire_F" createvehicle [0,0,0];
fuego allowDamage false;
fuego addAction [localize "str_act_rest", "skiptime.sqf",nil,0,false,true,"","isPlayer _this"];

caja = "IG_supplyCrate_F" createvehicle [0,0,0];
caja allowDamage false;
mapa = "MapBoard_altis_F" createvehicle [0,0,0];
mapa allowDamage false;
mapa addAction [localize "str_act_gameOptions", {hint format ["Arma 3 - Antistasi\n\nVersion: %1",antistasiVersion]; nul=CreateDialog "game_options_commander";},nil,0,false,true,"","(isPlayer _this) and (_this == AS_commander) and (_this == _this getVariable ['owner',objNull])"];
mapa addAction [localize "str_act_gameOptions", {hint format ["Arma 3 - Antistasi\n\nVersion: %1",antistasiVersion]; nul=CreateDialog "game_options_player";},nil,0,false,true,"","(isPlayer _this) and !(_this == AS_commander) and (_this == _this getVariable ['owner',objNull])"];
mapa addAction [localize "str_act_mapInfo", {nul = [] execVM "cityinfo.sqf";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
mapa addAction [localize "str_act_tfar", {nul=CreateDialog "tfar_menu";},nil,0,false,true,"","(isClass (configFile >> ""CfgPatches"" >> ""task_force_radio""))", 5];
mapa addAction [localize "str_act_moveAsset", "moveObject.sqf",nil,0,false,true,"","(_this == AS_commander)", 5];

bandera = "Flag_FIA_F" createvehicle [0,0,0];
bandera allowDamage false;
bandera addAction [localize "str_act_hqOptions",{call AS_fncUI_openHQmenu;},nil,0,false,true,"","(isPlayer _this) and (player == AS_commander) and (_this == _this getVariable ['owner',objNull]) and (petros == leader group petros)"];

cajaVeh = "Box_NATO_AmmoVeh_F" createvehicle [0,0,0];
cajaVeh allowDamage false;
cajaVeh addAction [localize "str_act_healRepair", "healandrepair.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];
cajaVeh addAction [localize "str_act_moveAsset", "moveObject.sqf",nil,0,false,true,"","(_this == AS_commander)",5];

AS_permanent_HQplacements = [caja, cajaVeh, mapa, fuego, bandera];

call AS_fnc_placeHQdefault;

["FIA_HQ","fia_hq"] call AS_fnc_location_add;

call AS_fnc_location_updateMarkers;
