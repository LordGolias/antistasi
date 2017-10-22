#include "../macros.hpp"
AS_SERVER_ONLY("fnc_sendAAFroadPatrol");
private _validCategories = ["cars_armed", "helis_armed", "boats"];

private _max_patrols = 3*(count allPlayers);
if (AS_S("AAFpatrols") >= _max_patrols) exitWith {
    AS_ISDEBUG("[AS] Debug: AAFroadPatrol: max patrols reached");
};

private _origin = "";
private _type = "";
private _category = "";
{
    private _validOrigins = ["base"];
    if (_x in ["cars_armed"]) then {
        _validOrigins = ["base", "outpost"];
    };
    if (_x in ["helis_armed"]) then {
        _validOrigins = ["airfield"];
    };
    if (_x  == "boats") then {
        _validOrigins = ["searport"];
    };
    _validOrigins = [_validOrigins, "AAF"] call AS_location_fnc_TS;

    _validOrigins = _validOrigins select {!(_x call AS_location_fnc_spawned)};
    if (count _validOrigins > 0 and {_x call AS_AAFarsenal_fnc_count > 0}) exitWith {
        _origin = [_validOrigins, getMarkerPos "FIA_HQ"] call BIS_fnc_nearestPosition;
        _type = selectRandom (_x call AS_AAFarsenal_fnc_valid);
        _category = _x;
    };
} forEach (_validCategories call AS_fnc_shuffle);

if (_type == "") exitWith {
    AS_ISDEBUG("[AS] debug: fnc_createRoadPatrol cancelled: no valid types");
};

private _spawnName = format ["aaf_road_patrol_%1", floor random 100];
[_spawnName, "AAFroadPatrol"] call AS_spawn_fnc_add;
[_spawnName, "type", _type] call AS_spawn_fnc_set;
[_spawnName, "isFlying", _category == "helis_armed"] call AS_spawn_fnc_set;
[_spawnName, "origin", _origin] call AS_spawn_fnc_set;

[[_spawnName], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
