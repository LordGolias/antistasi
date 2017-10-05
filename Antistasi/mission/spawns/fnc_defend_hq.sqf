#include "../../macros.hpp"

private _fnc_initialize = {
	params ["_mission"];
	private _tskTitle = localize "STR_tsk_HQAttack";
	private _tskDesc = localize "STR_tskDesc_HQAttack";

	private _location = "FIA_HQ";
	private _position = _location call AS_location_fnc_position;

	[_mission, [_tskDesc,_tskTitle,_location], _position, "Defend"] call AS_mission_spawn_fnc_saveTask;
};

private _fnc_spawn = {
	params ["_mission"];
	private _location = "FIA_HQ";
	private _position = _location call AS_location_fnc_position;
	private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
	private _origin = getMarkerPos "spawnCSAT";

	private _vehiculos = [];
	private _groups = [];

	for "_i" from 1 to (1 + round random 2) do {
		private _pos = [_origin, AS_P("spawnDistance") * 3, random 360] call BIS_Fnc_relPos;
		private _type = selectRandom (["CSAT", "helis_fastrope"] call AS_fnc_getEntity);
		private _vehicle = [_pos, 0, _type, side_red] call bis_fnc_spawnvehicle;
		private _heli = _vehicle select 0;
		private _grupoheli = _vehicle select 2;
		_groups pushBack _grupoheli;
		_vehiculos pushBack _heli;

		{_x setBehaviour "CARELESS";} forEach units _grupoheli;
		private _tipoGrupo = [["CSAT", "recon_squad"] call AS_fnc_getEntity, "CSAT"] call AS_fnc_pickGroup;
		private _grupo = [_pos, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
		{_x assignAsCargo _heli; _x moveInCargo _heli; _x call AS_fnc_initUnitCSAT} forEach units _grupo;
		_groups pushBack _grupo;
		[_heli,"CSAT Air Transport"] spawn AS_fnc_setConvoyImmune;
		[_grupoheli, _pos, _position, _location, [_grupo], 25*60] call AS_QRF_fnc_fastrope;
	};

	private _soldiers = [];
	{_soldiers append (units _x)} forEach _groups;

	[_mission, "resources", [_task, _groups, _vehiculos, []]] call AS_spawn_fnc_set;
	[_mission, "soldiers", _soldiers] call AS_spawn_fnc_set;
};

private _fnc_run = {
	params ["_mission"];
	private _soldiers = [_mission, "soldiers"] call AS_spawn_fnc_get;
	private _groups = ([_mission, "resources"] call AS_spawn_fnc_get) select 1;

	private _max_incapacitated = round ((count _soldiers)/2);
	private _max_time = time + 60*60;

	private _fnc_missionFailedCondition = {false};
	private _fnc_missionFailed = {
		([_mission, "FAILED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_mission_fnc_fail", 2];
	};
	private _fnc_missionSuccessfulCondition = {
		{not alive _x or captive _x} count _soldiers > _max_incapacitated or
		{time > _max_time}
	};
	private _fnc_missionSuccessful = {
		([_mission, "SUCCEEDED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;
		_mission remoteExec ["AS_mission_fnc_success", 2];

		private _origin = getMarkerPos "spawnCSAT";

		{_x doMove _origin} forEach _soldiers;
		{
			private _wpRTB = _x addWaypoint [_origin, 0];
			_x setCurrentWaypoint _wpRTB;
		} forEach _groups;
	};

	[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
};

AS_mission_defendHQ_states = ["initialize", "spawn", "run", "clean"];
AS_mission_defendHQ_state_functions = [
	_fnc_initialize,
	_fnc_spawn,
	_fnc_run,
	AS_mission_spawn_fnc_clean
];
