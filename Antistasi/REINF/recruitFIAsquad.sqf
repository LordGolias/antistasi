#include "../macros.hpp"

if (player != AS_commander) exitWith {hint "Only the commander has access to this function"};
if (!allowPlayerRecruit) exitWith {hint "Server is very loaded. \nWait one minute or change FPS settings in order to fulfill this request"};
if (!([player] call hasRadio)) exitWith {hint "You need a radio in your inventory to be able to give orders to other squads"};

private _enemiesClose = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance petros < 500) and (not(captive _x))) exitWith {_enemiesClose = true};
} forEach allUnits;

if (_enemiesClose) exitWith {Hint "You cannot Recruit Squads with enemies near your HQ"};

params ["_grouptype"];

private _isInfantry = false;
private _cost = 0;
private _costHR = 0;
private _hr = AS_P("hr");
private _resourcesFIA = AS_P("resourcesFIA");

if !(_grouptype in AS_allFIACustomSquadTypes) then {
	([_tipogrupo] call AS_fnc_getFIASquadCost) params ["_cost1", "_hr1"];
	_cost = _cost + _cost1;
	_costHR = _costHR + _hr1;
	_isInfantry = true;
}
else {
	_cost = 2*(AS_data_allCosts getVariable "Crew");
	_costHR = 2;
	_cost = _cost + ([[_grouptype] call AS_fnc_FIAmobileToPiece] call FIAvehiclePrice) + (["B_G_Van_01_transport_F"] call FIAvehiclePrice);

	if ((hayRHS) && (_grouptype == "Mobile AA")) then {
		_cost = 3*(AS_data_allCosts getVariable "Crew");
		_costHR = 3;
		_cost = _cost + ([vehTruckAA] call FIAvehiclePrice);
	};
};

private _exit = false;
if (_hr < _costHR) then {_exit = true;hint format ["You do not have enough HR for this request (%1 required)",_costHR]};
if (_resourcesFIA < _cost) then {_exit = true;hint format ["You do not have enough money for this request (%1 € required)",_cost]};
if (_exit) exitWith {};

[- _costHR, - _cost] remoteExec ["resourcesFIA",2];

private _pos = getMarkerPos "FIA_HQ";
private _tam = 10;
private ["_roads", "_road"];
while {true} do {
	_roads = _pos nearRoads _tam;
	if (count _roads < 1) then {_tam = _tam + 10};
	if (count _roads > 0) exitWith {_road = _roads select 0;};
};

private ["_grupo","_camion","_vehicle","_mortero","_morty"];

if (hayRHS) then {
	if (_isInfantry) then {
		_pos = [_pos, 30, random 360] call BIS_Fnc_relPos;
		_grupo = [_pos, side_blue, [_type] call AS_fnc_getFIASquadConfig] call BIS_Fnc_spawnGroup;
	}
	else {
		if (_grouptype == "Mobile AA") then {
			_pos = position _road findEmptyPosition [1,30,vehTruckAA];
			_vehicle=[_pos, 0, vehTruckAA, side_blue] call bis_fnc_spawnvehicle;
			_veh = _vehicle select 0;
			_vehCrew = _vehicle select 1;
			{deleteVehicle _x} forEach crew _veh;
			_grupo = _vehicle select 2;
			[_veh, "FIA"] call AS_fnc_initVehicle;
			_driv = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _pos, [],0, "NONE"];
			_driv moveInDriver _veh;
			driver _veh action ["engineOn", vehicle driver _veh];
			_gun = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _pos, [],0, "NONE"];
			_gun moveInGunner _veh;
			_com = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _pos, [],0, "NONE"];
			_com moveInCommander _veh;
		}
		else {
			_pos = position _road findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
			_vehicle=[_pos, 0,"B_G_Van_01_transport_F", side_blue] call bis_fnc_spawnvehicle;
			_camion = _vehicle select 0;
			_grupo = _vehicle select 2;
			_pos = _pos findEmptyPosition [1,30,"B_G_Mortar_01_F"];
			_attachPos = [0,-1.5,0.2];

			if (_grouptype == "Mobile AT") then {
				_mortero = "rhs_SPG9M_MSV" createVehicle _pos;
				_attachPos = [0,-2.4,-0.6];
			}
			else {
				diag_log "[AS] ERROR: RHS Mobile unit vehicle"
				//_mortero = _grouptype createVehicle _pos;
			};

			[_mortero, "FIA"] call AS_fnc_initVehicle;
			_morty = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _pos, [],0, "NONE"];
			_grupo setVariable ["staticAutoT",false,true];
			if (_grouptype == "Mobile Mortar") then {
				_morty moveInGunner _mortero;
				[_morty,_camion,_mortero] spawn mortyAI;
			}
			else {
				_mortero attachTo [_camion,_attachPos];
				_mortero setDir (getDir _camion + 180);
				_morty moveInGunner _mortero;
			};
		driver _camion action ["engineOn", vehicle driver _camion];
		[_camion, "FIA"] call AS_fnc_initVehicle;
		};
	};
}
else {

if (_isInfantry) then {
	_pos = [(getMarkerPos "FIA_HQ"), 30, random 360] call BIS_Fnc_relPos;
	_grupo = [_pos, side_blue, [_grouptype] call AS_fnc_getFIASquadConfig] call BIS_Fnc_spawnGroup;
}
else {
	_pos = position _road findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
    _veh = [_pos, 0,"B_G_Van_01_transport_F", side_blue] call bis_fnc_spawnvehicle;
	_camion = _veh select 0;
	_grupo = _veh select 2;
	_pieceName = [_grouptype] call AS_fnc_FIAmobileToPiece;
	_pos = _pos findEmptyPosition [1,30,_pieceName];
	_mortero = _pieceName createVehicle _pos;
	[_mortero, "FIA"] call AS_fnc_initVehicle;
	_morty = _grupo createUnit [["Crew"] call AS_fnc_getFIAUnitClass, _pos, [],0, "NONE"];
	_grupo setVariable ["staticAutoT",false,true];
	if (_grouptype == "Mobile Mortar") then {
		_morty moveInGunner _mortero;
		[_morty,_camion,_mortero] spawn mortyAI;
	}
	else {
		_mortero attachTo [_camion,[0,-1.5,0.2]];
		_mortero setDir (getDir _camion + 180);
		_morty moveInGunner _mortero;
	};
	driver _camion action ["engineOn", vehicle driver _camion];
	[_camion, "FIA"] call AS_fnc_initVehicle;
	};

};

// the name that appears in HC.
private _groupID = "";
if (_grouptype == "Infantry Squad") then {_groupID = "Squd-"};
if (_grouptype == "Infantry Team") then {_groupID = "Tm-"};
if (_grouptype == "AT Team") then {_groupID = "AT-"};
if (_grouptype == "Sniper Team") then {_groupID = "Snpr-"};
if (_grouptype == "Sentry Team") then {_groupID = "Stry-"};
if (_grouptype == "Mobile Mortar") then {_groupID = "Mort-"};
if (_grouptype == "Mobile AA") then {_groupID = "M.AA-"};
if (_grouptype == "Mobile AT") then {_groupID = "M.AT-"};
_grupo setGroupId [format ["%1%2",_groupID,{side (leader _x) == side_blue} count allGroups]];

{[_x] call AS_fnc_initUnitFIA} forEach units _grupo;
leader _grupo setBehaviour "SAFE";
AS_commander hcSetGroup [_grupo];
_grupo setVariable ["isHCgroup", true, true];
petros directSay "SentGenReinforcementsArrived";
hint format ["Group %1 at your command.\n\nGroups are managed from the High Command bar (Default: CTRL+SPACE)\n\nIf the group gets stuck, use the AI Control feature to make them start moving. Mounted Static teams tend to get stuck (solving this is WiP)\n\nTo assign a vehicle for this group, look at some vehicle, and use Vehicle Squad Mngmt option in Y menu", groupID _grupo];


if (!_isInfantry) exitWith {};

// Ask if vehicle is needed.
private _vehType = "";

if (_grouptype == "Infantry Squad") then
	{
	_vehType = "B_G_Van_01_transport_F";
	}
else
	{
	if ((_grouptype == "Sniper Team") or (_grouptype == "Sentry Team")) then
		{
		_vehType = "B_G_Quadbike_01_F";
		}
	else
		{
		_vehType = "B_G_Offroad_01_F";
		};
	};

_cost = [_vehType] call FIAvehiclePrice;
private ["_display","_childControl"];
if (_cost > AS_P("resourcesFIA")) exitWith {};

createDialog "veh_query";

sleep 1;
disableSerialization;

_display = findDisplay 100;

if (str (_display) != "no display") then {
	_ChildControl = _display displayCtrl 104;
	_ChildControl  ctrlSetTooltip format ["Buy a vehicle for this squad for %1 €",_cost];
	_ChildControl = _display displayCtrl 105;
	_ChildControl  ctrlSetTooltip "Barefoot Infantry";
};

waitUntil {(!dialog) or (!isNil "vehQuery")};

if ((!dialog) and (isNil "vehQuery")) exitWith {};

vehQuery = nil;
_pos = position _road findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
_veh = _vehType createVehicle _pos;
[_veh, "FIA"] call AS_fnc_initVehicle;
_grupo addVehicle _veh;
_veh setVariable ["owner",_grupo,true];
[0, - _cost] remoteExec ["resourcesFIA",2];
leader _grupo assignAsDriver _veh;
{[_x] orderGetIn true; [_x] allowGetIn true} forEach units _grupo;
hint "Vehicle Purchased";
petros directSay "SentGenBaseUnlockVehicle";
