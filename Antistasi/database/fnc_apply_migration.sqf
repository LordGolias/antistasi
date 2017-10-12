params ["_dict", "_version"];

{
    private _step = [AS_database_migrations, _version, _x] call DICT_fnc_get;
    if (typeName _step == "ARRAY") then {
        ([_dict] + _step) call DICT_fnc_set;
    }
} forEach ([AS_database_migrations, _version, "steps"] call DICT_fnc_get);
