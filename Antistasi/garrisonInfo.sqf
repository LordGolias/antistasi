params ["_marker", ["_restructured", false]];
private ["_texto","_garrison","_size","_posicion"];

_garrison = garrison getVariable [_marker,[]];

_size = [_marker] call sizeMarker;
_posicion = getMarkerPos _marker;

private _lineBreak = "\n";
if (_restructured) then {
    _lineBreak = "<br/>";
};

_text = format ["Garrison size: %1" + _lineBreak, count _garrison] + format ["; Statics: %1", {_x distance _posicion < _size} count staticsToSave];
{
    private _type = _x;
    private _count = {_x == _type} count _garrison;
    if (_count > 0) then {
        _text = _text + format [_lineBreak+"%1: %2", _type, _count];
    };
} forEach AS_allFIAUnitTypes;
_text
