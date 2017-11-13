// returns all locations of a given type and side
params ["_type", "_side"];

if (_type isEqualType []) exitWith {
    (call AS_location_fnc_all) select {_x call AS_location_fnc_side == _side and
     (_x call AS_location_fnc_type) in _type}
};

(call AS_location_fnc_all) select {_x call AS_location_fnc_side == _side and
 _x call AS_location_fnc_type == _type}
