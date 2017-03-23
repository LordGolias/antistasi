if (!isServer and hasInterface) exitWith {};

private ["_marcador","_esMarcador","_exit","_radio","_base","_aeropuerto","_posDestino","_soldados","_vehiculos","_grupos","_roads","_posorigen",
		"_tam","_tipoVeh","_vehicle","_veh","_vehCrew","_grupoVeh","_landPos","_tipoGrupo","_grupo","_soldado","_threatEval","_pos","_timeOut",
		"_heli","_plane","_armor","_ifv"];

_marcador = _this select 0;
_inWaves = false;
_base = "";
_aeropuerto = "";

if (server getVariable "blockCSAT") exitWith {};

if (count _this > 1) then
	{
	_base = _this select 1;
	if (_base in aeropuertos) then {_aeropuerto = _base; _base = ""};
	_inWaves = true;
	};

if ((!_inWaves) and (diag_fps < minimoFPS)) exitWith {};

_esMarcador = false;
_exit = false;
if (typeName _marcador == typeName "") then
	{
	_esMarcador = true;
	if (!_inWaves) then {if (_marcador in smallCAmrk) then {_exit = true}};
	}
else
	{
	_cercano = [smallCApos,_marcador] call BIS_fnc_nearestPosition;
	if (_cercano distance _marcador < (distanciaSPWN/2)) then
		{
		_exit = true;
		}
	else
		{
		if (count smallCAmrk > 0) then
			{
			_cercano = [smallCAmrk,_marcador] call BIS_fnc_nearestPosition;
			if (getMarkerPos _cercano distance _marcador < (distanciaSPWN/2)) then {_exit = true};
			};
		};
	};

if (_exit) exitWith {};

_radio = true;
if (!_inWaves) then {_radio = [_marcador] call radioCheck};

if (!_radio) exitWith {};

if (!_inWaves) then
	{
	_base = [_marcador] call findBasesForCA;
	if (_base == "") then {_aeropuerto = [_marcador] call findAirportsForCA};
	};

_hayCSAT = false;

if ((_base == "") and (_aeropuerto == "")) then
	{
	if ((random 100 < server getVariable "prestigeCSAT") && !(server getVariable "blockCSAT")) then {_hayCSAT = true};
	};

if ((_base == "") and (_aeropuerto == "") and (!_hayCSAT)) exitWith {};
_posDestino = _this select 0;
if (_esMarcador) then
	{
	_posDestino = getMarkerPos _marcador;
	};

if ((_base == "") and ((_aeropuerto != "") or (_hayCSAT))) then
	{
	_threatEval = [_posDestino] call AAthreatEval;
	if ((_aeropuerto != "") and (!_inWaves)) then
		{
		if ((_threatEval > 15) && !(count (planesAAF - planes) < count planesAAF)) then
			{
			_aeropuerto = "";
			}
		else
			{
			if ((_threatEval > 10) && !(count (planesAAF - heli_armed - planes) < count planesAAF)) then {_aeropuerto = ""};
			};
		};
	};

if (_base != "") then
	{
	_threatEval = [_posDestino] call landThreatEval;
	if (!_inWaves) then
		{
		if ((_threatEval > 15) and !((count (vehAAFAT - vehTank) < count vehAAFAT))) then
			{
			_base = "";
			}
		else
			{
			if ((_threatEval > 5) && (count (vehAAFAT - vehIFV - vehTank) < count vehAAFAT)) then {_base = ""};
			};
		};
	};

if ((_base == "") and (_aeropuerto == "") and (!_hayCSAT)) exitWith {};

if (_esMarcador) then
	{
	smallCAmrk pushBackUnique _marcador; publicVariable "smallCAmrk";
	}
else
	{
	smallCApos pushBack _marcador;
	};

if (debug) then {hint format ["Nos contraatacan desde %1 o desde el aeropuerto %2 hacia %3", _base, _aeropuerto,_marcador]; sleep 5};

_soldados = [];
_vehiculos = [];
_grupos = [];
_roads = [];

if (_base != "") then
	{
	_aeropuerto = "";
	_hayCSAT = false;
	if (!_inWaves) then {[_base,20] execVM "addTimeForIdle.sqf"};
	_posorigen = getMarkerPos _base;
	_tam = 10;
	while {true} do
		{
		_roads = _posorigen nearRoads _tam;
		if (count _roads < 1) then {_tam = _tam + 10};
		if (count _roads > 0) exitWith {};
		};
	_tipoVeh = "";
	if (count vehAAFAT > 1) then
		{
		//_vehAAFAT = vehAAFAT;
		// experimental
		_vehAAFAT = vehAAFAT + vehTrucks + vehPatrol;
		_vehAAFAT = _vehAAFAT - vehIFV - vehTank;

		if (_threatEval > 3) then {_vehAAFAT = _vehAAFAT - [enemyMotorpoolDef]};
		if ((_threatEval > 5) and (count (vehAAFAT - vehTank - vehIFV) < count vehAAFAT)) then {_vehAAFAT = _vehAAFAT + vehIFV + vehTank - vehTrucks};
		// /experimental
		//if ((_threatEval > 5) and (count (_vehAAFAT - vehTank - vehIFV) < count _vehAAFAT)) then {_vehAAFAT = _vehAAFAT - vehAPC};
		_tipoVeh = _vehAAFAT call BIS_fnc_selectRandom;
		}
	else
		{
		_tipoVeh = enemyMotorpoolDef;
		};
	_road = _roads select 0;
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
	_landPos = [_posdestino,position _road,_threatEval] call findSafeRoadToUnload;
	_tipoGrupo = "";
	if !(_tipoVeh in vehTank) then
		{
		if (_tipoVeh in vehIFV) then {
			_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
		}
		else {
			_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
		};
		_grupo = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
		{[_x] spawn AS_fnc_initUnitOPFOR;_x assignAsCargo _veh;_x moveInCargo _veh; _soldados = _soldados + [_x]} forEach units _grupo;
		if !(_tipoVeh in vehTrucks) then
			{
			_grupos = _grupos + [_grupo];
			_Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
			_Vwp0 setWaypointBehaviour "SAFE";
			_Vwp0 setWaypointType "TR UNLOAD";
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
			[_veh,"APC"] spawn inmuneConvoy;
			_veh allowCrewInImmobile true;
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
			if (_esMarcador) then
				{
				if ((count (garrison getVariable _marcador)) < 4) then
					{
					_Vwp1 setWaypointType "MOVE";
					_Vwp1 setWaypointBehaviour "AWARE";
					}
				else
					{
					_Vwp1 setWaypointType "SAD";
					_Vwp1 setWaypointBehaviour "COMBAT";
					};
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
		_Vwp0 setWaypointType "SAD";
		_veh allowCrewInImmobile true;
		};
	};
if (_aeropuerto != "") then
	{
	if (!_inWaves) then {[_aeropuerto,20] execVM "addTimeForIdle.sqf"};
	_posorigen = getMarkerPos _aeropuerto;
	_planesAAF = planesAAF - planes;
	_cuenta = 1;
	if (_esMarcador) then {_cuenta = 2};
	for "_i" from 1 to _cuenta do
		{
		_tipoVeh = "";
		if (_i < _cuenta) then
			{
			if (_threatEval > 10) then {_planesAAF = _planesAAF - heli_unarmed};
			if (_threatEval > 15) then {_planesAAF = planes};
			if (count _planesAAF > 0) then {_tipoVeh = _planesAAF call BIS_fnc_selectRandom} else {_tipoVeh = heli_default};
			}
		else
			{
			_tipoVeh = selectRandom heli_unarmed;
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
		if (isNil "_tipoVeh") then {_tipoVeh = heli_default};
		if (count _pos == 0) then {_pos = _posorigen};
		_vehicle=[_pos, random 360,_tipoVeh, side_green] call bis_fnc_spawnvehicle;
		_veh = _vehicle select 0;
		_vehCrew = _vehicle select 1;
		_grupoVeh = _vehicle select 2;
		_soldados = _soldados + _vehCrew;
		_grupos = _grupos + [_grupoVeh];
		_vehiculos = _vehiculos + [_veh];
		{[_x] spawn AS_fnc_initUnitOPFOR} forEach units _grupoVeh;
		[_veh] spawn genVEHinit;
		if !(_tipoVeh in heli_unarmed) then
			{
			_Hwp0 = _grupoVeh addWaypoint [_posdestino, 0];
			_Hwp0 setWaypointBehaviour "AWARE";
			_Hwp0 setWaypointType "SAD";
			[_veh,"Air Attack"] spawn inmuneConvoy;

			_seats = ([_tipoVeh,true] call BIS_fnc_crewCount) - ([_tipoVeh,false] call BIS_fnc_crewCount);

			};

		if (_tipoVeh in heli_unarmed) then
			{
			_seats = ([_tipoVeh,true] call BIS_fnc_crewCount) - ([_tipoVeh,false] call BIS_fnc_crewCount);
			if (_seats <= 15) then {
				if (_seats <= 7) then {
					_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
				}
				else {
					_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
				};
				_grupo = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
				{[_x] spawn AS_fnc_initUnitOPFOR;_x assignAsCargo _veh;_x moveInCargo _veh; _soldados = _soldados + [_x]} forEach units _grupo;
				//[_mrkDestino,_grupo] spawn attackDrill;
				_grupos = _grupos + [_grupo];
				_landpos = [];
				_landpos = [_posdestino, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
				_landPos set [2, 0];
				_pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
				_vehiculos = _vehiculos + [_pad];
				
				[_grupoVeh, _posorigen, _landpos, _marcador, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;
				
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
				_wp2 setWaypointBehaviour "AWARE"; */
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
				[_grupoVeh, _pos, _posdestino, _marcador, [_grupo, _grupo1], 25*60] call fnc_QRF_fastrope;
				};
			};
		sleep 30;
		};
	};
if (_hayCSAT) then
	{
	_posorigen = getMarkerPos "spawnCSAT";
	_posorigen set [2,300];
	for "_i" from 1 to 3 do
		{
		_tipoVeh = "";
		if (_i == 3) then
			{
			_tipoVeh = selectRandom opHeliTrans;
			}
		else
			{
			if (_threatEval > 10) then {_tipoVeh = selectRandom (opAir - opHeliTrans)} else {_tipoVeh = selectRandom opAir};
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
		_vehicle=[_pos, 0, _tipoVeh, side_red] call bis_fnc_spawnvehicle;
		_heli = _vehicle select 0;
		_heliCrew = _vehicle select 1;
		_grupoheli = _vehicle select 2;
		_soldados = _soldados + _heliCrew;
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
			_tipoGrupo = [opGroup_Squad, side_red] call fnc_pickGroup;
			_grupo = [_posorigen, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados = _soldados + [_x]; [_x] spawn CSATinit} forEach units _grupo;
			//[_mrkDestino,_grupo] spawn attackDrill;
			_grupos = _grupos + [_grupo];
			[_heli,"CSAT Air Transport"] spawn inmuneConvoy;
			if ((_marcador in bases) or (_marcador in aeropuertos) or (random 10 < _threatEval)) then
				{
				[_heli,_grupo,_marcador,_threatEval] spawn airdrop;
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
					
					[_grupoheli, _posorigen, _landpos, _marcador, _grupo, 25*60, "air"] call fnc_QRF_dismountTroops;
					
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
					_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"]; */
					[_grupoheli,1] setWaypointBehaviour "AWARE";
					}
				else
					{[_heli,_grupo,_posdestino,_posorigen,_grupoheli] spawn fastropeCSAT;}
				};
			};
		sleep 15;
		};
	};

if (_esMarcador) then
	{
	_solMax = round ((count _soldados)/3);
	_tiempo = time + 3600;

	waitUntil {sleep 5; (({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or ({alive _x} count _soldados < _solMax) or (_marcador in mrkAAF) or (time > _tiempo)};

	smallCAmrk = smallCAmrk - [_marcador]; publicVariable "smallCAmrk";

	waitUntil {sleep 1; not (spawner getVariable _marcador)};
	}
else
	{
	waitUntil {sleep 1; !([distanciaSPWN,1,_posDestino,"BLUFORSpawn"] call distanceUnits)};
	smallCApos = smallCApos - [_marcador];
	};

if !(isNil {_soldados}) then {
	if (count _soldados > 0) then {
		{
			waitUntil {sleep 1; !([distanciaSPWN,1,_x,"BLUFORSpawn"] call distanceUnits)};
			deleteVehicle _x;
		} forEach _soldados;
	};
};


{deleteGroup _x} forEach _grupos;

if !(isNil {_vehiculos}) then {
	if (count _vehiculos > 0) then {
		{
			if (!([distanciaSPWN,1,_x,"BLUFORSpawn"] call distanceUnits)) then {deleteVehicle _x};
		} forEach _vehiculos;
	};
};