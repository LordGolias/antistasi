params ["_location", ["_restructured", false]];
private ["_texto","_garrison","_size","_posicion"];

private _garrison = [_location, "garrison"] call AS_fnc_location_get;
private _position = _location call AS_fnc_location_position;
private _size = _location call AS_fnc_location_size;

private _lineBreak = "\n";
if (_restructured) then {
    _lineBreak = "<br/>";
};

_text = format ["Garrison size: %1" + _lineBreak, count _garrison] +
        format ["; Statics: %1", {_x distance _position < _size} count staticsToSave];
{
    private _type = _x;
    private _count = {_x == _type} count _garrison;
    if (_count > 0) then {
        _text = _text + format [_lineBreak+"%1: %2", _type, _count];
    };
} forEach AS_allFIAUnitTypes;
_text
