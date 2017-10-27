// _this is a string
if (typeName _this != "STRING") exitWith {
    diag_log format ["[AS] Error: getCost: '%1' is not a string.", _this];
    0
};
private _cost = AS_data_allCosts getVariable _this;

if isNil "_cost" then {
    diag_log format ["[AS] Error: cost of '%1' not defined.", _this];
    _cost = 0;
};
_cost
