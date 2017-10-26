params ["_type", "_position"];
private _roads = _position nearRoads 50;
if (_type == "roadblock" and count _roads == 0) exitWith {
    hint "Roadblocks have to be positioned close to roads";
};
if (count ("establish_fia_location" call AS_mission_fnc_active_missions) != 0) exitWith {
    hint "We are already building a location";
};

[_type, _position] call AS_fnc_addFIAlocation;
