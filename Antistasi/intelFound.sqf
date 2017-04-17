#include "macros.hpp"
if (isDedicated) exitWith {};

_chance = 8;

if (count _this == 1) then
	{
	private _location = _this select 0;
	if (_location isEqualType "") then
		{
		if ((_location call AS_fnc_location_type) in ["base","airfield"]) then {_chance = 30} else {_chance = 15};
		}
	else
		{
		if (typeOf _location in infList_officers) then {_chance = 50}
		else
			{
			if ((typeOf _location in infList_NCO) or (typeOf _location in infList_pilots)) then {_chance = 15}
			};
		};
	};

_texto = format ["<t size='0.6' color='#C1C0BB'>Intel Found.<br/> <t size='0.5' color='#C1C0BB'><br/>"];

if (random 100 < _chance) then
	{
	_texto = format ["%1 AAF Troop Skill Level: %2<br/>",_texto, AS_P("skillAAF")];
	};
if (random 100 < _chance) then
	{
	if (cuentaCA < 600) then {_texto = format ["%1 AAF Next Counterattack: ASAP<br/>",_texto]} else {_texto = format ["%1 AAF Next Counterattack: %2 minutes<br/>",_texto,round (cuentaCA/60)]};
	};
if (random 100 < _chance) then
	{
	_resourcesAAF = AS_P("resourcesAAF");
	if (_resourcesAAF < 1000) then {_texto = format ["%1 AAF Funds: Poor<br/>",_texto]} else {_texto = format ["%1 AAF Funds: %2 €<br/>",_texto,_resourcesAAF]};
	};

{
	if (random 100 < _chance) then {
		private _count = [_x] call AS_fnc_AAFarsenal_count;
		if (_count < 1) then {
			_count = "None";
		};
		_texto = format ["%1 AAF %2: %3<br/>",_texto, [_x] call AS_fnc_AAFarsenal_name, _count];
	};
} forEach AS_AAFarsenal_categories;

_minasAAF = allmines - (detectedMines side_blue);
_revelaMina = false;
if (count _minasAAF > 0) then
	{
	{if (random 100 < _chance) then {side_blue revealMine _x; _revelaMina = true}} forEach _minasAAF;
	};
if (_revelaMina) then {_texto = format ["%1 New Mines marked on your map<br/>",_texto];};

if (_texto == "<t size='0.6' color='#C1C0BB'>Intel Found.<br/> <t size='0.5' color='#C1C0BB'><br/>") then {_texto = format ["<t size='0.6' color='#C1C0BB'>Intel Not Found.<br/> <t size='0.5' color='#C1C0BB'><br/>"];};

//[_texto,-0.9999,0,30,0,0,4] spawn bis_fnc_dynamicText;
[_texto, [safeZoneX, (0.2 * safeZoneW)], [0.25, 0.5], 30, 0, 0, 4] spawn bis_fnc_dynamicText;
