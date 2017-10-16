disableSerialization;
private _cbo = ((findDisplay 1601) displayCtrl 0);
lbCLear _cbo;

{
    _cbo lbAdd format ["%1 (%2€)",
        [AS_traits, _x, "name"] call DICT_fnc_get,
        [AS_traits, _x, "cost"] call DICT_fnc_get
    ];
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach ((AS_traits call DICT_fnc_keys) - ([player, "traits"] call AS_players_fnc_get));
_cbo lbSetCurSel 0;

private _cbo = ((findDisplay 1601) displayCtrl 10);
lbCLear _cbo;

{
    _cbo lbAdd format ["%1 (%2€)",
        [AS_traits, _x, "name"] call DICT_fnc_get,
        [AS_traits, _x, "cost"] call DICT_fnc_get
    ];
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach ([player, "traits"] call AS_players_fnc_get);
_cbo lbSetCurSel 0;
