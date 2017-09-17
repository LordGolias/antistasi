// unit class -> unit type
params ["_name"];

private _index = AS_FIAsoldiersMapping find _name;
private _class = "Rifleman";
if (_index == -1) then {
    diag_log format ["[AS] ERROR: unit class '%1' is not in the templates/FIA.sqf. Using type '%2'.",_name,_class];
} else {
    _class = AS_FIAsoldiersMapping select (_index + 1);
};
_class
