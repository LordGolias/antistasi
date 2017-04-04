#include "../macros.hpp"
if (!isServer and hasInterface) exitWith {};

_tskTitleMun = localize "STR_tsk_CVY_Ammo";
_tskDescMun = localize "STR_tskDesc_CVY_Ammo";

_tskTitleArm = localize "STR_tsk_CVY_Armor";
_tskDescArm = localize "STR_tskDesc_CVY_Armor";

_tskTitlePrs = localize "STR_tsk_CVY_Pris";
_tskDescPrs = localize "STR_tskDesc_CVY_Pris";

_tskTitleMny = localize "STR_tsk_CVY_Money";
_tskDescMny = localize "STR_tskDesc_CVY_Money";

_tskTitleSup = localize "STR_tsk_CVY_Supply";
_tskDescSup = localize "STR_tskDesc_CVY_Supply";

_tskTitleHVT = localize "STR_tsk_CVY_HVT";
_tskDescHVT = localize "STR_tskDesc_CVY_HVT";

/*
parameters
0: destination of the convoy (marker)
1: origin of the convoy (marker)
2: source of the mission request ("civ", "mil", "auto", "city") -- OPTIONAL
3: specified types of convoys (array) -- OPTIONAL
*/
params ["_destino", "_base", ["_source", "auto"], "_convoyTypes"];
private ["_posbase","_posdestino","_soldados","_grupos","_vehiculos","_POWS","_tiempofin","_fechafin","_fechafinNum","_veh","_unit","_hvt", "_tsk", "_grpPOW"];

_posbase = getMarkerPos _base;
_posdestino = getMarkerPos _destino;

_soldados = [];
_grupos = [];
_vehiculos = [];
_POWS = [];

_posData = [];
_posRoad = [];
_dir = 0;

_tipoVehEsc = "";
_tipoVehObj = "";
_tipogrupo = "";
_tiposConvoy = [];
_posHQ = getMarkerPos "respawn_west";

_tiempofin = 120;
_fechafin = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempofin];
_fechafinNum = dateToNumber _fechafin;

if ((_destino in bases) or (_destino in aeropuertos)) then {_tiposConvoy = ["Municion","Armor","Prisoners","HVT"];};
if (_destino in ciudades) then
	{
	if (_destino in mrkAAF) then {_tiposConvoy = ["Money","Supplies","HVT"]} else {_tiposConvoy = ["Supplies"]}
	};

if (_source == "civ") then {
	if (_destino in bases) then {
		_tiposConvoy = ["Prisoners","HVT"];
	}
	else {
		_tiposConvoy = ["Money","Supplies"];
	};

	_val = server getVariable "civActive";
	server setVariable ["civActive", _val + 1, true];
};
if (_source == "mil") then {
	_tiposConvoy = ["Municion","Armor","HVT"];
	_val = server getVariable "milActive";
	server setVariable ["milActive", _val + 1, true];
};

if (_source == "auto") then {
	_tiposConvoy = ["HVT"];
};

// if an array of specific types is supplied, use it
if (count _this > 3) then {_tiposConvoy = _convoyTypes};
_tipoConvoy = _tiposConvoy call BIS_Fnc_selectRandom;

if (_source == "city") then {
	_tiposConvoy = ["Supplies", "Money"];
	_weights = [0.8, 0.1];
	_tipoConvoy = [_tiposConvoy, _weights] call BIS_fnc_selectRandomWeighted;
};

// add a delay, depending on the number of places you control
_tiempolim = (round (5 - (count mrkFIA)/10)) + (round random 10);

_fechalim = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _tiempolim];
_fechalimnum = dateToNumber _fechalim;

_nombredest = [_destino] call localizar;
_nombreOrig = [_base] call localizar;
[_base,30] execVM "addTimeForIdle.sqf";
if (_tipoConvoy == "Municion") then
	{
	_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescMun,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleMun, A3_STR_INDEP],_destino],_posdestino,"CREATED",5,true,true,"rearm"] call BIS_fnc_setTask;
	_tipoVehObj = vehAmmo;
	};

if (_tipoConvoy == "Armor") then
	{
	_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescArm,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleArm, A3_STR_INDEP],_destino],_posdestino,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	_armor = "";
	{if (_x in vehTank) exitWith {_armor = _x};} forEach vehAAFAT;
	if (_armor != "") then {_tipoVehObj = selectRandom vehTank;} else { _tipoVehObj = selectRandom vehIFV;};
	};

if (_tipoConvoy == "Prisoners") then
	{
	_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescPrs,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitlePrs, A3_STR_INDEP],_destino],_posdestino,"CREATED",5,true,true,"run"] call BIS_fnc_setTask;
	_tipoVehObj = enemyMotorpoolDef;
	};

if (_tipoConvoy == "Money") then
	{
	_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescMny,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleMny, A3_STR_INDEP],_destino],_posdestino,"CREATED",5,true,true,"move"] call BIS_fnc_setTask;
	_tipoVehObj = "C_Van_01_box_F";
	};

if (_tipoConvoy == "Supplies") then
	{
	_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescSup,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleSup, A3_STR_INDEP],_destino],_posdestino,"CREATED",5,true,true,"heal"] call BIS_fnc_setTask;
	_tipoVehObj = "C_Van_01_box_F";
	};

if (_tipoConvoy == "HVT") then {
	_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescHVT,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleHVT, A3_STR_INDEP],_destino],_posdestino,"CREATED",5,true,true,"Destroy"] call BIS_fnc_setTask;
	_tipoVehObj = selectRandom standardMRAP;
};

misiones pushBack _tsk; publicVariable "misiones";

_grupo = createGroup side_green;
_grupos = _grupos + [_grupo];

_posData = [_posbase, _posdestino] call fnc_findSpawnSpots;
_posRoad = _posData select 0;
_dir = _posData select 1;

// initialisation of vehicles
_initVehs = {
	params ["_specs"];
	_specs = _specs + [_dir, _grupo, _vehiculos, _grupos, _soldados, true];
	_specs call fnc_initialiseVehicle;
};

sleep (_tiempolim * 60);

private _vehData = [[_posRoad, selectRandom vehLead]] call _initVehs;
_vehiculos = _vehData select 0;
_grupos = _vehData select 1;
_soldados = _vehData select 2;

_wp0 = _grupo addWaypoint [_posdestino, 0];
_wp0 setWaypointType "MOVE";
_wp0 setWaypointBehaviour "SAFE";
_wp0 setWaypointSpeed "LIMITED";
_wp0 setWaypointFormation "COLUMN";

_cuenta = 1;
if ([_destino] call isFrontline) then {_cuenta = (round random 2) + 1};

_pV = 0;

_tempMP = [];
if (hayRHS) then {
	for "_j" from 1 to 4 do {
		if (count (vehAAFAT - vehIFV) < count vehAAFAT) then {_tempMP pushBack selectRandom (vehIFV)};
	};
}
else {
	_tempMP = vehIFV;
};

_vehAAFAT = vehAAFAT;
if (count (_vehAAFAT - vehIFV) < count _vehAAFAT) then {_vehAAFAT = _vehAAFAT - vehIFV; _vehAAFAT = _vehAAFAT + _tempMP};

if (_tipoConvoy == "HVT") then {
	sleep 20;
	_pv = round random 1;

	private _vehData = [[_posRoad, _tipoVehObj]] call _initVehs;
	_vehiculos = _vehData select 0;
	_grupos = _vehData select 1;
	_soldados = _vehData select 2;

	_vehObj2 = (_vehData select 3) select 0;
	[_vehObj2,"AAF Convoy Objective"] spawn inmuneConvoy;

	if (_pv == 1) then {
		_hvt = ([_posbase, 0, sol_OFF, _grupo] call bis_fnc_spawnvehicle) select 0;
		[_hvt] spawn AS_fnc_initUnitOPFOR;
		_hvt assignAsCargo _vehObj2;
		_hvt moveInCargo _vehObj2;
		_grupos = _grupos + [_grupo];
		_soldados pushBack _hvt;
		_vehObj2 lock 2;
		[_vehObj2, true] remoteExec ["fnc_lockVehicle", [0,-2] select isDedicated,true];
	};
}
else {
	for "_i" from 1 to _cuenta do {
		sleep 20;
		if (count _vehAAFAT > 1) then
			{
			_vehAAFAT = _vehAAFAT - [enemyMotorpoolDef];
			_tipoVehEsc = _vehAAFAT call BIS_fnc_selectRandom;
			}
		else
			{
			_tipoVehEsc = enemyMotorpoolDef;
			};

		_b = bases + aeropuertos;
		_c = mrkFIA arrayIntersect _b;
		_t = _vehAAFAT arrayIntersect vehTank;
		if ((count _c > 2) && (count _t > 0) && (_i == _cuenta)) then {_tipoVehEsc = selectRandom vehTank};

		private _vehData = [[_posRoad, _tipoVehEsc]] call _initVehs;
		_vehiculos = _vehData select 0;
		_grupos = _vehData select 1;
		_soldados = _vehData select 2;

		_veh = (_vehData select 3) select 0;
		[_veh,"AAF Convoy Escort"] spawn inmuneConvoy;

		if !(_tipoVehEsc in vehTank) then
			{
			if (_tipoVehEsc in vehIFV) then {
				_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
			}
			else {
				_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
			};
			_grupoEsc = [_posbase, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
			{[_x] spawn AS_fnc_initUnitOPFOR;_x assignAsCargo _veh;_x moveInCargo _veh; _soldados = _soldados + [_x];[_x] join _grupo} forEach units _grupoEsc;
			deleteGroup _grupoEsc;
			if (_tipoVehEsc != enemyMotorpoolDef) then
				{
				[_veh] spawn smokeCover;
				};
			};
	};
};

sleep 20;

_vehObj = _tipoVehObj createVehicle _posRoad;
_vehObj setDir _dir;
_vehObj addEventHandler ["HandleDamage", {
	if (((_this select 1) find "wheel" != -1) && !([distanciaSPWN,1,_vehObj,"BLUFORSpawn"] call distanceUnits)) then {
		0;
	} else {
		(_this select 2);
	};
}];

_driver = ([_posbase, 0, sol_DRV, _grupo] call bis_fnc_spawnvehicle) select 0;
_driver assignAsDriver _vehObj;
_driver moveInDriver _vehObj;
[_driver] spawn AS_fnc_initUnitOPFOR;
_soldados pushBackUnique _driver;
_driver addEventHandler ["killed", {
	{
		_x action ["EJECT", _vehObj];
		unassignVehicle _x;
	} forEach crew _vehObj;
}];

{
	_x removeWeaponGlobal (primaryWeapon _x);
} forEach crew _vehObj;

if ((_tipoConvoy == "HVT") && (_pv == 0)) then {
	_hvt = ([_posbase, 0, sol_OFF, _grupo] call bis_fnc_spawnvehicle) select 0;
	[_hvt] spawn AS_fnc_initUnitOPFOR;
	_hvt assignAsCargo _vehObj;
	_hvt moveInCargo _vehObj;
	_grupos = _grupos + [_grupo];
	_soldados pushBack _hvt;
	_vehObj lock 2;
	[_vehObj, true] remoteExec ["fnc_lockVehicle", [0,-2] select isDedicated,true];
};

_vehiculos = _vehiculos + [_vehObj];

if (_tipoConvoy == "Armor") then {_vehObj lock 3};
if (_tipoConvoy == "Prisoners") then
	{
	_grpPOW = createGroup side_blue;
	_grupos = _grupos + [_grpPOW];
	for "_i" from 1 to (1+ round (random 11)) do
		{
		_unit = _grpPOW createUnit ["b_g_survivor_F", _posbase, [], 0, "NONE"];
		_unit setCaptive true;
		_unit disableAI "MOVE";
		_unit setBehaviour "CARELESS";
		_unit allowFleeing 0;
		_unit assignAsCargo _vehObj;
		_unit moveInCargo [_vehObj, _i + 3];
		removeAllWeapons _unit;
		removeAllAssignedItems _unit;
		[[_unit,"refugiado"],"flagaction"] call BIS_fnc_MP;
		sleep 1;
		_POWS = _POWS + [_unit];
		};
	};
if ((_tipoConvoy == "Money") or (_tipoConvoy == "Supplies")) then {reportedVehs pushBack _vehObj; publicVariable "reportedVehs"};

sleep 20;

if (count vehAAFAT > 1) then
	{
	_vehAAFAT = vehAAFAT - [enemyMotorpoolDef];
	_tipoVehEsc = _vehAAFAT call BIS_fnc_selectRandom;
	}
else
	{
	_tipoVehEsc = enemyMotorpoolDef;
	};

private _vehData = [[_posRoad, _tipoVehEsc]] call _initVehs;
_vehiculos = _vehData select 0;
_grupos = _vehData select 1;
_soldados = _vehData select 2;

_veh = (_vehData select 3) select 0;
[_veh,"AAF Convoy Escort"] spawn inmuneConvoy;


if !(_tipoVehEsc in vehTank) then
	{
	if (_tipoVehEsc in vehIFV) then {
		_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
	}
	else {
		_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
	};
	_grupoEsc = [_posbase, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
	{[_x] spawn AS_fnc_initUnitOPFOR;_x assignAsCargo _veh;_x moveInCargo _veh; _soldados = _soldados + [_x];[_x] join _grupo} forEach units _grupoEsc;
	deleteGroup _grupoEsc;
	if (_tipoVehEsc != enemyMotorpoolDef) then
		{
		[_veh] spawn smokeCover;
		};
	};

if (_tipoConvoy == "HVT") then {
	waitUntil {sleep 1; (dateToNumber date > _fechafinNum) or (_hvt distance _posdestino < 100) or (not alive _hvt)};
	if ((_hvt distance _posdestino < 100) or (dateToNumber date > _fechafinNum)) then
		{
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescHVT,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleHVT, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
		[-1200] remoteExec ["timingCA",2];
		[-10,AS_commander] call playerScoreAdd;
		}
	else
		{
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescHVT,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleHVT, A3_STR_INDEP],_destino],_posdestino,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
		[10,0] remoteExec ["prestige",2];
		[0,5,_posdestino] remoteExec ["citySupportChange",2];
		[1800] remoteExec ["timingCA",2];
		{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_hvt,"BLUFORSpawn"] call distanceUnits);
		[5,AS_commander] call playerScoreAdd;
		[position _hvt] spawn patrolCA;
		// BE module
		if (hayBE) then {
			["mis"] remoteExec ["fnc_BE_XP", 2];
		};
		// BE module
		};
};


if (_tipoConvoy == "Municion") then
	{
	waitUntil {sleep 1; (dateToNumber date > _fechafinNum) or (_vehObj distance _posdestino < 100) or (not alive _vehObj) or (driver _vehObj getVariable ["BLUFORSpawn",false])};
	if ((_vehObj distance _posdestino < 100) or (dateToNumber date >_fechafinNum)) then
		{
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescMun,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleMun, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"rearm"] call BIS_fnc_setTask;
		[-1200] remoteExec ["timingCA",2];
		[-10,AS_commander] call playerScoreAdd;
		[_vehObj] call emptyCrate;
		}
	else
		{
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescMun,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleMun, A3_STR_INDEP],_destino],_posdestino,"SUCCEEDED",5,true,true,"rearm"] call BIS_fnc_setTask;
		[0,300] remoteExec ["resourcesFIA",2];
		[1800] remoteExec ["timingCA",2];
		{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_vehObj,"BLUFORSpawn"] call distanceUnits);
		[5,AS_commander] call playerScoreAdd;
		[position _vehObj] spawn patrolCA;
		// BE module
		if (hayBE) then {
			["mis"] remoteExec ["fnc_BE_XP", 2];
		};
		// BE module
		};
	};

if (_tipoConvoy == "Armor") then
	{
	waitUntil {sleep 1; (dateToNumber date > _fechafinNum) or (_vehObj distance _posdestino < 100) or (not alive _vehObj) or (driver _vehObj getVariable ["BLUFORSpawn",false])};
	if ((_vehObj distance _posdestino < 100) or (dateToNumber date > _fechafinNum)) then
		{
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescArm,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleArm, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"Destroy"] call BIS_fnc_setTask;
		tanksAAFcurrent = tanksAAFcurrent + 1;
		server setVariable [_destino,dateToNumber date,true];
		[-1200] remoteExec ["timingCA",2];
		[-10,AS_commander] call playerScoreAdd;
		}
	else
		{
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescArm,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleArm, A3_STR_INDEP],_destino],_posdestino,"SUCCEEDED",5,true,true,"Destroy"] call BIS_fnc_setTask;
		[5,0] remoteExec ["prestige",2];
		[0,5,_posdestino] remoteExec ["citySupportChange",2];
		[2700] remoteExec ["timingCA",2];
		{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_vehObj,"BLUFORSpawn"] call distanceUnits);
		[5,AS_commander] call playerScoreAdd;
		[position _vehObj] spawn patrolCA;
		// BE module
		if (hayBE) then {
			["mis"] remoteExec ["fnc_BE_XP", 2];
		};
		// BE module
		};
	};

if (_tipoConvoy == "Prisoners") then
	{
	waitUntil {sleep 1; (dateToNumber date > _fechafinNum) or (_vehObj distance _posdestino < 100) or (not alive driver _vehObj) or (driver _vehObj getVariable ["BLUFORSpawn",false]) or ({alive _x} count _POWs == 0)};
	if ((_vehObj distance _posdestino < 100) or ({alive _x} count _POWs == 0) or (dateToNumber date > _fechafinNum)) then
		{
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescPrs,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitlePrs, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"run"] call BIS_fnc_setTask;
		{_x setCaptive false} forEach _POWs;
		_cuenta = 2 * (count _POWs);
		[_cuenta,0] remoteExec ["prestige",2];
		[-10,AS_commander] call playerScoreAdd;
		};
	if ((not alive driver _vehObj) or (driver _vehObj getVariable ["BLUFORSpawn",false])) then
		{
		[position _vehObj] spawn patrolCA;
		{_x setCaptive false; _x enableAI "MOVE"; [_x] orderGetin false;} forEach _POWs;
		waitUntil {sleep 2; ({alive _x} count _POWs == 0) or ({(alive _x) and (_x distance _posHQ < 50)} count _POWs > 0) or (dateToNumber date > _fechafinNum)};
		if (({alive _x} count _POWs == 0) or (dateToNumber date > _fechafinNum)) then
			{
			_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescPrs,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitlePrs, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"run"] call BIS_fnc_setTask;
			_cuenta = 2 * (count _POWs);
			[_cuenta,0] remoteExec ["prestige",2];
			//[0,- _cuenta, _posdestino] remoteExec ["citySupportChange",2];
			[-10,AS_commander] call playerScoreAdd;
			}
		else
			{
			_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescPrs,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitlePrs, A3_STR_INDEP],_destino],_posdestino,"SUCCEEDED",5,true,true,"run"] call BIS_fnc_setTask;
			_cuenta = {(alive _x) and (_x distance _posHQ < 150)} count _POWs;
			_hr = _cuenta;
			_resourcesFIA = 300 * _cuenta;
			[_hr,_resourcesFIA] remoteExec ["resourcesFIA",2];
			[0,10,_posbase] remoteExec ["citySupportChange",2];
			[2*_cuenta,0] remoteExec ["prestige",2];
			{[_x] join _grppow; [_x] orderGetin false} forEach _POWs;
			{[_cuenta,_x] call playerScoreAdd} forEach (allPlayers - hcArray);
			[round (_cuenta/2),AS_commander] call playerScoreAdd;
			// BE module
			if (hayBE) then {
				["mis"] remoteExec ["fnc_BE_XP", 2];
			};
			// BE module
			};
		};
	};

if (_tipoConvoy == "Money") then
	{
	waitUntil {sleep 1; (dateToNumber date > _fechafinNum) or (_vehObj distance _posdestino < 100) or (not alive _vehObj) or (driver _vehObj getVariable ["BLUFORSpawn",false])};
	if ((dateToNumber date > _fechafinNum) or (_vehObj distance _posdestino < 100) or (not alive _vehObj)) then
		{
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescMny,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleMny, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"move"] call BIS_fnc_setTask;
		if ((dateToNumber date > _fechafinNum) or (_vehObj distance _posdestino < 100)) then
			{
			_resourcesAAF = AS_P("resourcesAAF");
			_resourcesAAF = _resourcesAAF + 5000;
			AS_Pset("resourcesAAF",_resourcesAAF);
			[-1200] remoteExec ["timingCA",2];
			[-10,AS_commander] call playerScoreAdd;
			}
		else
			{
			[position _vehObj] spawn patrolCA;
			_resourcesAAF = AS_P("resourcesAAF");
			_resourcesAAF = _resourcesAAF - 5000;
			AS_Pset("resourcesAAF",_resourcesAAF);
			[2700] remoteExec ["timingCA",2];
			};
		};
	if (driver _vehObj getVariable ["BLUFORSpawn",false]) then
		{
		[position _vehObj] spawn patrolCA;
		waitUntil {sleep 2; (_vehObj distance _posHQ < 50) or (not alive _vehObj) or (dateToNumber date > _fechafinNum)};
		if ((not alive _vehObj) or (dateToNumber date > _fechafinNum)) then
			{
			_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescMny,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleMny, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"move"] call BIS_fnc_setTask;
			_resourcesAAF = AS_P("resourcesAAF");
			_resourcesAAF = _resourcesAAF - 5000;
			AS_Pset("resourcesAAF",_resourcesAAF);
			[1800] remoteExec ["timingCA",2];
			};
		if (_vehObj distance _posHQ < 50) then
			{
			_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescMny,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleMny, A3_STR_INDEP],_destino],_posdestino,"SUCCEEDED",5,true,true,"move"] call BIS_fnc_setTask;
			_resourcesAAF = AS_P("resourcesAAF");
			_resourcesAAF = _resourcesAAF - 5000;
			AS_Pset("resourcesAAF",_resourcesAAF);
			[10,-20,_destino] remoteExec ["citySupportChange",2];
			[-20,0] remoteExec ["prestige",2];
			[0,5000] remoteExec ["resourcesFIA",2];
			[-1200] remoteExec ["timingCA",2];
			{if (_x distance _vehObj < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
			[5,AS_commander] call playerScoreAdd;
			// BE module
			if (hayBE) then {
				["mis"] remoteExec ["fnc_BE_XP", 2];
			};
			// BE module
			waitUntil {sleep 1; speed _vehObj < 1};
			[_vehObj] call vaciar;
			deleteVehicle _vehObj;
			};
		};
	reportedVehs = reportedVehs - [_vehObj];
	publicVariable "reportedVehs";
	};

if (_tipoConvoy == "Supplies") then
	{
	waitUntil {sleep 1; (dateToNumber date > _fechafinNum) or (_vehObj distance _posdestino < 100) or (not alive _vehObj) or (driver _vehObj getVariable ["BLUFORSpawn",false])};
	if (not alive _vehObj) then
		{
		[position _vehObj] spawn patrolCA;
		_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescSup,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleSup, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"heal"] call BIS_fnc_setTask;
		[-5,0] remoteExec ["prestige",2];
		[-10,AS_commander] call playerScoreAdd;
		};
	if ((dateToNumber date > _fechafinNum) or (_vehObj distance _posdestino < 100) or (driver _vehObj getVariable ["BLUFORSpawn",false])) then
		{
		if (driver _vehObj getVariable ["BLUFORSpawn",false]) then
			{
			[position _vehObj] spawn patrolCA;
			waitUntil {sleep 1; (_vehObj distance _posdestino < 100) or (not alive _vehObj) or (dateToNumber date > _fechafinNum)};
			if (_vehObj distance _posdestino < 100) then
				{
				_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescSup,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleSup, A3_STR_INDEP],_destino],_posdestino,"SUCCEEDED",5,true,true,"heal"] call BIS_fnc_setTask;
				[5,0] remoteExec ["prestige",2];
				[0,15,_destino] remoteExec ["citySupportChange",2];
				{if (_x distance _vehObj < 500) then {[10,_x] call playerScoreAdd}} forEach (allPlayers - hcArray);
				[5,AS_commander] call playerScoreAdd;
				// BE module
				if (hayBE) then {
					["mis"] remoteExec ["fnc_BE_XP", 2];
				};
				// BE module
				}
			else
				{
				_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescSup,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleSup, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"heal"] call BIS_fnc_setTask;
				[5,-10,_destino] remoteExec ["citySupportChange",2];
				[-5,0] remoteExec ["prestige",2];
				[-10,AS_commander] call playerScoreAdd;
				};
			}
		else
			{
			_tsk = ["CONVOY",[side_blue,civilian],[format [_tskDescSup,_nombreorig,numberToDate [2035,_fechalimnum] select 3,numberToDate [2035,_fechalimnum] select 4,_nombredest],format [_tskTitleSup, A3_STR_INDEP],_destino],_posdestino,"FAILED",5,true,true,"heal"] call BIS_fnc_setTask;
			[2,0] remoteExec ["prestige",2];
			[15,0,_destino] remoteExec ["citySupportChange",2];
			[-10,AS_commander] call playerScoreAdd;
			};
		};
	reportedVehs = reportedVehs - [_vehObj];
	publicVariable "reportedVehs";
	};

_wp0 = _grupo addWaypoint [_posbase, 0];
_wp0 setWaypointType "MOVE";
_wp0 setWaypointBehaviour "SAFE";
_wp0 setWaypointSpeed "LIMITED";
_wp0 setWaypointFormation "COLUMN";

if (_tipoConvoy == "Prisoners") then
	{
	{
	deleteVehicle _x;
	} forEach _POWs;
	};

if (_source == "mil") then {
	_val = server getVariable "milActive";
	server setVariable ["milActive", _val - 1, true];
};

if (_source == "civ") then {
	_val = server getVariable "civActive";
	server setVariable ["civActive", _val - 1, true];
};

[600,_tsk] spawn borrarTask;
{
waitUntil {sleep 1; (!([distanciaSPWN,1,_x,"BLUFORSpawn"] call distanceUnits))};
deleteVehicle _x;
} forEach _soldados;
{
if (!([distanciaSPWN,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x}
} forEach _vehiculos;

{deleteGroup _x} forEach _grupos;