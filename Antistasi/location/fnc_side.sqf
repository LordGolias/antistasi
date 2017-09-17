params ["_location"];
if !(_location call AS_location_fnc_exists) exitWith {""};
private _type = _location call AS_location_fnc_type;
if (_type != "city") exitWith {
    [_location, "side"] call AS_location_fnc_get
};
private _FIAsupport = [_this,"FIAsupport"] call AS_location_fnc_get;
private _AAFsupport = [_this,"AAFsupport"] call AS_location_fnc_get;
if (_AAFsupport >= _FIAsupport) then {
    "AAF"
} else {
    "FIA"
};
