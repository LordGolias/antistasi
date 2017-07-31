#include "macros.hpp"
AS_SERVER_ONLY("initLocations.sqf");

AS_location = (createGroup sideLogic) createUnit ["LOGIC",[0, 0, 0] , [], 0, ""];
publicVariable "AS_location";
AS_location setVariable ["all", [], true];

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

["FIA_HQ","fia_hq"] call AS_fnc_location_add;

call AS_fnc_location_updateMarkers;

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

call AS_fnc_initPetros;
call AS_fnc_HQdeploy;
