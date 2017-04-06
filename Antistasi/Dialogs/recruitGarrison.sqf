#define DISPLAYIDD 242

AS_fncUI_RecruitGarrisonMenu = {
	disableSerialization;

	createDialog "AS_RecruitGarrison";

	((findDisplay DISPLAYIDD) displayCtrl 2) ctrlSetText "FIA_HQ";
    call AS_fncUI_updateRecruitGarrisonList;
};

AS_fncUI_updateRecruitGarrisonList = {
    disableSerialization;

	// Fill recruiting list
	private _cbo = ((findDisplay DISPLAYIDD) displayCtrl 1);
	lbCLear _cbo;
    {
        _cbo lbAdd(format ["%1 (%2€)", _x, AS_data_allCosts getVariable _x]);
        _cbo lbSetData[(lbSize _cbo)-1, _x];
    } forEach AS_allFIARecruitableSoldiers;
    _cbo lbSetCurSel 0;

	// Fill dismiss list
	private _location = ctrlText ((findDisplay DISPLAYIDD) displayCtrl 2);
	private _garrison = garrison getVariable _location;

	_cbo = ((findDisplay DISPLAYIDD) displayCtrl 3);
	lbCLear _cbo;
    {
		private _unit = _x;
        _cbo lbAdd(format ["%1 (%2)", _unit, {_unit == _x} count _garrison]);
        _cbo lbSetData[(lbSize _cbo)-1, _unit];
    } forEach (_garrison arrayIntersect _garrison);
    _cbo lbSetCurSel 0;
};

AS_fncUI_recruitGarrison = {
    disableSerialization;
    private _name = lbData [1, lbCurSel 1];
	private _location = ctrlText ((findDisplay DISPLAYIDD) displayCtrl 2);

    if (_name != "" and _location in mrkFIA) then {
        [_name, _location] call recruitFIAgarrison;
		call AS_fncUI_updateRecruitGarrisonList;
    } else {
        hint "no unit selected or invalid location";
    };
};

AS_fncUI_dismissGarrison = {
    disableSerialization;
    private _name = lbData [3, lbCurSel 3];
	private _location = ctrlText ((findDisplay DISPLAYIDD) displayCtrl 2);

    if (_name != "" and _location in mrkFIA) then {
        [_name, _location] call AS_fnc_dismissFIAgarrison;
		call AS_fncUI_updateRecruitGarrisonList;
    } else {
        hint "no unit selected or invalid location";
    };
};

AS_fncUI_initMapSelection = {
	disableSerialization;
	closeDialog 0;
	openMap true;
	map_marker = "";
	onMapSingleClick "[_pos] call AS_fncUI_selectMapPosition;";
	waitUntil {sleep 0.5; (map_marker != "") or !visibleMap};
	openMap false;

	call AS_fncUI_RecruitGarrisonMenu;
	if (map_marker != "") then {
		((findDisplay DISPLAYIDD) displayCtrl 2) ctrlSetText map_marker;
		call AS_fncUI_updateRecruitGarrisonList;
	};
	map_position = nil;
};

AS_fncUI_selectMapPosition = {
	disableSerialization;
	_marker = [marcadores, _pos] call BIS_fnc_nearestPosition;
	if !(_marker in mrkFIA) exitWith {hint "That zone does not belong to FIA";};
	if (getMarkerPos _marker distance _pos > 200) exitWith {hint "You must click near a marked zone";};
	if (_marker in (puestosFIA + ciudades)) exitWith {hint "You cannot manage garrisons in this kind of zone";};
	map_marker = _marker;
};
