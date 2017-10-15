disableSerialization;
params ["_list_id"];
private _trait = lbData [_list_id, lbCurSel _list_id];

if (_trait != "") then {
    private _textCbo = ((findDisplay 1601) displayCtrl 1);
    _textCbo ctrlSetText ([AS_traits, _trait, "description"] call DICT_fnc_get);
};
