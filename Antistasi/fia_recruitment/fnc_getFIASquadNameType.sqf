// squad class -> squad type
params ["_name"];

private _index = AS_FIAsquadsMapping find _name;
private _class = "Infantry Squad";
if (_index == -1) then {
    diag_log format ["[AS] ERROR: squad class '%1' is not in the templates/FIA.sqf. Using type '%2'.",_name,_class];
} else {
    _class = AS_FIAsquadsMapping select (_index + 1);
};
_class
