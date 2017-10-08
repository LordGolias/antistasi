// Picks stuff from templates, checks consistency and define common names
call compile preprocessFileLineNumbers "initSides.sqf";

// Initializes all AAF/NATO/CSAT items (e.g. weapons, mags) from the global variables
// in the templates above. Only non-public globals defined.
call compile preprocessFileLineNumbers "initItemsSides.sqf";

// Compositions used to spawn camps, etc. Only non-public globals defined.
call compile preprocessFileLineNumbers "Compositions\campList.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpMTN.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpOP.sqf";
call compile preprocessFileLineNumbers "Compositions\FIA_RB.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpNATO_RB.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpExp.sqf";
