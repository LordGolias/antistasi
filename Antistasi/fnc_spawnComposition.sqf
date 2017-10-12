params ["_location"];
private _objects = [];
if ([AS_compositions, "locations", _location] call DICT_fnc_exists) then {
    private _center = [AS_compositions, "locations", _location, "center"] call DICT_fnc_get;
    private _objects = [AS_compositions, "locations", _location, "objects"] call DICT_fnc_get;
    _objects = [_center, 0, _objects] call BIS_fnc_ObjectsMapper;
};
_objects
