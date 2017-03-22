params ["_type"];
private ["_enemiesClose","_cost","_moneyAvailable","_unit"];

if (not([player] call isMember)) exitWith {hint "Only server members can recruit AI units"};

if (!allowPlayerRecruit) exitWith {hint "Server is very loaded. \nWait one minute or change FPS settings in order to fulfill this request"};

if (player != player getVariable ["owner",player]) exitWith {hint "You cannot buy units while you are controlling AI"};

if (player != leader group player) exitWith {hint "You cannot recruit units as you are not your group leader"};

_available = true;
call {
	if ((_type == "B_G_Soldier_AR_F") && (server getVariable "genLMGlocked")) exitWith {_available = false;};
	if ((_type == "B_G_Soldier_GL_F") && (server getVariable "genGLlocked")) exitWith {_available = false;};
	if ((_type == "B_G_Soldier_M_F") && (server getVariable "genSNPRlocked")) exitWith {_available = false;};
	if ((_type == "B_G_Soldier_LAT_F") && (server getVariable "genATlocked")) exitWith {_available = false;};
	if ((_type == "Soldier_AA") && (server getVariable "genAAlocked")) exitWith {_available = false;};
};
if !(_available) exitWith {hint "Required weapon not unlocked yet."};

_enemiesClose = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance player < 500) and (not(captive _x))) exitWith {_enemiesClose = true};
} forEach allUnits;
if (_enemiesClose) exitWith {Hint "You cannot recruit units with enemies nearby"};

if (server getVariable "hr" < 1) exitWith {hint "You do not have enough HR for this request"};

_cost = server getVariable _type;
if (!isMultiPlayer) then {
	_moneyAvailable = server getVariable "resourcesFIA";
} else {
	_moneyAvailable = player getVariable "dinero";
};

if (_cost > _moneyAvailable) exitWith {hint format ["You do not have enough money for this kind of unit (%1 € needed)",_cost]};

if ((count units group player) + (count units MIASquadUnits) > 9) exitWith {hint "Your squad is full or you have too many scattered units with no radio contact"};

if (_type == "Soldier_AA") then {
	_unit = group player createUnit ["B_G_Soldier_lite_F", position player, [], 0, "NONE"];
}
else {
	_unit = group player createUnit [_type, position player, [], 0, "NONE"];
};

if (!isMultiPlayer) then {
	[-1, - _cost] remoteExec ["resourcesFIA",2];
}
else {
	[-1, 0] remoteExec ["resourcesFIA",2];
	[-_cost] call resourcesPlayer;
	hint "Soldier Recruited.\n\nRemember: if you use the group menu to switch groups you will lose control of your recruited AI";
};

[_unit] spawn FIAinit;

_unit disableAI "AUTOCOMBAT";
sleep 1;
petros directSay "SentGenReinforcementsArrived";