params ["_mission"];
private _location = _mission call AS_mission_fnc_location;

private _name = _mission call AS_mission_fnc_title;
if (_location != "") then {
    _name = _name + " at " + ([_location] call AS_fnc_location_name);
};
_name
