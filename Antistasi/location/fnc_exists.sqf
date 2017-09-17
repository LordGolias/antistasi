// Whether the location exists or not.
params ["_location"];
[call AS_location_fnc_dictionary, _location] call DICT_fnc_exists;
