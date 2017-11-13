#include "macros.hpp"
params ["_type"];

private _pI = [];
private _p2 = [];
if (_type == "status") then {

    private _p1 = ["Number of vehicles in garage: %1", count AS_P("vehiclesInGarage")];
    _pI pushBackUnique (format _p1);

    if (count AS_P("vehiclesInGarage") > 0) then {
        private _vehicleTypes = [];
        {
            _vehicleTypes pushBackUnique _x;
        } forEach AS_P("vehiclesInGarage");
        _p2 = ["List of vehicles \n"];
        private _p2v = [];
        for "_i" from 0 to (count _vehicleTypes - 1) do {
            _p2 pushBack ("%" + str ((2*(_i+1))-1) + " x %" + str (2*(_i+1)));
            if (_i < (count _vehicleTypes - 1)) then {_p2 pushBack ", "};
            _p2v = _p2v + [getText (configFile >> "CfgVehicles" >> _vehicleTypes select _i >> "displayName"), ({_x == _vehicleTypes select _i} count AS_P("vehiclesInGarage"))];
        };
        _p2 = _p2 joinString "";
        _p2 = [_p2] + _p2v;
        _pI pushBackUnique (format _p2);
    };
};

[petros,_type,_pI] remoteExec ["AS_fnc_localCommunication",AS_commander];
