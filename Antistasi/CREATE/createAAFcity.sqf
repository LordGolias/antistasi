private _fnc_spawn = {
	params ["_location"];
	private _grupos = [];
	private _soldados = [];

	private _posicion = _location call AS_fnc_location_position;
	private _size = _location call AS_fnc_location_size;

	private _AAFsupport = [_location, "AAFsupport"] call AS_fnc_location_get;

	private _num = round (_size / 100); // [200, 800] -> [2, 8]
	_num = round (_num * _AAFsupport/100);
	if (_location call isFrontline) then {_num = _num * 2};
	if (_num < 1) then {_num = 1};

	// generate _num patrols.
	for "_i" from 1 to _num do {
		if !(_location call AS_fnc_location_spawned) exitWith {};
		private _grupo = [_posicion, side_red, [infGarrisonSmall, "AAF"] call fnc_pickGroup] call BIS_Fnc_spawnGroup;

		{[_x, false] spawn AS_fnc_initUnitAAF; _soldados pushBack _x} forEach units _grupo;

		// generate dog with some probability.
		if (random 10 < 2.5) then {
			private _dog = _grupo createUnit ["Fin_random_F",_posicion,[],0,"FORM"];
			[_dog] spawn guardDog;
			_soldados pushBack _dog;
		};

		// put then on patrol.
		[leader _grupo, _location, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_grupos pushBack _grupo;
	};

	[_location, "resources", [taskNull, _grupos, [], []]] call AS_spawn_fnc_set;
	[_location, "soldiers", _soldados] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_location"];
	private _posicion = _location call AS_fnc_location_position;

	private _soldados = [_location, "soldiers"] call AS_spawn_fnc_get;

	waitUntil {sleep 1;
		!(_location call AS_fnc_location_spawned) or
		({alive _x and !fleeing _x} count _soldados == 0)
	};

	// send patrol
	if ({alive _x and !fleeing _x} count _soldados == 0) then {
		[[_posicion], "patrolCA"] remoteExec ["AS_scheduler_fnc_execute", 2];
	};
};

AS_spawn_createAAFcity_states = ["spawn", "run", "clean"];
AS_spawn_createAAFcity_state_functions = [
	_fnc_spawn,
	_fnc_run,
	AS_spawn_fnc_AAFlocation_clean
];
