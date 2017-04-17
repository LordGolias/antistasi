if (isDedicated) exitWith {};

private ["_location", "_data", "_prestigeOPFOR", "_prestigeBLUFOR", "_text", "_icon", "_power", "_pColour", "_info"];

#define CGREY "#a44232"
#define CBLUE "#3399FF"
#define CGREEN "#1DA81D"

while {true} do {
	private _power = ["powerplant" call AS_fnc_location_T, position player] call BIS_fnc_nearestPosition;
	private _side = _power call AS_fnc_location_side;
	_pSide = CGREY;
	call {
		if (_power in destroyedCities) exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CGREY};
		if (_side == "AAF") exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CGREEN};
		if (_side == "FIA") exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CBLUE};
	};

	private _city = [call AS_fnc_location_cities, position player] call BIS_Fnc_nearestPosition;
	private _position = _city call AS_fnc_location_position;
	private _size = _city call AS_fnc_location_size;

	while {(_position distance player) < _size/2} do {
		private _FIAsupport = [_city, "FIAsupport"] call AS_fnc_location_get;
		private _AAFsupport = [_city, "AAFsupport"] call AS_fnc_location_get;
		private _side = _city call AS_fnc_location_side;

		if (_city in destroyedCities) exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CGREY};
		if (_side == "AAF") exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CGREEN};
		if (_side == "FIA") exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CBLUE};

		_info = format ["<img image='%1' size='0.4' color='%2' />", _icon, _pSide];
		_text = format ["<t size='.4' align='right' color='#C1C0BB'>%1 %4 <br />Local Support: <t color='#3399FF'>%2</t> / <t color='#1DA81D'>%3</t></t>", [_location] call localizar, _FIAsupport, _AAFsupport, _info];
		[_text,[0.4 * safeZoneW + safeZoneX, 1 * safezoneH + safezoneY],[0.9 * safezoneH + safezoneY, 1 * safezoneH + safezoneY],7,0,0,1911] spawn BIS_fnc_dynamicText;
		sleep 30;
	};
	//["",1,1,1,0,0,17] spawn BIS_fnc_dynamicText; // clear the previous info text
	sleep 30;
};
