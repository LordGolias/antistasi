AS_fncUI_RecruitUnitMenu = {
	disableSerialization;
	createDialog "AS_RecruitUnit";

    [] call AS_fncUI_updateRecruitUnitList;
};

AS_fncUI_selectUnit = {
    disableSerialization;
    private _id = lbCurSel 0;
    private _unitName = lbData [0, _id];
};

AS_fncUI_updateRecruitUnitList = {
    disableSerialization;
    private _cbo = ((findDisplay 1602) displayCtrl (0));
	lbCLear _cbo;

    {
        _cbo lbAdd(format ["%1 (%2€)", _x, AS_data_allCosts getVariable _x]);
        _cbo lbSetData[(lbSize _cbo)-1, _x];
    } forEach AS_allFIARecruitableSoldiers;
    _cbo lbSetCurSel 0;
};

AS_fncUI_recruitUnit = {
    disableSerialization;
    private _id = lbCurSel 0;
    private _unitName = lbData [0, _id];

    if (_unitName != "") then {
        [_unitName] call recruitFIAinfantry;
    } else {
        hint "no unit selected";
    };
};
