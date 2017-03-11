if (hayACE) exitWith {hint "Feature disabled with ACE Mod"};
private ["_units","_unit"];

_units = _this select 0;

_unit = _units select 0;

if (_unit == Petros) exitWith {hint "You cannot control Petros";};

if (player != leader group player) exitWith {hint "You cannot control AI if you are not the squad leader"};
if (isPlayer _unit) exitWith {hint "You cannot control another player"};
if (!alive _unit) exitWith {hint "You cannot control a dead unit"};
if (_unit getVariable ["inconsciente",false]) exitWith {hint "You cannot control an unconscious unit"};
if (captive _unit) exitWith {hint "You cannot control an Undercover unit"};
if ((not(typeOf _unit in soldadosFIA)) and (typeOf _unit != "b_g_survivor_F")) exitWith {hint "You cannot control a unit which does not belong to FIA"};


//if ({((side _x == EAST) or (side _x == independent)) and (not (captive _x)) and (_x distance player < 500)} count allUnits > 0) exitWith {hint "You cannot remote control with enemies nearby"};
//if ({((side _x == EAST) or (side _x == independent)) and (not (captive _x)) and (_x distance _unit < 500)} count allUnits > 0) exitWith {hint "You cannot remote control with enemies nearby the target unit"};
_owner = player getVariable ["owner",player];
if (_owner!=player) exitWith {hint "You cannot control AI while you are controlling another AI"};

{
if (_x != vehicle _x) then
	{
	[_x] orderGetIn true;
	};
} forEach units group player;

_unit setVariable ["owner",player,true];
selectPlayer _unit;

_tiempo = 60;

_unit addAction [localize "STR_act_returnControl",{selectPlayer leader (group (_this select 0))}];

waitUntil {sleep 1; hint format ["Time to return control to AI: %1", _tiempo]; _tiempo = _tiempo - 1; (_tiempo == -1) or (isPlayer (leader group player))};

removeAllActions _unit;
selectPlayer (_unit getVariable ["owner",_unit]);
//_unit setVariable ["owner",nil,true];
{[_x] joinsilent group player} forEach units group player;
group player selectLeader player;
hint "";

