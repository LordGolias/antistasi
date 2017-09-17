// unit type -> unit class
params ["_type"];
private _index = AS_FIAsoldiersMapping find _type;
private _class = "B_G_Soldier_F";
if (_index == -1) then {
    diag_log format ["[AS] ERROR: unit type '%1' is not in the templates/FIA.sqf. Using unit class '%2'.",_type,_class];
} else {
    _class = AS_FIAsoldiersMapping select (_index - 1);
};
_class
