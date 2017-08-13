AS_fncUI_RecruitSquadMenu = {
	disableSerialization;
	createDialog "AS_recruitSquad";

    [] call AS_fncUI_updateRecruitSquadList;
};

AS_fncUI_selectSquad = {
    disableSerialization;
    private _id = lbCurSel 0;
    private _squadName = lbData [0, _id];
};

AS_fncUI_updateRecruitSquadList = {
	disableSerialization;
	private _cbo = ((findDisplay 1602) displayCtrl (0));
	lbCLear _cbo;

	{
  		_cbo lbAdd(_x);
    	_cbo lbSetData[(lbSize _cbo)-1, _x];
  	} forEach AS_allFIASquadTypes;
  	_cbo lbSetCurSel 0;
};

AS_fncUI_recruitSquad = {
    disableSerialization;
    private _id = lbCurSel 0;
    private _squadName = lbData [0, _id];

    if (_squadName != "") then {
        [_squadName] spawn recruitFIAsquad;
    } else {
        hint "no squad selected";
    };
};
