#include "macros.hpp"
AS_CLIENT_ONLY("fnc_addFIAlocation.sqf");

params ["_type", "_position"];

private _groupType = "";
switch _type do {
    case "watchpost": {
        _groupType = "team_sniper";
    };
    case "roadblock": {
        _groupType = "team_at";
    };
    case "camp": {
        _groupType = "team_patrol";
    };
};
private _vehicleType = (count (["FIA", _groupType] call AS_fnc_getEntity)) call AS_fnc_getFIABestSquadVehicle;

(_groupType call AS_fnc_getFIAsquadCost) params ["_hr", "_cost"];
_cost = _cost + (_vehicleType call AS_fnc_getFIAvehiclePrice);
if (_cost > AS_P("resourcesFIA")) exitWith {
    hint format ["You do not have enough money for this (%1 € needed)", _cost];
};
[-_hr, -_cost] remoteExec ["AS_fnc_changeFIAmoney", 2];

private _mission = ["establish_fia_location", ""] call AS_mission_fnc_add;
[_mission, "status", "active"] call AS_mission_fnc_set;
[_mission, "position", _position] call AS_mission_fnc_set;
[_mission, "locationType", _type] call AS_mission_fnc_set;
[_mission, "vehicleType", _vehicleType] call AS_mission_fnc_set;
[_mission, "groupType", _groupType] call AS_mission_fnc_set;

[_mission] remoteExec ["AS_mission_fnc_activate", 2];
