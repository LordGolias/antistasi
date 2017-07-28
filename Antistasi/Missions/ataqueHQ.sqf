#include "../macros.hpp"
private _tskTitle = localize "STR_tsk_HQAttack";
private _tskDesc = localize "STR_tskDesc_HQAttack";

private _location = "fia_hq";
private _position = _location call AS_fnc_location_position;

private _origin = getMarkerPos "spawnCSAT";

private _debug_prefix = "ataqueHQ cancelled: ";
if (server getVariable "blockCSAT") exitWith {
	private _message = "blocked";
	AS_ISDEBUG(_debug_prefix + _message);
};
if (count ("aaf_attack_hq" call AS_fnc_active_missions) != 0) exitWith {
	private _message = "one already in progress";
	AS_ISDEBUG(_debug_prefix + _message);
};

if ({(_x distance _position < 500) and ((typeOf _x == "B_static_AA_F") or (typeOf _x == statAA))} count AS_P("vehicles") > 4) exitWith {};

private _mission = ["aaf_attack_hq", _location] call AS_fnc_mission_add;
[_mission, "status", "active"] call AS_fnc_mission_set;
private _task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"CREATED",10,true,true,"Defend"] call BIS_fnc_setTask;

private _vehiculos = [];
private _grupos = [];

private _fnc_clean = {
	[_grupos, _vehiculos] call AS_fnc_cleanResources;
	sleep 30;
    [_task] call BIS_fnc_deleteTask;
    _mission call AS_fnc_mission_completed;
};

for "_i" from 1 to (1 + round random 2) do {
	private _pos = [_position, AS_P("spawnDistance") * 3, random 360] call BIS_Fnc_relPos;
	private _vehicle = [_pos, 0, opHeliFR, side_red] call bis_fnc_spawnvehicle;
	private _heli = _vehicle select 0;
	private _grupoheli = _vehicle select 2;
	_grupos pushBack _grupoheli;
	_vehiculos pushBack _heli;

	{_x setBehaviour "CARELESS";} forEach units _grupoheli;
	private _tipoGrupo = [opGroup_SpecOps, side_red] call fnc_pickGroup;
	private _grupo = [_pos, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
	{_x assignAsCargo _heli; _x moveInCargo _heli; [_x] spawn CSATinit} forEach units _grupo;
	_grupos pushBack _grupo;
	[_heli,"CSAT Air Transport"] spawn inmuneConvoy;
	[_heli,_grupo,_position,_pos,_grupoheli] spawn fastropeCSAT;
	sleep 10;
};

private _soldiers = [];
{_soldiers append (units _x)} forEach _grupos;

private _max_incapacitated = round ((count _soldiers)/2);
private _max_time = time + 60*60;

private _fnc_missionFailedCondition = {false};
private _fnc_missionFailed = {
	_task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_fail", 2];
};
private _fnc_missionSuccessfulCondition = {
	{not alive _x or captive _x} count _soldiers > _max_incapacitated or
	{time > _max_time}
};
private _fnc_missionSuccessful = {
	_task = [_mission, [side_blue,civilian],[_tskDesc, _tskTitle, _location],_position,"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
	_mission remoteExec ["AS_fnc_mission_success", 2];

	{_x doMove _origin} forEach _soldiers;
	{
		private _wpRTB = _x addWaypoint [_origin, 0];
		_x setCurrentWaypoint _wpRTB;
	} forEach _grupos;
};

[_fnc_missionFailedCondition, _fnc_missionFailed, _fnc_missionSuccessfulCondition, _fnc_missionSuccessful] call AS_fnc_oneStepMission;
call _fnc_clean;
