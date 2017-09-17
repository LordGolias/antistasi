params ["_vehGroup", "_origin", "_dest", "_duration"];

[_vehGroup, _origin, _dest] call AS_QRF_fnc_approachTarget;
[_vehGroup, _origin, _dest, 300, _duration] call AS_QRF_fnc_loiter;
