#include "../macros.hpp"

if (player != AS_commander) exitWith {hint "Only the commander has access to this function"};
if (!([player] call AS_fnc_hasRadio)) exitWith {hint "You need a radio in your inventory to be able to give orders to other squads"};

if ([petros, 500] call AS_fnc_enemiesNearby) exitWith {
	hint "You cannot Recruit Squads with enemies near your HQ";
};

params ["_grouptype"];

private _isInfantry = false;
private _cost = 0;
private _costHR = 0;
private _hr = AS_P("hr");
private _resourcesFIA = AS_P("resourcesFIA");

if !(_grouptype in (["FIA", "squads_custom"] call AS_fnc_getEntity)) then {
	([_grouptype] call AS_fnc_getFIASquadCost) params ["_cost1", "_hr1"];
	_cost = _cost1;
	_costHR = _hr1;
	_isInfantry = true;
} else {
	([_grouptype] call (["FIA", "squads_custom_cost"] call AS_fnc_getEntity)) params ["_cost1", "_hr1"];
	_cost = _cost1;
	_costHR = _hr1;
};

if (_hr < _costHR) exitWith {hint format ["You do not have enough HR for this request (%1 required)",_costHR]};
if (_resourcesFIA < _cost) exitWith {hint format ["You do not have enough money for this request (%1 € required)",_cost]};

[- _costHR, - _cost] remoteExec ["AS_fnc_changeFIAmoney",2];

private _pos = getMarkerPos "FIA_HQ";
private _tam = 10;
private ["_roads", "_road"];
while {true} do {
	_roads = _pos nearRoads _tam;
	if (count _roads < 1) then {_tam = _tam + 10};
	if (count _roads > 0) exitWith {_road = _roads select 0;};
};

private _grupo = grpNull;
if _isInfantry then {
	_grupo = createGroup side_blue;
	[_grouptype, [_pos, 30, random 360] call BIS_Fnc_relPos, _grupo] call AS_fnc_spawnFIAsquad;
} else {
	_grupo = [_grouptype, position _road] call (["FIA", "squads_custom_init"] call AS_fnc_getEntity);
};

// the name that appears in HC.
private _groupID = "";
if (_grouptype == "squad") then {_groupID = "Squd-"};
if (_grouptype == "team") then {_groupID = "Tm-"};
if (_grouptype == "team_at") then {_groupID = "AT-"};
if (_grouptype == "team_sniper") then {_groupID = "Snpr-"};
if (_grouptype == "team_patrol") then {_groupID = "Stry-"};
if (_grouptype == "mobile_mortar") then {_groupID = "Mort-"};
if (_grouptype == "mobile_aa") then {_groupID = "M.AA-"};
if (_grouptype == "mobile_at") then {_groupID = "M.AT-"};
_grupo setGroupId [format ["%1%2",_groupID,{side (leader _x) == side_blue} count allGroups]];

{[_x] call AS_fnc_initUnitFIA} forEach units _grupo;
leader _grupo setBehaviour "SAFE";
AS_commander hcSetGroup [_grupo];
_grupo setVariable ["isHCgroup", true, true];
petros directSay "SentGenReinforcementsArrived";
hint format ["Group %1 at your command.\n\nGroups are managed from the High Command bar (Default: CTRL+SPACE)\n\nIf the group gets stuck, use the AI Control feature to make them start moving. Mounted Static teams tend to get stuck (solving this is WiP)\n\nTo assign a vehicle for this group, look at some vehicle, and use Vehicle Squad Mngmt option in Y menu", groupID _grupo];

if (!_isInfantry) exitWith {};

private _vehicleType = _grouptype call AS_fnc_getFIABestSquadVehicle;
if (_vehicleType == "") exitWith {
	hint "FIA has no vehicle available to buy for the size of this squad. They start on foot.";
};

_cost = [_vehicleType] call AS_fnc_getFIAvehiclePrice;

if (_cost > AS_P("resourcesFIA")) exitWith {
	hint "FIA has no money to buy a vehicle for this squad. They start on foot.";
};

createDialog "veh_query";

sleep 1;
disableSerialization;

private _display = findDisplay 100;

if (str (_display) != "no display") then {
	private _ChildControl = _display displayCtrl 104;
	_ChildControl  ctrlSetTooltip format ["Buy a vehicle for this squad for %1 €",_cost];
	_ChildControl = _display displayCtrl 105;
	_ChildControl  ctrlSetTooltip "Barefoot Infantry";
};

waitUntil {(!dialog) or (!isNil "vehQuery")};

if ((!dialog) and (isNil "vehQuery")) exitWith {};

vehQuery = nil;
_pos = position _road findEmptyPosition [1, 30, _vehicleType];
private _vehicle = _vehicleType createVehicle _pos;
[_vehicle, "FIA"] call AS_fnc_initVehicle;
_grupo addVehicle _vehicle;
_vehicle setVariable ["owner", _grupo, true];
[0, - _cost] remoteExec ["AS_fnc_changeFIAmoney",2];
leader _grupo assignAsDriver _vehicle;
{
	[_x] orderGetIn true;
	[_x] allowGetIn true
} forEach units _grupo;
hint "Vehicle purchased for the squad";
petros directSay "SentGenBaseAS_fnc_unlockVehicle";
