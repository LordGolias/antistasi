params ["_seats_required"];

// select available vehicles that can seat this group
private _vehicleTypes = (["FIA", "land_vehicles"] call AS_fnc_getEntity);
_vehicleTypes = _vehicleTypes select {_x call BIS_fnc_crewCount >= _seats_required};

if (count _vehicleTypes == 0) exitWith {
    ""
};

// select cheapest vehicle
_vehicleTypes = [_vehicleTypes, [], {_x call AS_fnc_getFIAvehiclePrice}, "ASCEND"] call BIS_fnc_sortBy;
_vehicleTypes select 0
