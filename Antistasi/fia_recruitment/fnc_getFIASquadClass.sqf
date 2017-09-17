// squad type -> squad class
params ["_type"];
private _index = AS_FIAsquadsMapping find _type;
private _class = "IRG_InfSquad";
if (_index == -1) then {
    diag_log format ["[AS] ERROR: squad type '%1' is not in the templates/FIA.sqf. Using class '%2'.",_type,_class];
} else {
    _class = AS_FIAsquadsMapping select (_index - 1);
};
_class
