#include "../macros.hpp"
private _scoreNeededLand = 0;
private _scoreNeededAir = 0;

{
    private _analizado = _x;
    private _analizadoPos = _x call AS_location_fnc_position;
    private _analizadoSize = _x call AS_location_fnc_size;
    private _analizadoType = _x call AS_location_fnc_type;
    private _analizadoGarrison = _x call AS_location_fnc_garrison;

    _scoreNeededLand = _scoreNeededLand + floor ((count _analizadoGarrison)/8);
    _scoreNeededAir = _scoreNeededAir + floor (({_x == "AA Specialist"} count _analizadoGarrison)/2);
    if (_analizadoType in ["base", "airfield"]) then {
        _scoreNeededLand = _scoreNeededLand + 3;
        _scoreNeededAir = _scoreNeededAir + 3;
    };
    private _estaticas = AS_P("vehicles") select {_x distance _analizadoPos < _analizadoSize};

    _scoreNeededLand = _scoreNeededLand + ({typeOf _x in allStatMortars} count _estaticas) + (2*({typeOf _x in allStatATs} count _estaticas));
    _scoreNeededAir = _scoreNeededAir + ({typeOf _x in allStatMGs} count _estaticas) + (5*({typeOf _x in allStatAAs} count _estaticas));
} forEach _this;

[_scoreNeededLand, _scoreNeededAir]
