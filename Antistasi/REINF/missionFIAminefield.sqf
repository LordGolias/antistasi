#include "../macros.hpp"
AS_SERVER_ONLY("missionFIAminefield.sqf");

private _vehType = (AS_FIArecruitment getVariable "land_vehicles") select 0;

private _cost = (2*(AS_data_allCosts getVariable "Explosives Specialist")) + ([_vehType] call FIAvehiclePrice);
[-2,-_cost] remoteExec ["resourcesFIA",2];

params ["_mineType", "_mapPosition", "_minesPositions"];

// remove mines from box
private _mag = _mineType call AS_fnc_mineMag;

([caja, true] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
_cargo_m = [_cargo_m, [[_mag], [count _minesPositions]], true] call AS_fnc_mergeCargoLists;  // true -> remove from _cargo_m
[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;

private _taskDescription = format ["An Engineer Team has been deployed at your High command. Once they reach the position, they will start to deploy %1 mines in the area. Cover them in the meantime.",count _minesPositions];

// marker for the task.
private _mrk = createMarker [format ["taskMinefield%1", random 1000], _mapPosition];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [100,100];
_mrk setMarkerColor "ColorRed";
_mrk setMarkerAlpha 0;

_tsk = ["Mines",[side_blue,civilian],[_taskDescription,"Minefield Deploy",_mrk],_mapPosition,"CREATED",5,true,true,"map"] call BIS_fnc_setTask;
misiones pushBack _tsk; publicVariable "misiones";

private _tam = 10;
private _roads = [];
while {count _roads == 0} do {
	_roads = getMarkerPos "FIA_HQ" nearRoads _tam;
	_tam = _tam + 10;
};

private _pos = position (_roads select 0) findEmptyPosition [1,30,_vehType];

private _truck = _vehType createVehicle _pos;
[_truck, "FIA"] call AS_fnc_initVehicle;
[_truck, [[],[]], [[_mag], [count _minesPositions]], [[],[]], [[],[]], true, true] call AS_fnc_populateBox;

private _group = createGroup side_blue;
_group addVehicle _truck;

_group createUnit [["Explosives Specialist"] call AS_fnc_getFIAUnitClass, getMarkerPos "FIA_HQ", [], 0, "NONE"];
_group createUnit [["Explosives Specialist"] call AS_fnc_getFIAUnitClass, getMarkerPos "FIA_HQ", [], 0, "NONE"];
_group setGroupId ["MineF"];

{[_x] spawn AS_fnc_initUnitFIA; [_x] orderGetIn true} forEach units _group;
leader _group setBehaviour "SAFE";
AS_commander hcSetGroup [_group];
_group setVariable ["isHCgroup", true, true];
_truck allowCrewInImmobile true;

private _arrivedSafely = false;
waitUntil {sleep 1;
	_arrivedSafely = (_truck distance _mapPosition < 100) and ({alive _x} count units _group > 0);
	(!alive _truck) or _arrivedSafely
};

if (_arrivedSafely) then {
	if (isPlayer leader _group) then {
		_owner = player getVariable ["owner",player];
		selectPlayer _owner;
		(leader _group) setVariable ["owner",player,true];
		{[_x] joinsilent group player} forEach units group player;
		group player selectLeader player;
		hint "";
	};
	[[petros,"hint","Engineers are deploying mines."],"commsMP"] call BIS_fnc_MP;
	[leader _group, _mrk, "SAFE","SPAWNED", "SHOWMARKER"] execVM "scripts\UPSMON.sqf";

	// simulates the group putting mines.
	sleep 20*(count _minesPositions);

	if ((alive _truck) and ({alive _x} count units _group > 0)) then {
		// crate minefield
		private _minesData = [];
		{
			_minesData pushBack [_mineType, _x, random 360];
		} forEach _minesPositions;
		[_mapPosition, "FIA", _minesData] call AS_fnc_addMinefield;

		_tsk = ["Mines",[side_blue,civilian],[_taskDescription,"Minefield Deploy",_mrk],_mapPosition,"SUCCEEDED",5,true,true,"Map"] call BIS_fnc_setTask;
		[2,_cost] remoteExec ["resourcesFIA",2];  // recover the costs
	}
	else {
		_tsk = ["Mines",[side_blue,civilian],[_taskDescription,"Minefield Deploy",_mrk],_mapPosition,"FAILED",5,true,true,"Map"] call BIS_fnc_setTask;
	};
} else {
	_tsk = ["Mines",[side_blue,civilian],[_taskDescription,"Minefield Deploy",_mrk],_mapPosition,"FAILED",5,true,true,"Map"] call BIS_fnc_setTask;
};

[0,_tsk] spawn borrarTask;
deleteMarker _mrk;

AS_commander hcRemoveGroup _group;
{
	if (alive _x) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
		deleteVehicle _x;
	};
} forEach units _group;
deleteGroup _group;
deleteVehicle _truck;
