params ["_marker", "_count", "_threatEvalAir"];

private _position = getMarkerPos _marker;

private _origin_pos = getMarkerPos "spawnCSAT";

private _groups = [];
private _vehicles = [];

private _attackHelis = (["CSAT", "helis_armed"] call AS_fnc_getEntity) + (["CSAT", "helis_attack"] call AS_fnc_getEntity);

for "_i" from 1 to _count do {
    private _tipoVeh = "";
    // todo: atm, the transport heli type defines the method type (rope, paradrop, land)
    // it should be the other way around
    if (_i == _count) then {
        _tipoVeh = selectRandom (["CSAT", "helis_transport"] call AS_fnc_getEntity);
    } else {
        _tipoVeh = selectRandom _attackHelis;
    };
    // find spawn position
    private _pos = [];
    while {count _pos == 0} do {
        _pos = _origin_pos findEmptyPosition [0, 500, _tipoVeh];
    };
    _pos set [2,300];

    ([_pos, 0, _tipoVeh, side_red] call bis_fnc_spawnvehicle) params ["_heli", "_heliCrew", "_grupoheli"];
    {
        _x call AS_fnc_initUnitCSAT;
    } forEach _heliCrew;
    _groups pushBack _grupoheli;
    _vehicles pushBack _heli;
    [_heli, "CSAT"] call AS_fnc_initVehicle;

    call {
        // attack heli => send him on SAD
        if (_tipoVeh in _attackHelis) exitWith {
            private _wp1 = _grupoheli addWaypoint [_position, 0];
            _wp1 setWaypointType "SAD";
            [_heli, "CSAT Air Attack"] spawn AS_fnc_setConvoyImmune;
        };
        // transport heli...

        // crew does not participate in battle
        {
            _x setBehaviour "CARELESS";
        } forEach units _grupoheli;

        // spawn squad
        private _tipogrupo = [["CSAT", "squads"] call AS_fnc_getEntity, "CSAT"] call AS_fnc_pickGroup;
        private _grupo = [_pos, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
        {
            _x assignAsCargo _heli;
            _x moveInCargo _heli;
            _x call AS_fnc_initUnitCSAT;
        } forEach units _grupo;
        _groups pushBack _grupo;
        [_heli,"CSAT Air Transport"] spawn AS_fnc_setConvoyImmune;

        // paradrop
        if (_tipoVeh in (["CSAT", "helis_paradrop"] call AS_fnc_getEntity)) exitWith {
            [_heli,_grupo,_position,_threatEvalAir] spawn AS_fnc_activateAirdrop;
        };
        // land
        if (_tipoVeh in (["CSAT", "helis_land"] call AS_fnc_getEntity)) exitWith {
            {
                _x disableAI "TARGET";
                _x disableAI "AUTOTARGET";
            } foreach units _grupoheli;
            private _landpos = [];
            _landpos = [_position, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
            _landPos set [2, 0];
            private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
            _vehicles pushBack _pad;

            [_grupoheli, _pos, _landpos, _marker, _grupo, 25*60, "air"] call AS_QRF_fnc_dismountTroops;
        };
        // fast rope
        [_grupoheli, _pos, _position, _marker, _grupo, 25*60] call AS_QRF_fnc_fastrope;
    };
};

[_groups, _vehicles]
