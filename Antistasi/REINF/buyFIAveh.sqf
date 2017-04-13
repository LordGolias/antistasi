#include "../macros.hpp"
if (player != player getVariable ["owner",player]) exitWith {hint "You cannot buy vehicles while you are controlling AI"};

private _enemiesNearby = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance player < 500) and (not(captive _x))) exitWith {_enemiesNearby = true};
} forEach allUnits;

if (_enemiesNearby) exitWith {
	Hint "You cannot buy vehicles with enemies nearby";
};

params ["_type"];

private _coste = [_type] call FIAvehiclePrice;

private _resourcesFIA = AS_P("resourcesFIA");
if (isMultiPlayer and player != AS_commander) then {
	_resourcesFIA = player getVariable "dinero";
};

if (_resourcesFIA < _coste) exitWith {hint format ["You do not have enough money for this vehicle: %1 € required",_coste]};

private _pos = position player findEmptyPosition [5,50,_type];
if (count _pos == 0) exitWith {
	hint "Not enough space to place this vehicle";
};
private _veh = _type createVehicle _pos;

if (isMultiPlayer and player != AS_commander) then {
	[-_coste] call resourcesPlayer;
	_veh setVariable ["duenyo", getPlayerUID player, true];
} else {
	[0,-_coste] call resourcesFIA;
};

[_veh, "FIA"] call AS_fnc_initVehicle;

if (_type isKindOf "StaticWeapon") then {
	staticsToSave pushBackUnique _veh;
	publicVariable "staticsToSave";
	_veh addAction [localize "STR_act_moveAsset", "moveObject.sqf","static",0,false,true,"","(_this == AS_commander)"];
};
hint "Vehicle Purchased";
player reveal _veh;
petros directSay "SentGenBaseUnlockVehicle";
