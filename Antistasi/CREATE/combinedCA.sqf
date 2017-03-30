if (!isServer and hasInterface) exitWith {};

private ["_posorigen","_tipogrupo","_nombreorig","_markTsk","_wp1","_soldados","_landpos","_pad","_vehiculos","_wp0","_wp3","_wp4","_wp2",
		"_grupo","_grupos","_tipoVeh","_vehicle","_heli","_heliCrew","_grupoheli","_pilotos","_rnd","_resourcesAAF","_nVeh",
		"_tam","_roads","_Vwp1","_road","_veh","_vehCrew","_grupoVeh","_Vwp0","_size","_Hwp0","_grupo1","_uav","_grupouav","_uwp0",
		"_tsk","_vehiculo","_soldado","_piloto","_mrkdestino","_posdestino","_prestigeCSAT","_base","_aeropuerto","_nombredest",
		"_tiempo","_solMax","_coste","_tipo","_threatEvalAir","_threatEvalLand","_pos","_timeOut","_plane","_planesAAF"];
_mrkdestino = _this select 0;

//forcedSpawn = forcedSpawn + [_mrkDestino]; publicVariable "forcedSpawn";

_posdestino = getMarkerPos _mrkDestino;

_grupos = [];
_soldados = [];
_pilotos = [];
_vehiculos = [];

_prestigeCSAT = server getVariable "prestigeCSAT";
//[-8100] remoteExec ["resourcesAAF",2];

_base = "";
_base = [_mrkdestino] call findBasesForCA;
_aeropuerto = "";
_aeropuerto = [_mrkdestino] call findAirportsForCA;

//if (_mrkdestino == "puesto_13") then {_base = ""};

if ((_base=="") and (_aeropuerto=="")) exitWith {};

_CSAT = false;
if ((random 100 < _prestigeCSAT) and (_prestigeCSAT > 19) && !(server getVariable "blockCSAT")) then
	{
	_CSAT = true;
	};

if ((_aeropuerto != "") or _CSAT) then {_threatEvalAir = [_mrkDestino] call AAthreatEval};

if (_base != "") then {_threatEvalLand = [_mrkDestino] call landThreatEval};

_nombredest = [_mrkDestino] call localizar;
_nombreorig = [_aeropuerto] call localizar;
_markTsk = _aeropuerto;

if (_base !="") then
	{
	_nombreorig = [_base] call localizar;
	_markTsk = _base;
	};

_tsk = ["AtaqueAAF",[side_blue,civilian],[format ["AAF Is attacking from the %1. Intercept them or we may loose a sector",_nombreorig],"AAF Attack",_markTsk],getMarkerPos _markTsk,"CREATED",10,true,true,"Defend"] call BIS_fnc_setTask;
misiones pushbackUnique "AtaqueAAF"; publicVariable "misiones";
_tiempo = time + 3600;

if (_CSAT) then
	{
	_resourcesAAF = server getVariable "resourcesAAF";
	if (_resourcesAAF > 20000) then
		{
		server setVariable ["resourcesAAF",_resourcesAAF - 20000,true];
		[5,0] remoteExec ["prestige",2];
		}
	else
		{
		[5,-20] remoteExec ["prestige",2]
		};
	_posorigen = getMarkerPos "spawnCSAT";
	_posorigen set [2,300];
	_cuenta = 3;
	if ((_base == "") or (_aeropuerto == "")) then {_cuenta = 6};
	for "_i" from 1 to _cuenta do
		{
		_tipoVeh = "";
		if (_i == _cuenta) then
			{
			_tipoVeh = selectRandom opHeliTrans;
			}
		else
			{
			_tipoVeh = selectRandom opAir;
			};
		_timeOut = 0;
		_pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
		while {_timeOut < 60} do
			{
			if (count _pos > 0) exitWith {};
			_timeOut = _timeOut + 1;
			_pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
			sleep 1;
			};
		if (count _pos == 0) then {_pos = _posorigen};
		_vehicle=[_posorigen, 0, _tipoVeh, side_red] call bis_fnc_spawnvehicle;
		_heli = _vehicle select 0;
		_heliCrew = _vehicle select 1;
		_grupoheli = _vehicle select 2;
		_pilotos = _pilotos + _heliCrew;
		_grupos = _grupos + [_grupoheli];
		_vehiculos = _vehiculos + [_heli];
		[_heli] spawn CSATVEHinit;
		if (not(_tipoVeh in opHeliTrans)) then
			{
			{[_x] spawn CSATinit} forEach _heliCrew;
			_wp1 = _grupoheli addWaypoint [_posdestino, 0];
			_wp1 setWaypointType "SAD";
			[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
			}
		else
			{
			{_x setBehaviour "CARELESS";} forEach units _grupoheli;
			_tipogrupo = [opGroup_Squad, side_red] call fnc_pickGroup;
			_grupo = [_posorigen, side_red, _tipogrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados = _soldados + [_x]; [_x] spawn CSATinit} forEach units _grupo;
			//[_mrkDestino,_grupo] spawn attackDrill;
			_grupos = _grupos + [_grupo];
			[_heli,"CSAT Air Transport"] spawn inmuneConvoy;
			if ((_mrkdestino in bases) or (_mrkdestino in aeropuertos) or (random 10 < _threatEvalAir)) then
				{
				[_heli,_grupo,_mrkdestino,_threatEvalAir] spawn airdrop;
				}
			else
				{
				if ((random 100 < 50) or (_tipoVeh == opHeliDismount)) then
					{
					{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
					_landpos = [];
					_landpos = [_posdestino, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
					_landPos set [2, 0];
					_pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
					_vehiculos = _vehiculos + [_pad];
					
					[_grupoheli, _posorigen, _landpos, _mrkdestino, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;
					
					/* _wp0 = _grupoheli addWaypoint [_landpos, 0];
					_wp0 setWaypointType "TR UNLOAD";
					_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT';[vehicle this] call smokeCoverAuto"];
					[_grupoheli,0] setWaypointBehaviour "CARELESS";
					_wp3 = _grupo addWaypoint [_landpos, 0];
					_wp3 setWaypointType "GETOUT";
					_wp0 synchronizeWaypoint [_wp3];
					_wp4 = _grupo addWaypoint [_posdestino, 1];
					_wp4 setWaypointType "SAD";
					_wp2 = _grupoheli addWaypoint [_posorigen, 1];
					_wp2 setWaypointType "MOVE";
					_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"]; 
					[_grupoheli,1] setWaypointBehaviour "AWARE"; */
					}
				else
					{
					[_grupoheli, _posorigen, _posdestino, _mrkdestino, _grupo, 25*60] call fnc_QRF_fastrope;
					//[_heli,_grupo,_posdestino,_posorigen,_grupoheli] spawn fastropeCSAT;
					};
				};
			};
		sleep 15;
		};

	_tsk = ["AtaqueAAF",[side_blue,civilian],[format ["AAF and CSAT are attacking %2 from the %1. Intercept them or we may loose a sector",_nombreorig,_nombredest],"AAF Attack",_mrkDestino],getMarkerPos _mrkDestino,"CREATED",10,true,true,"Defend"] call BIS_fnc_setTask;
	[["TaskSucceeded", ["", format ["%1 under fire",_nombredest]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	//bombardeo aereo!!!
	[_mrkDestino] spawn
		{
		private ["_mrkDestino"];
		_mrkDestino = _this select 0;
		for "_i" from 0 to round (random 2) do
			{
			[_mrkdestino, selectRandom opCASFW] spawn airstrike;
			sleep 30;
			};
		if ((_mrkDestino in bases) or (_mrkDestino in aeropuertos)) then
			{
			//Ataque de artillería
			[_mrkdestino] spawn artilleria;
			};
		};
	{if ((surfaceIsWater position _x) and (vehicle _x == _x)) then {_x setDamage 1}} forEach _soldados;
	};


if (_base != "") then
	{
	[_base,60] execVM "addTimeForIdle.sqf";
	_posorigen = getMarkerPos _base;
	_size = [_base] call sizeMarker;
	_nVeh = round (_size/30);
	if (_nVeh < 1) then {_nVeh = 1};
	_roads = [];
	_tam = _size;
	while {true} do
		{
		_roads = _posorigen nearRoads _tam;
		if (count _roads < _nveh) then {_tam = _tam + 50};
		if (count _roads >= _nveh) exitWith {};
		};

	_tempMP = [];
	if (hayRHS) then {
		for "_j" from 1 to 4 do {
			if (count (vehAAFAT - vehIFV) < count vehAAFAT) then {_tempMP pushBack selectRandom (vehIFV)};
		};
	}
	else {
		_tempMP = vehIFV;
	};

	for "_i" from 1 to _nveh do
		{
		_tipoVeh = "";
		if (count vehAAFAT > 1) then
			{
			_vehAAFAT =+ vehAAFAT;
			// experimental
			_vehAAFAT = _vehAAFAT - vehIFV;
			_vehAAFAT = _vehAAFAT + _tempMP + vehTrucks;

			if (_i == _nveh) then
				{
					_b = bases + aeropuertos;
					_c = mrkFIA arrayIntersect _b;
					if (count _c < 1) then {
						_vehAAFAT = vehAAFAT - vehTank - _tempMP;
					}
					else {
						if (count _c < 3) then {
							_vehAAFAT = vehAAFAT - vehTank;
						}
						else {
							_vehAAFAT = vehTank + _tempMP;
						};
					};
				}
			else
				{
				if (_threatEvalLand > 3) then {_vehAAFAT = _vehAAFAT - [enemyMotorpoolDef] - vehTrucks};
				if ((_threatEvalLand > 5) && (count (vehAAFAT - vehIFV - vehTank) < count vehAAFAT)) then {_vehAAFAT = _vehAAFAT - vehAPC - [enemyMotorpoolDef] - vehTrucks};
				// /experimental
				};
			_tipoVeh = _vehAAFAT call BIS_fnc_selectRandom;
			}
		else
			{
			_tipoVeh = enemyMotorpoolDef;
			};
		_road = _roads select (_i -1);
		_timeOut = 0;
		_pos = (position _road) findEmptyPosition [0,100,_tipoVeh];
		while {_timeOut < 60} do
			{
			if (count _pos > 0) exitWith {};
			_timeOut = _timeOut + 1;
			_pos = (position _road) findEmptyPosition [0,100,_tipoVeh];
			sleep 1;
			};
		if (count _pos == 0) then {_pos = (position _road)};
		if (isNil "_tipoVeh") then {_tipoVeh = enemyMotorpoolDef};
		_vehicle=[_pos, random 360,_tipoVeh, side_green] call bis_fnc_spawnvehicle;
		_veh = _vehicle select 0;
		_vehCrew = _vehicle select 1;
		{[_x] spawn AS_fnc_initUnitOPFOR} forEach _vehCrew;
		[_veh] spawn genVEHinit;
		_grupoVeh = _vehicle select 2;
		_soldados = _soldados + _vehCrew;
		_grupos = _grupos + [_grupoVeh];
		_vehiculos = _vehiculos + [_veh];
		_landPos = [];
		_landPos = [_posdestino,position _road,_threatEvalLand] call findSafeRoadToUnload;
		if !(_tipoVeh in vehTank) then {
			if (_tipoVeh in vehIFV) then {
				_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
			} else {
				_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
			};
			_grupo = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;

			{[_x] spawn AS_fnc_initUnitOPFOR;_x assignAsCargo _veh;_x moveInCargo _veh; _soldados pushBack _x;} forEach units _grupo;

			_crewCount = [_tipoVeh,false] call BIS_fnc_crewCount;
			_nrSeats = [_tipoVeh,true] call BIS_fnc_crewCount;
			_eSeats = _nrSeats - _crewCount;

			if !(_tipoVeh in vehTrucks) then
				{
				_grupos = _grupos + [_grupo];
				_Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
				_Vwp0 setWaypointBehaviour "SAFE";
				_Vwp0 setWaypointType "TR UNLOAD";
				_Vwp0 setWayPointCompletionRadius (10*_i);
				//_Vwp0 setWaypointStatements ["true", "[vehicle this] call smokeCoverAuto"];
				_Vwp1 = _grupoVeh addWaypoint [_posdestino, 1];
				_Vwp1 setWaypointType "SAD";
				_Vwp1 setWaypointBehaviour "COMBAT";
				_Vwp2 = _grupo addWaypoint [_landPos, 0];
				_Vwp2 setWaypointType "GETOUT";
				_Vwp0 synchronizeWaypoint [_Vwp2];
				_Vwp3 = _grupo addWaypoint [_posdestino, 1];
				_Vwp3 setWaypointType "SAD";
				[_veh] spawn smokeCover;
				_veh allowCrewInImmobile true;
				[_veh,"APC"] spawn inmuneConvoy;
				}
			else
				{
				{[_x] join _grupoVeh} forEach units _grupo;
				deleteGroup _grupo;

				_tempInfo = [_veh, _grupoVeh, _soldados, _posorigen] call generateCrew;
				_veh = _tempInfo select 0;
				_grupoVeh = _tempInfo select 1;
				_soldados = _tempInfo select 2;

				_Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
				_Vwp0 setWaypointBehaviour "SAFE";
				_Vwp0 setWaypointType "GETOUT";
				_Vwp1 = _grupoVeh addWaypoint [_posdestino, 1];
				if (count (garrison getVariable _mrkdestino) < 4) then
					{
					_Vwp1 setWaypointType "MOVE";
					_Vwp1 setWaypointBehaviour "AWARE";
					}
				else
					{
					_Vwp1 setWaypointType "SAD";
					_Vwp1 setWaypointBehaviour "COMBAT";
					};
				[_veh,"Inf Truck."] spawn inmuneConvoy;
				};
			}



		else
			{
			_Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
			_Vwp0 setWaypointBehaviour "SAFE";
			[_veh,"Tank"] spawn inmuneConvoy;
			_veh allowCrewInImmobile true;
			_Vwp0 setWaypointType "SAD";
			};
		sleep 5;
		};
	};

if (_aeropuerto != "") then
	{
	[_aeropuerto,60] execVM "addTimeForIdle.sqf";
	if (_base != "") then {sleep ((_posorigen distance _posdestino)/16)};
	_posorigen = getMarkerPos _aeropuerto;
	_posorigen set [2,300];
	_uav = createVehicle [indUAV_large, _posorigen, [], 0, "FLY"];
	_vehiculos = _vehiculos + [_uav];
	[_uav] spawn genVEHinit;
	[_uav,"UAV"] spawn inmuneConvoy;
	[_uav,_mrkDestino] spawn VANTinfo;
	createVehicleCrew _uav;
	_soldados = _soldados + crew _uav;
	_grupouav = group (crew _uav select 0);
	_grupos = _grupos + [_grupouav];
	{[_x] spawn AS_fnc_initUnitOPFOR} forEach units _grupoUav;
	_uwp0 = _grupouav addWayPoint [_posdestino,0];
	_uwp0 setWaypointBehaviour "AWARE";
	_uwp0 setWaypointType "MOVE";
	_uav removeMagazines "6Rnd_LG_scalpel";
	sleep 5;

	_tipoVeh = "";
	for "_i" from 1 to 3 do
		{
		if (_i == 3) then
			{
			_tipoVeh = heli_unarmed call BIS_fnc_selectRandom;
			}
		else
			{
			_planesAAF =+ planesAAF;
			if ((_threatEvalAir > 7) && (count (_planesAAF - heli_unarmed) < count _planesAAF)) then {_planesAAF = _planesAAF - heli_unarmed};
			if ((_threatEvalAir > 14) && (count (_planesAAF - planes) < count _planesAAF)) then {_planesAAF = planes};

			if !(count _planesAAF > 0) then {
				_planesAAF = heli_unarmed;
			};
			_tipoVeh = _planesAAF call BIS_fnc_selectRandom;
			};
		_timeOut = 0;
		_pos = _posorigen findEmptyPosition [0,100,heli_transport];
		while {_timeOut < 60} do
			{
			if (count _pos > 0) exitWith {};
			_timeOut = _timeOut + 1;
			_pos = _posorigen findEmptyPosition [0,100,heli_transport];
			sleep 1;
			};
		if (count _pos == 0) then {_pos = _posorigen};
		if (isNil "_tipoVeh") then {_tipoVeh = heli_default};
		_vehicle=[_pos, random 360,_tipoVeh, side_green] call bis_fnc_spawnvehicle;
		_veh = _vehicle select 0;
		_vehCrew = _vehicle select 1;
		_grupoVeh = _vehicle select 2;
		_pilotos = _pilotos + _vehCrew;
		_grupos = _grupos + [_grupoVeh];
		_vehiculos = _vehiculos + [_veh];
		{[_x] spawn AS_fnc_initUnitOPFOR} forEach units _grupoVeh;
		[_veh] spawn genVEHinit;
		if !((_tipoVeh in heli_unarmed) or (_tipoVeh == heli_default)) then
			{
			_Hwp0 = _grupoVeh addWaypoint [_posdestino, 0];
			_Hwp0 setWaypointBehaviour "AWARE";
			_Hwp0 setWaypointType "SAD";
			_Hwp0 setWaypointLoiterType "CIRCLE";
			[_veh,"Air Attack"] spawn inmuneConvoy;
			};

		if ((_tipoVeh in heli_unarmed) or (_tipoVeh == heli_default)) then
			{
			_seats = ([_tipoVeh,true] call BIS_fnc_crewCount) - ([_tipoVeh,false] call BIS_fnc_crewCount);
			if (_seats <= 12) then {
				if (_seats <= 7) then {
					_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
				}
				else {
					_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
					};
				_grupo = [_posorigen, side_green, _tipoGrupo] call BIS_Fnc_spawnGroup;
				{[_x] spawn AS_fnc_initUnitOPFOR;_x assignAsCargo _veh;_x moveInCargo _veh; _soldados = _soldados + [_x]} forEach units _grupo;
				//[_mrkDestino,_grupo] spawn attackDrill;
				_grupos = _grupos + [_grupo];
				_landpos = [];
				_landpos = [_posdestino, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
				_landPos set [2, 0];
				_pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
				_vehiculos = _vehiculos + [_pad];
				
				[_grupoVeh, _posorigen, _landpos, _mrkdestino, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;
				
				/* _wp0 = _grupoVeh addWaypoint [_landpos, 0];
				_wp0 setWaypointType "TR UNLOAD";
				_wp0 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; [vehicle this] call smokeCoverAuto"];
				_wp0 setWaypointBehaviour "CARELESS";
				_wp3 = _grupo addWaypoint [_landpos, 0];
				_wp3 setWaypointType "GETOUT";
				_wp0 synchronizeWaypoint [_wp3];
				_wp4 = _grupo addWaypoint [_posdestino, 1];
				_wp4 setWaypointType "SAD";
				_wp2 = _grupoVeh addWaypoint [_posorigen, 1];
				_wp2 setWaypointType "MOVE";
				_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];
				_wp2 setWaypointBehaviour "CARELESS"; */
				[_veh,"Air Transport"] spawn inmuneConvoy;

				}
			else {
				_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
				_grupo = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
				{[_x] spawn AS_fnc_initUnitOPFOR;_x assignAsCargo _veh;_x moveInCargo _veh; _soldados = _soldados + [_x]} forEach units _grupo;
				//sleep 1;
				_grupos = _grupos + [_grupo];
				_grupo1 = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
				{[_x] spawn AS_fnc_initUnitOPFOR;_x assignAsCargo _veh;_x moveInCargo _veh; _soldados = _soldados + [_x]} forEach units _grupo1;
				_grupos = _grupos + [_grupo1];
				//[_veh,_grupo,_grupo1,_posdestino,_posorigen,_grupoVeh] spawn fastropeAAF;
				[_grupoVeh, _pos, _posdestino, _mrkdestino, [_grupo, _grupo1], 25*60] call fnc_QRF_fastrope;
				};
			};
		sleep 15;
		};
	};


_solMax = round ((count _soldados)/3);


waitUntil {sleep 5; (({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or ({alive _x} count _soldados < _solMax) or (time > _tiempo) or (_mrkDestino in mrkAAF)};

//forcedSpawn = forcedSpawn - [_mrkDestino]; publicVariable "forcedSpawn";

if (not(_mrkDestino in mrkAAF)) then
	{
	{if (isPlayer _x) then {[10,_x] call playerScoreAdd}} forEach ([500,0,_posdestino,"BLUFORSpawn"] call distanceUnits);
	[5,stavros] call playerScoreAdd;
	if (!_CSAT) then
		{
		_tsk = ["AtaqueAAF",[side_blue,civilian],[format ["AAF Is attacking from %1. Intercept them or we may loose a sector",_nombreorig],"AAF Attack",_markTsk],getMarkerPos _markTsk,"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
		}
	else
		{
		_tsk = ["AtaqueAAF",[side_blue,civilian],[format ["AAF and CSAT are attacking %2 from %1. Intercept them or we may loose a sector",_nombreorig,_nombredest],"AAF Attack",_mrkDestino],getMarkerPos _mrkDestino,"SUCCEEDED",10,true,true,"Defend"] call BIS_fnc_setTask;
		};
	{_x doMove _posorigen} forEach _soldados;
	{_wpRTB = _x addWaypoint [_posorigen, 0]; _x setCurrentWaypoint _wpRTB} forEach _grupos;
	}
else
	{
	[-10,stavros] call playerScoreAdd;
	if (!_CSAT) then
		{
		_tsk = ["AtaqueAAF",[side_blue,civilian],[format ["AAF Is attacking from %1. Intercept them or we may loose a sector",_nombreorig],"AAF Attack",_markTsk],getMarkerPos _markTsk,"FAILED",10,true,true,"Defend"] call BIS_fnc_setTask;
		}
	else
		{
		_tsk = ["AtaqueAAF",[side_blue,civilian],[format ["AAF and CSAT are attacking %2 from %1. Intercept them or we may loose a sector",_nombreorig,_nombredest],"AAF Attack",_mrkDestino],getMarkerPos _mrkDestino,"FAILED",10,true,true,"Defend"] call BIS_fnc_setTask;
		};
	waitUntil {sleep 1; !(spawner getVariable _mrkDestino)};
	};

if (cuentaCA < 0) then {
	cuentaCA = 600;
};

[2700] remoteExec ["timingCA",2];

sleep 30;

[0,_tsk] spawn borrarTask;

{
waitUntil {sleep 1; !([distanciaSPWN,1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x;
} forEach _soldados;
{
waitUntil {sleep 1; !([distanciaSPWN,1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x;
} forEach _pilotos;

{
waitUntil {sleep 1; !([distanciaSPWN,1,_x,"BLUFORSpawn"] call distanceUnits)};
deleteVehicle _x;
} forEach _vehiculos;
{
if (!([distanciaSPWN,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x};
} forEach _vehiculos;
{deleteGroup _x} forEach _grupos;


