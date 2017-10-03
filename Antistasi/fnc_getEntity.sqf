params ["_faction", "_type"];
private "_side";
if (_faction in ["AAF", "CSAT"]) then {
    _side = side_red;
} else {
    _side = side_blue;
};

[AS_units, "AAF", str _side, _type] call DICT_fnc_get
