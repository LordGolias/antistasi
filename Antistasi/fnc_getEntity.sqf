params ["_faction", "_type"];

// the units from AAF/CSAT are used in FIA/NATO when the sides are flipped.
if (AS_playersSide != west) then {
    if (_faction == "AAF") exitWith {
        _faction = "FIA";
    };
    if (_faction == "FIA") exitWith {
        _faction = "AAF";
    };
    if (_faction == "CSAT") exitWith {
        _faction = "NATO";
    };
    if (_faction == "NATO") exitWith {
        _faction = "CSAT";
    };
};

[AS_entities, _faction, _type] call DICT_fnc_get
