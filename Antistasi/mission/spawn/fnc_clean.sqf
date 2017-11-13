params ["_mission"];
([_mission, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];

{AS_commander hcRemoveGroup _x} forEach _groups;
[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
sleep 30;
[_task] call BIS_fnc_deleteTask;
_mission call AS_mission_fnc_completed;
