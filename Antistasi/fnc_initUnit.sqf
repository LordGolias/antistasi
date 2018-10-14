params ["_unit", "_faction", "_spawned"];

if (_faction == "AAF") exitWith {
    [_unit, _spawned] call AS_fnc_initUnitAAF;
};
if (_faction == "CSAT") exitWith {
    [_unit] call AS_fnc_initUnitCSAT;
};
if (_faction == "NATO") exitWith {
    [_unit] call AS_fnc_initUnitNATO;
};
if (_faction == "FIA") exitWith {
    [_unit, _spawned] call AS_fnc_initUnitFIA;
};
if (_faction == "CIV") exitWith {
    [_unit] call AS_fnc_initUnitCIV;
};
