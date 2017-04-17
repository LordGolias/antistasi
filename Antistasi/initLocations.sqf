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

// set the maker on petros so the HQ position is correct in new games.
"FIA_HQ" setMarkerPos (position petros);

["FIA_HQ","fia_hq"] call AS_fnc_location_add;

call AS_fnc_location_updateMarkers;
