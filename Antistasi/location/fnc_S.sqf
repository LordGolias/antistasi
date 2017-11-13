// returns all locations of a given side
if (_this isEqualType []) exitWith {
    (call AS_location_fnc_all) select {(_x call AS_location_fnc_side) in _this}
};
(call AS_location_fnc_all) select {_x call AS_location_fnc_side == _this}
