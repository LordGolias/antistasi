params ["_type", "_position", "_group"];
private _unit = _group createUnit [_type call AS_fnc_getFIAUnitClass, _position, [], 0, "NONE"];
_unit setVariable ["AS_type", _type, true];
_unit
