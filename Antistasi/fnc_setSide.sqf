params ["_unit", "_side"];

if not (_side in ["FIA", "AAF", "NATO", "CSAT", "CIV"]) then {
    diag_log format ["[AS] Error: %1 was initialized with invalid side '%2'", _unit, _side];
};

_unit setVariable ["AS_side", _side, true];
