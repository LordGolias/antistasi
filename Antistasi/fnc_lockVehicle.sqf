// (un-)lock a vehicle
params ["_veh", "_lock"];

if (_lock) then {
    _veh lock 2;
};
if !(_lock) then {
    _veh lock 0;
};
