#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_add");
params ["_type", "_location"];
private _name = format ["%1_%2", _type, _location];
[call AS_mission_fnc_dictionary, _name] call DICT_fnc_add;
[_name, "status", "possible"] call AS_mission_fnc_set;
[_name, "type", _type] call AS_mission_fnc_set;
[_name, "location", _location] call AS_mission_fnc_set;
_name
