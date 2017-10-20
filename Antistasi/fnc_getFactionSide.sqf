params ["_faction"];

if (_faction in ["AAF", "CSAT"]) exitWith {
    side_red
};
if (_faction in ["FIA", "NATO"]) exitWith {
    side_blue
};
diag_log format ["[AS] Error: faction '%1' invalid", _faction];
