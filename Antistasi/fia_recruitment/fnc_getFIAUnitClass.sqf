// unit type -> unit class
params ["_type"];

if (_type == "Medic") exitWith {
    ["FIA", "medic"] call AS_fnc_getEntity
};
if (_type == "Engineer") exitWith {
    ["FIA", "engineer"] call AS_fnc_getEntity
};
if (_type == "Crew") exitWith {
    ["FIA", "crew"] call AS_fnc_getEntity
};
if (_type == "Survivor") exitWith {
    ["FIA", "survivor"] call AS_fnc_getEntity
};
["FIA", "soldier"] call AS_fnc_getEntity
