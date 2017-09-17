#include "../macros.hpp"
AS_SERVER_ONLY("fnc_sendAAFroadPatrol");
private _validTypes = vehPatrol + [vehBoat];

private _max_patrols = 3*(count allPlayers);
if (AS_S("AAFpatrols") >= _max_patrols) exitWith {
    AS_ISDEBUG("[AS] Debug: AAFroadPatrol: max patrols reached");
};

private _origin = "";
private _type = "";
private _category = "";
{
    private _candidate = selectRandom _validTypes;
    _category = _candidate call AS_AAFarsenal_fnc_category;

    private _validOrigins = ["base"];
    if (_category == "trucks") then {
        _validOrigins = ["base", "outpost"];
    };
    if (_category in ["armedHelis", "transportHelis", "planes"]) then {
        _validOrigins = ["airfield"];
    };
    if (_type == vehBoat) then {
        _validOrigins = ["searport"];
    };
    _validOrigins = [_validOrigins, "AAF"] call AS_location_fnc_TS;

    _validOrigins = _validOrigins select {!(_x call AS_location_fnc_spawned)};
    if (count _validOrigins > 0 and {_category call AS_AAFarsenal_fnc_count > 0}) exitWith {
        _origin = [_validOrigins, getMarkerPos "FIA_HQ"] call BIS_fnc_nearestPosition;
        _type = _candidate;
    };
} forEach (_validTypes call AS_fnc_shuffle);

if (_type == "") exitWith {
    AS_ISDEBUG("[AS] debug: fnc_createRoadPatrol cancelled: no valid types");
};

private _spawnName = format ["AAFroadPatrol", floor random 100];
[_spawnName, "AAFroadPatrol"] call AS_spawn_fnc_add;
[_spawnName, "type", _type] call AS_spawn_fnc_set;
[_spawnName, "isFlying", _category in ["armedHelis","transportHelis", "planes"]] call AS_spawn_fnc_set;
[_spawnName, "origin", _origin] call AS_spawn_fnc_set;

[[_spawnName], "AS_spawn_fnc_execute"] call AS_scheduler_fnc_execute;
