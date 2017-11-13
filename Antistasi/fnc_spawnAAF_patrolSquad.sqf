params ["_location", "_amount"];

private _position = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;

private _units = [];
private _groups = [];

for "_i" from 1 to _amount do {
    if !(_location call AS_location_fnc_spawned) exitWith {};
    private _pos = [];
    while {true} do {
        _pos = [_position, random _size,random 360] call BIS_fnc_relPos;
        if (!surfaceIsWater _pos) exitWith {};
    };
    private _group = [_pos, side_red, [infSquad, "AAF"] call AS_fnc_pickGroup] call BIS_Fnc_spawnGroup;

    private _stance = "RANDOM";
    if (_i == 1) then {_stance = "RANDOMUP"};

    [leader _group,_location,"SAFE","SPAWNED",_stance,"NOVEH","NOFOLLOW"] spawn UPSMON;
    _groups pushBack _group;
    {[_x, false] spawn AS_fnc_initUnitAAF; _units pushBack _x} forEach units _group;
    sleep 1;
};
[_units, _groups]
