#include "macros.hpp"

params ["_faction"];

if (_faction == "AAF") exitWith {
    AS_P("faction_state")
};
if (_faction == "FIA") exitWith {
    AS_P("faction_anti_state")
};
if (_faction == "CSAT") exitWith {
    AS_P("faction_pro_state")
};
if (_faction == "NATO") exitWith {
    AS_P("faction_pro_anti_state")
};
if (_faction == "CIV") exitWith {
    AS_P("faction_civilian")
};
diag_log format ["[AS] Error: faction '%1' invalid", _faction];
