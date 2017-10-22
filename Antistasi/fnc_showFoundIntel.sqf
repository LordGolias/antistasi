#include "macros.hpp"
AS_CLIENT_ONLY("fnc_showFoundIntel");

private _chance = 8;

if (count _this == 1) then {
	private _location = _this select 0;
	if (_location isEqualType "") then {
		if ((_location call AS_location_fnc_type) in ["base","airfield"]) then {
			_chance = 30;
		} else {
			_chance = 15;
		};
	} else {
		// Location is a unit type
		_chance = AS_data_allCosts getVariable (typeOf _location);
		if (isNil "_chance") then {
			diag_log format ["[AS] Error: cost of %1 not defined.", typeOf _location];
			_chance = 10;
		};
	};
};

private _texto = format ["<t size='0.6' color='#C1C0BB'>Intel Found.<br/> <t size='0.5' color='#C1C0BB'><br/>"];

if (random 100 < _chance) then {
	_texto = format ["%1 %2 Troop Skill Level: %3<br/>",_texto, (["AAF", "name"] call AS_fnc_getEntity), AS_P("skillAAF")];
};
if (random 100 < _chance) then {
	_texto = format ["%1 %2 Next Counterattack: %3 minutes<br/>",_texto, (["AAF", "name"] call AS_fnc_getEntity), round (AS_P("secondsForAAFattack")/60)];
};
if (random 100 < _chance) then {
	private _resourcesAAF = AS_P("resourcesAAF");
	if (_resourcesAAF < 1000) then {
		_texto = format ["%1 %2 Funds: Poor<br/>",_texto, (["AAF", "name"] call AS_fnc_getEntity)]
	} else {
		_texto = format ["%1 %2 Funds: %3 €<br/>",_texto, (["AAF", "name"] call AS_fnc_getEntity), _resourcesAAF]
	};
};

{
	if (random 100 < _chance) then {
		private _count = _x call AS_AAFarsenal_fnc_count;
		if (_count < 1) then {
			_count = "None";
		};
		_texto = format ["%1 %2 %3: %4<br/>",_texto, (["AAF", "name"] call AS_fnc_getEntity), _x call AS_AAFarsenal_fnc_name, _count];
	};
} forEach call AS_AAFarsenal_fnc_all;

if (_texto == "<t size='0.6' color='#C1C0BB'>Intel Found.<br/> <t size='0.5' color='#C1C0BB'><br/>") then {
	_texto = format ["<t size='0.6' color='#C1C0BB'>Intel Not Found.<br/> <t size='0.5' color='#C1C0BB'><br/>"];
};

[_texto, [safeZoneX, (0.2 * safeZoneW)], [0.25, 0.5], 30, 0, 0, 4] spawn bis_fnc_dynamicText;
