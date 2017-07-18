#define DISPLAYIDD 1602

AS_fncUI_ManageLocationsMenu = {
	disableSerialization;

	createDialog "AS_ManageLocations";

    call AS_fncUI_manageLocationsUpdateList;
};

AS_fncUI_manageLocationsUpdateList = {
    disableSerialization;

	// Fill types list
	private _cbo = ((findDisplay DISPLAYIDD) displayCtrl 0);
	lbCLear _cbo;
    {
        _cbo lbAdd(format ["%1", _x, AS_data_allCosts getVariable _x]);
        _cbo lbSetData[(lbSize _cbo)-1, _x];
    } forEach ["roadblock","watchpost","camp"];
    _cbo lbSetCurSel 0;
};

AS_fncUI_manageLocationsMapSelection = {
	private _option = _this;
	disableSerialization;
	AS_map_type = lbData [0, lbCurSel 0];
	if (AS_map_type == "") exitWith {
		hint "Select a type from the list";
	};

	closeDialog 0;

	// pick position
	switch (AS_map_type) do {
		case "roadblock": {hint "Roadblocks are positioned in roads and "};
	};
	openMap true;
	AS_map_position = [];
	onMapSingleClick "AS_map_position = _pos;";
	waitUntil {sleep 0.5; (count AS_map_position != 0) or !visibleMap};
	openMap false;
	onMapSingleClick "";

	if (count AS_map_position != 0) then {
		switch (_option) do {
			case "add": {[AS_map_type, AS_map_position] call AS_fncUI_manageLocationsAdd};
			case "abandon": {AS_map_position call AS_fncUI_manageLocationsAbandon};
			case "rename": {AS_map_position call AS_fncUI_manageLocationsRename};
		};
	} else {
		hint "You have not selected a position";
	};

	AS_map_position = nil;
	AS_map_type = nil;

	call AS_fncUI_ManageLocationsMenu;
};

AS_fncUI_manageLocationsAdd = {
	params ["_type", "_position"];
	private _roads = _position nearRoads 50;
	if (_type == "roadblock" and count _roads == 0) exitWith {
		hint "Roadblocks have to be positioned close to roads";
	};
	[_type, _position] remoteExec ["AS_fnc_establishFIALocation", 2];
};

AS_fncUI_manageLocationsAbandon = {
	private _position = _this;
	private _location = AS_map_position call AS_fnc_location_nearest;
	private _type = _location call AS_fnc_location_type;

	if (_position distance (_location call AS_fnc_location_position) > 100 or
		_location call AS_fnc_location_side != "FIA") exitWith {
		hint "No FIA location selected";
	};
	if !(_type in ["roadblock","watchpost","camp"]) exitWith {
		hint "This location cannot be abandoned";
	};
	_location remoteExec ["AS_fnc_abandonFIAlocation", 2];
};

AS_fncUI_manageLocationsRename = {
	private _position = _this;
	private _location = _position call AS_location_nearest;
	private _type = _location call AS_fnc_location_type;

	if (_position distance (_location call AS_fnc_location_position) > 100 or
		_location call AS_fnc_location_side != "FIA") exitWith {
		hint "No FIA camp selected";
	};
	if !(_type != "camp") exitWith {
		hint "Only camps can be renamed";
	};

	private _oldName = [_location,"name"] call AS_fnc_location_get;
	((findDisplay DISPLAYIDD) displayCtrl 1) ctrlSetText _oldName;

	createDialog "AS_ManageLocations_rename";
	waitUntil {dialog};
	waitUntil {!dialog};

	private _newName = ctrlText ((findDisplay DISPLAYIDD) displayCtrl 1);

	if (_newName != _oldName) then {
		[_location, _newName] remoteExec ["AS_fnc_renameFIAcamp", 2];
	};
};
