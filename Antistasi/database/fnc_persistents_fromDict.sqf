#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_persistents_fromDict");

params ["_dict"];
{
    private _value = [_dict, _x] call DICT_fnc_get;
    call {
        if (_x == "vehicles") exitWith {
            private _vehicles = [];
            {
                _x params ["_type", "_pos", "_dir"];

                private _vehicle = _type createVehicle _pos;
                _vehicle setDir _dir;
                [_vehicle, "FIA"] call AS_fnc_initVehicle;
                _vehicles pushBack _vehicle;
            } forEach _value;
            AS_Pset(_x, _vehicles);
        };
        if (_x == "date") exitWith {
            setDate _value;
        };
        if (_x == "BE_module") exitWith {
            [_value] call fnc_BE_load;
        };
        AS_Pset(_x, _value);
    };
} forEach AS_database_persistents;
