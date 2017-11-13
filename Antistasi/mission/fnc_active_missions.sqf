// return all active missions of a given list of types
private _missionTypes = _this;
if (typeName _missionTypes == "STRING") then {
    _missionTypes = [_missionTypes];
};
if (count _missionTypes == 0) exitWith {
    (call AS_mission_fnc_all) select {_x call AS_mission_fnc_status == "active"}
};
(call AS_mission_fnc_all) select {
    _x call AS_mission_fnc_status == "active" and
    _x call AS_mission_fnc_type in _missionTypes}
