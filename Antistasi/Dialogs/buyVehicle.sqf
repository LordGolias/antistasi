// starts the menu
AS_fncUI_buyVehicleMenu = {
	disableSerialization;
	createDialog "AS_buyVehicle";

	call AS_fncUI_updateBuyVehiclesList;
};

// updates the left list and right text field
AS_fncUI_updateBuyVehiclesList = {
	disableSerialization;
	private _cbo = ((findDisplay 1602) displayCtrl 0);
	lbCLear _cbo;

	{
		_cbo lbAdd (getText(configFile >> "cfgVehicles" >> _x >> "displayName"));
		private _picture = (getText(configFile >> "cfgVehicles" >> _x >> "picture"));
		_cbo lbSetPicture[(lbSize _cbo)-1, _picture];

		_cbo lbSetData[(lbSize _cbo)-1, _x];
	} forEach (AS_FIArecruitment_all - (AS_FIArecruitment getVariable "water_vehicles"));

	_cbo lbSetCurSel 0;
	call AS_fncUI_updateVehicleData;
};

// updates the right text field with data about the vehicle
AS_fncUI_updateVehicleData = {
	disableSerialization;
	private _class = lbData [0, lbCurSel 0];

	private _weapons = [];
	private _weaponsClass = getArray(configFile >> "cfgVehicles" >> _class >> "weapons");
	{
		private _name = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
		_weapons = _weapons + [ _name];
	} forEach _weaponsClass;

	private _weapArray = [];
	if (isClass (configFile >> "cfgVehicles" >> _class >> "Turrets" >> "M2_Turret")) then {
		_weapArray = getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "M2_Turret" >> "weapons");
	} else {
		_weapArray = getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "MainTurret" >> "weapons");
		_weapArray = _weapArray + (getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "FrontTurret" >> "weapons"));
		_weapArray = _weapArray + (getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "RearTurret" >> "weapons"));
	};

	{
		_name = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
		_weapons = _weapons + [ _name];
	} forEach _weapArray;
	_weapons = _weapons - ["Horn", ""];

	// format weapons text
	if (count _weapons == 0) then {
		_weapons = "<t align='right'>None</t><br/>";
	} else {
		private _text = "<br/>";
		{
			_text = _text + format ["<t align='left'>%1</t><br/>", _x];
		} forEach _weapons;
		_weapons = _text;
	};

	private _isUndercover = "No";
	if (_class in (arrayCivVeh + [civHeli])) then {
		_isUndercover = "Yes";
	};
	_crewCount = [_class, true] call BIS_fnc_crewCount;

	private _textCbo = ((findDisplay 1602) displayCtrl 1);

	_textCbo ctrlSetStructuredText parseText format
	["
	<t align='left'>Is undercover:</t> <t align='right'>%4</t><br/>
	<t align='left'>Cost:</t> <t align='right'>%3€</t><br/>
	<t align='left'>Weapons:</t> %1
	<t align='left'>Passengers:</t> <t align='right'>%2</t><br/>",
	_weapons,_crewCount, [_class] call FIAvehiclePrice, _isUndercover];
};

// action button to buy the vehicle
AS_fncUI_buyVehicle = {
	disableSerialization;
	private _class = lbData [0, lbCurSel 0];

	if (_class != "") then {
		[_class] call buyFIAveh;
	} else {
		hint "No vehicle selected";
	};
};
