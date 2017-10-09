params ["_type"];

private _index = (["FIA", "squads"] call AS_fnc_getEntity) find _type;
if (_index == -1) exitWith {"Unnamed squad"};

(["FIA", "squad_names"] call AS_fnc_getEntity) select _index
