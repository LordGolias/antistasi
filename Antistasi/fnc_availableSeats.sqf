params ["_vehicle"];
(([typeOf _vehicle, true] call BIS_fnc_crewCount) - (count crew _vehicle))
