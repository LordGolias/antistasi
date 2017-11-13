#include "macros.hpp"
params ["_location", "_amount"];

private _position = _location call AS_location_fnc_position;

private _units = [];
private _groups = [];

// marker used to set the patrol area
private _mrk = createMarkerLocal [format ["%1patrolarea", random 100], _position];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [(AS_P("spawnDistance")/2),(AS_P("spawnDistance")/2)];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_mrk setMarkerDirLocal (markerDir _location);  // ERROR
_mrk setMarkerAlphaLocal 0;

// spawn patrols
for "_i" from 1 to _amount do {
    if !(_location call AS_location_fnc_spawned) exitWith {};

    private _pos = [0,0,0];
    while {true} do {
        _pos = [_position, 150 + (random 350) ,random 360] call BIS_fnc_relPos;
        if (!surfaceIsWater _pos) exitWith {};
    };
    private _group = [_pos, side_red, [infPatrol, "AAF"] call AS_fnc_pickGroup] call BIS_Fnc_spawnGroup;

    if (random 10 < 2.5) then {
        [_group createUnit ["Fin_random_F",_pos,[],0,"FORM"]] spawn AS_AI_fnc_initDog;
    };
    [leader _group, _mrk, "SAFE","SPAWNED", "NOVEH2"] spawn UPSMON;

    _groups pushBack _group;
    {[_x, false] spawn AS_fnc_initUnitAAF; _units pushBack _x} forEach units _group;
};
[_units, _groups, _mrk]
