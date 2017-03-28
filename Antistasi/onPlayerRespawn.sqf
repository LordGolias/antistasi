if (isDedicated) exitWith {};
private ["_nuevo","_viejo"];
_nuevo = _this select 0;
_viejo = _this select 1;

if (isNull _viejo) exitWith {};

waitUntil {alive player};

[_viejo] remoteExec ["postmortem",2];

_owner = _viejo getVariable ["owner",_viejo];

if (_owner != _viejo) exitWith {hint "Died while AI Remote Control"; selectPlayer _owner; disableUserInput false; deleteVehicle _nuevo};

[0,-1,getPos _viejo] remoteExec ["citySupportChange",2];

_score = _viejo getVariable ["score",0];
_punish = _viejo getVariable ["punish",0];
_dinero = _viejo getVariable ["dinero",0];
_dinero = round (_dinero - (_dinero * 0.1));
_elegible = _viejo getVariable ["elegible",true];
_rango = _viejo getVariable ["rango","PRIVATE"];

_dinero = round (_dinero - (_dinero * 0.05));
if (_dinero < 0) then {_dinero = 0};

_nuevo setVariable ["score",_score -1,true];
_nuevo setVariable ["owner",_nuevo,true];
_nuevo setVariable ["punish",_punish,true];
_nuevo setVariable ["respawning",false];
_nuevo setVariable ["dinero",_dinero,true];
//_nuevo setUnitRank (rank _viejo);
_nuevo setVariable ["compromised",0];
_nuevo setVariable ["elegible",_elegible,true];
_nuevo setVariable ["BLUFORSpawn",true,true];
_viejo setVariable ["BLUFORSpawn",nil,true];
_nuevo setCaptive false;
_nuevo setRank (_rango);
_nuevo setVariable ["rango",_rango,true];
//if (!hayACEMedical) then {[_nuevo] call initRevive};
disableUserInput false;
//_nuevo enableSimulation true;
if (_viejo == stavros) then
	{
	[_nuevo] call stavrosInit;
	};



removeAllItemsWithMagazines _nuevo;
{_nuevo removeWeaponGlobal _x} forEach weapons _nuevo;
removeBackpackGlobal _nuevo;
removeVest _nuevo;
if ((not("ItemGPS" in unlockedItems)) and ("ItemGPS" in (assignedItems _nuevo))) then {_nuevo unlinkItem "ItemGPS"};
if ((!hayTFAR) and ("ItemRadio" in (assignedItems player)) and (not("ItemRadio" in unlockedItems))) then {player unlinkItem "ItemRadio"};
if (!isPlayer (leader group player)) then {(group player) selectLeader player};


[] call AS_fnc_initPlayer;

[0,true] remoteExec ["pBarMP",player];
[true] execVM "reinitY.sqf";
statistics= [] execVM "statistics.sqf";

[player] execVM "OrgPlayers\unitTraits.sqf";
0 = [player] spawn rankCheck;