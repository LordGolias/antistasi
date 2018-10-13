#include "macros.hpp"
params ["_faction"];

if (_faction in ["AAF", "CSAT"]) exitWith {
    [west, east] select (AS_P("player_side") == "west")
};
if (_faction in ["FIA", "NATO"]) exitWith {
    [east, west] select (AS_P("player_side") == "west")
};
diag_log format ["[AS] Error: faction '%1' invalid", _faction];
