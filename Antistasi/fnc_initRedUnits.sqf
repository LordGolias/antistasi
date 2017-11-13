params ["_soldiersToInit", ["_initSide", side_red], ["_vehicleToInit", "none"]];

if (typeName _initSide == "GROUP") then {
    _initSide = side _initSide;
};

if (_initSide == side_red) then {
    if (typeName _soldiersToInit == "ARRAY") then {
        {_x call AS_fnc_initUnitCSAT} forEach _soldiersToInit;
    }
    else {
        {_x call AS_fnc_initUnitCSAT} forEach units _soldiersToInit;
    };
    if !(_vehicleToInit isEqualTo "none") then {
        [_vehicleToInit, "CSAT"] call AS_fnc_initVehicle;
    };
} else {
    if (typeName _soldiersToInit == "ARRAY") then {
        {[_x] spawn AS_fnc_initRedUnits} forEach _soldiersToInit;
    }
    else {
        {[_x] spawn AS_fnc_initRedUnits} forEach units _soldiersToInit;
    };
    if !(_vehicleToInit isEqualTo "none") then {
        [_vehicleToInit, "AAF"] call AS_fnc_initVehicle;
    };
};
