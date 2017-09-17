// returns all locations of a given type
if (_this isEqualType []) exitWith {
    (call AS_location_fnc_all) select {(_x call AS_location_fnc_type) in _this}
};
(call AS_location_fnc_all) select {_x call AS_location_fnc_type == _this}
