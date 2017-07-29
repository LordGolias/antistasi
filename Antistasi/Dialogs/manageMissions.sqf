#define DISPLAYID 1602

// starts the menu
AS_fncUI_manageMissionsMenu = {
	disableSerialization;
	createDialog "AS_ManageMissions";

	call AS_fncUI_updateMissionList;
};

// updates the left list and right text field
AS_fncUI_updateMissionList = {
	disableSerialization;
	private _cbo = ((findDisplay DISPLAYID) displayCtrl 0);
	lbCLear _cbo;

	{
		_cbo lbAdd (_x call AS_fnc_mission_name);
		_cbo lbSetData[(lbSize _cbo)-1, _x];
	} forEach (call AS_fnc_available_missions);

	_cbo lbSetCurSel 0;
	call AS_fncUI_updateMissionData;
};

// updates the right text field with data about the mission
AS_fncUI_updateMissionData = {
	disableSerialization;
	private _mission = lbData [0, lbCurSel 0];

	private _textCbo = ((findDisplay DISPLAYID) displayCtrl 1);

	private _str_success = "";
	{
		_str_success = _str_success + format ["* %1<br/>", _x];
	} forEach (_mission call AS_fnc_mission_success_description);
	private _str_fail = "";
	{
		_str_fail = _str_fail + format ["* %1<br/>", _x];
	} forEach (_mission call AS_fnc_mission_fail_description);

	private _str = format ["Success outcomes<br/>%1Failure outcomes<br/>%2", _str_success, _str_fail];

	_textCbo ctrlSetStructuredText parseText _str;
};

// action button to activate the mission
AS_fncUI_activateMission = {
	disableSerialization;
	private _mission = lbData [0, lbCurSel 0];

	if (_mission != "") then {
		_mission call AS_fnc_mission_activate;
	} else {
		hint "No mission selected";
	};
};
