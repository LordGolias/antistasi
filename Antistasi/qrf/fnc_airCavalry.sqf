params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroups", "_duration", "_type"];

if (_type == "rope") then {
    [_vehGroup, _origin, _dest, _mrk, _infGroups, _duration] call AS_QRF_fnc_fastrope;
};
if (_type == "land") then {
    [_vehGroup, _origin, _dest, _mrk, _infGroups, _duration, "air"] call AS_QRF_fnc_dismountTroops;
};
