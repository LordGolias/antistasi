#include "macros.hpp"
AS_SERVER_ONLY("initLocations.sqf");

["location"] call AS_fnc_container_add;

AS_antenasTypes = [];
AS_antenasPos_alive = [];
AS_antenasPos_dead = [];

// tower buiuldings where MGs are placed. If no towers, no MGs are placed.
AS_MGbuildings = [
    "Land_Cargo_Tower_V1_F",
    "Land_Cargo_Tower_V1_No1_F",
    "Land_Cargo_Tower_V1_No2_F",
    "Land_Cargo_Tower_V1_No3_F",
    "Land_Cargo_Tower_V1_No4_F",
    "Land_Cargo_Tower_V1_No5_F",
    "Land_Cargo_Tower_V1_No6_F",
    "Land_Cargo_Tower_V1_No7_F",
    "Land_Cargo_Tower_V2_F",
    "Land_Cargo_Tower_V3_F"
];
// building types whose destruction is saved persistently
AS_destroyable_buildings = AS_MGbuildings + [
    "Land_Cargo_HQ_V1_F",
    "Land_Cargo_HQ_V2_F",
    "Land_Cargo_HQ_V3_F",
    "Land_Cargo_Patrol_V1_F",
    "Land_Cargo_Patrol_V2_F",
    "Land_Cargo_Patrol_V3_F",
    "Land_HelipadSquare_F",
    "Land_Cargo_Tower_V1_ruins_F",
    "Land_Cargo_Tower_V2_ruins_F",
    "Land_Cargo_Tower_V3_ruins_F"
];

// these are the lamps that are shut-off when the city loses power.
// if empty, no lamps are turned off
AS_lampTypes = [
    "Lamps_Base_F",
    "PowerLines_base_F",
    "Land_LampDecor_F",
    "Land_LampHalogen_F",
    "Land_LampHarbour_F",
    "Land_LampShabby_F",
    "Land_NavigLight",
    "Land_runway_edgelight",
    "Land_PowerPoleWooden_L_F"
];
// positions of the banks. If empty, there are no bank missions.
AS_bankPositions = [];

if (worldName == "Altis") then {
    call compile preprocessFileLineNumbers "templates\world_altis.sqf";
};


// exclude from `AS_antenasPos_alive` positions whose antenas are not found
{
    private _antenaProv = nearestObjects [_x, AS_antenasTypes, 25];
    if (count _antenaProv > 0) then {
        (_antenaProv select 0) addEventHandler ["Killed", AS_fnc_antennaKilledEH];
    } else {
        AS_antenasPos_alive = AS_antenasPos_alive - [_x];
    };
} forEach +AS_antenasPos_alive;

AS_antenasTypes = nil;  // this was only needed for list above.
publicVariable "AS_antenasPos_alive";
publicVariable "AS_antenasPos_dead";
publicVariable "AS_destroyable_buildings";
publicVariable "AS_MGbuildings";

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
        if (_x find "AS_roadblock" == 0) exitWith {[_x, "roadblock"] call AS_fnc_location_add};
    };
} forEach allMapMarkers;

call AS_fnc_location_addAllRoadblocks;

["FIA_HQ","fia_hq"] call AS_fnc_location_add;

// This is needed here because petros has a side.
side_blue = west; // <<<<<< player side, always, at all times, no exceptions
side_green = independent;
side_red = east;
publicVariable "side_blue";
publicVariable "side_green";
publicVariable "side_red";

// Initializes HQ placements and petros
fuego = "Land_Campfire_F" createvehicle [0,0,0];
publicVariable "fuego";
fuego allowDamage false;
caja = "IG_supplyCrate_F" createvehicle [0,0,0];
[caja] call emptyCrate;
publicVariable "caja";
caja allowDamage false;
mapa = "MapBoard_altis_F" createvehicle [0,0,0];
publicVariable "mapa";
mapa allowDamage false;
bandera = "Flag_FIA_F" createvehicle [0,0,0];
publicVariable "bandera";
bandera allowDamage false;
cajaVeh = "Box_NATO_AmmoVeh_F" createvehicle [0,0,0];
publicVariable "cajaVeh";
cajaVeh allowDamage false;

AS_permanent_HQplacements = [caja, cajaVeh, mapa, fuego, bandera];
AS_HQ_placements = []; // objects placed on HQ
