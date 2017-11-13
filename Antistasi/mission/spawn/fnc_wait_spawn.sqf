params ["_mission"];

private _task = ([_mission, "CREATED"] call AS_mission_spawn_fnc_loadTask) call BIS_fnc_setTask;

[_mission, "resources", [_task, [], [], []]] call AS_spawn_fnc_set;
