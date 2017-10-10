params ["_dict"];

private _version = 0;
if ([_dict, "version"] call DICT_fnc_exists) then {
    _version = [_dict, "version"] call DICT_fnc_get;
};

private _current_version = [AS_database_migrations, "latest"] call DICT_fnc_get;

if (_version != _current_version) then {
    diag_log format ["[AS] Server: outdated by %1 versions.", _current_version - _version];
    for "_i" from (_version + 1) to _current_version do {
        diag_log format ["[AS] Server: Migrating %1/%2", _i, _current_version - _version];
        [_dict, str _i] call AS_database_fnc_apply_migration;
    };
};
