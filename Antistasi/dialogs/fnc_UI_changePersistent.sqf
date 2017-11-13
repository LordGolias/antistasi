#include "../macros.hpp"
params ["_var", "_amount", ["_bound", nil], ["_message", "%1"]];

if (_var == "minAISkill" and _amount > 0) then {
    _bound = AS_P("maxAISkill");
};
if (_var == "maxAISkill" and _amount < 0) then {
    _bound = AS_P("minAISkill");
};

private _newValue = AS_P(_var) + _amount;
if (_amount < 0 and (!isNil "_bound")) then {
    _newValue = (_newValue max _bound);
};
if (_amount > 0 and (!isNil "_bound")) then {
    _newValue = (_newValue min _bound);
};
AS_Pset(_var, _newValue);

if (_var in ["minAISkill", "maxAISkill"]) then {
    hint format ["min AI skill between [%1,%2]", AS_P("minAISkill"), AS_P("maxAISkill")];
} else {
    if (_var == "cleantime") then {
        _newValue = _newValue/60;
    };
    if (_var == "civPerc") then {
        _newValue = _newValue*100;
    };
    hint format [_message, _newValue];
};
