params ["_marker", "_count", "_threatEvalAir"];

private _position = getMarkerPos _marker;

private _origin_pos = getMarkerPos "spawnCSAT";

private _groups = [];
private _vehicles = [];

private _transportHelis = ["CSAT", "helis_transport"] call AS_fnc_getEntity;
private _attackHelis = (["CSAT", "helis_armed"] call AS_fnc_getEntity) + (["CSAT", "helis_attack"] call AS_fnc_getEntity);

for "_i" from 1 to _count do {
    private _waveType = selectRandom ["fastrope", "disembark", "paradrop"];
    private _helicopterType = selectRandom _transportHelis;
    if (_i == 1) then {
        _waveType = "cas";
        _helicopterType = selectRandom _attackHelis;
    };
    // find spawn position
    private _pos = [];
    while {count _pos == 0} do {
        _pos = _origin_pos findEmptyPosition [0, 500, _helicopterType];
    };
    _pos set [2,300];

    ([_pos, 0, _helicopterType, side_red] call bis_fnc_spawnvehicle) params ["_heli", "_heliCrew", "_grupoheli"];
    {
        _x call AS_fnc_initUnitCSAT;
    } forEach _heliCrew;
    _groups pushBack _grupoheli;
    _vehicles pushBack _heli;
    [_heli, "CSAT"] call AS_fnc_initVehicle;

    call {
        // CAS => send chopper on SAD
        if (_waveType == "cas") exitWith {
            private _wp1 = _grupoheli addWaypoint [_position, 0];
            _wp1 setWaypointType "SAD";
            [_heli, "CSAT Air Attack"] spawn AS_fnc_setConvoyImmune;
        };
        // it is a transport wave

        // helicopter does not participate in battle
        {
            _x setBehaviour "CARELESS";
            _x disableAI "TARGET";
            _x disableAI "AUTOTARGET";
        } forEach units _grupoheli;
        [_heli,"CSAT Air Transport"] spawn AS_fnc_setConvoyImmune;

        // initialize group
		private _groupType = [["CSAT", "squads"] call AS_fnc_getEntity, "NATO"] call AS_fnc_pickGroup;
		private _group = createGroup side_red;
		[_groupType call AS_fnc_groupCfgToComposition, _group, _pos, _heli call AS_fnc_availableSeats] call AS_fnc_createGroup;
		{
			_x assignAsCargo _heli;
			_x moveInCargo _heli;
			[_x] spawn AS_fnc_initUnitCSAT;
		} forEach units _group;
		_groups pushBack _group;

        // paradrop
        if (_waveType == "paradrop") exitWith {
            [_heli,_group,_position,_threatEvalAir] spawn AS_fnc_activateAirdrop;
        };
        // land
        if (_waveType == "disembark") exitWith {
            private _landpos = [];
            _landpos = [_position, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
            _landPos set [2, 0];
            private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
            _vehicles pushBack _pad;

            [_grupoheli, _pos, _landpos, _marker, _group, 25*60, "air"] call AS_QRF_fnc_dismountTroops;
        };
        // fast rope
        [_grupoheli, _pos, _position, _marker, _group, 25*60] call AS_QRF_fnc_fastrope;
    };
};

[_groups, _vehicles]
