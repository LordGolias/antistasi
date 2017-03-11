if (isDedicated) exitWith {};

private ["_location", "_data", "_prestigeOPFOR", "_prestigeBLUFOR", "_text", "_icon", "_power", "_pColour", "_info"];

#define CGREY "#a44232"
#define CBLUE "#3399FF"
#define CGREEN "#1DA81D"

while {true} do {
	_location = [ciudades, position player] call BIS_Fnc_nearestPosition;
	_power = [power, position player] call BIS_fnc_nearestPosition;
	_pSide = CGREY;
	call {
		if (_power in destroyedCities) exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CGREY};
		if (_power in mrkAAF) exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CGREEN};
		if (_power in mrkFIA) exitWith {_icon = '\A3\ui_f\data\map\mapcontrol\power_ca.paa'; _pSide = CBLUE};
	};

	while {(getMarkerPos _location distance player) < 400} do {
		_data = server getVariable _location;
		_prestigeOPFOR = _data select 2;
		_prestigeBLUFOR = _data select 3;
		_info = format ["<img image='%1' size='0.4' color='%2' />", _icon, _pSide];
		_text = format ["<t size='.4' align='right' color='#C1C0BB'>%1 %4 <br />Local Support: <t color='#3399FF'>%2</t> / <t color='#1DA81D'>%3</t></t>", _location, _prestigeBLUFOR, _prestigeOPFOR, _info];
		[_text,[0.4 * safeZoneW + safeZoneX, 1 * safezoneH + safezoneY],[0.9 * safezoneH + safezoneY, 1 * safezoneH + safezoneY],7,0,0,1911] spawn BIS_fnc_dynamicText;
		sleep 5;
	};
	//["",1,1,1,0,0,17] spawn BIS_fnc_dynamicText; // clear the previous info text
	sleep 5;
};