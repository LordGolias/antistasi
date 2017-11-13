params ["_type", "_position"];
private _roads = _position nearRoads 50;
if (_type == "roadblock" and count _roads == 0) exitWith {
    hint "Roadblocks have to be positioned close to roads";
};
if (count ("establish_fia_location" call AS_mission_fnc_active_missions) != 0) exitWith {
    hint "We are already building a location";
};
// create the mission so it is kept stored.
private _mission = ["establish_fia_location", ""] call AS_mission_fnc_add;
[_mission, "status", "active"] call AS_mission_fnc_set;
[_mission, "position", _position] call AS_mission_fnc_set;
[_mission, "locationType", _type] call AS_mission_fnc_set;

[_mission] remoteExec ["AS_mission_fnc_activate", 2];
