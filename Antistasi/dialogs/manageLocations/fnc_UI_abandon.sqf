private _position = _this;
private _location = AS_map_position call AS_location_fnc_nearest;
private _type = _location call AS_location_fnc_type;

if (_position distance (_location call AS_location_fnc_position) > 100 or
    _location call AS_location_fnc_side != "FIA") exitWith {
    hint "No FIA location selected";
};
if !(_type in ["roadblock","watchpost","camp"]) exitWith {
    hint "This location cannot be abandoned";
};
_location remoteExec ["AS_fnc_abandonFIAlocation", 2];
