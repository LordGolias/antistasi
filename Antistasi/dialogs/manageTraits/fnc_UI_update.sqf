disableSerialization;
private _cbo = ((findDisplay 1601) displayCtrl (0));
lbCLear _cbo;

{
    _cbo lbAdd format ["%1 (%2€)", _x, [AS_traits, _x, "cost"] call DICT_fnc_get];
    _cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach ((AS_traits call DICT_fnc_keys) - ([player, "traits"] call AS_players_fnc_get));
_cbo lbSetCurSel 0;
