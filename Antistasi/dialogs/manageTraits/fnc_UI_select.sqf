disableSerialization;
private _trait = lbData [0, lbCurSel 0];

if (_trait != "") then {
    private _textCbo = ((findDisplay 1601) displayCtrl 1);
    _textCbo ctrlSetText ([AS_traits, _trait, "description"] call DICT_fnc_get);
};
