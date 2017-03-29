if (!isServer and hasInterface) exitWith {};

if (server getVariable "blockCSAT") exitWith {};

params ["_marcador", ["_fromBase", ""]];

private _isDirectAttack = false;
private _base = "";
private _aeropuerto = "";

if (_fromBase != "") then {
	private _isDirectAttack = true;
	if (_fromBase in aeropuertos) then {
		_aeropuerto = _base;
		_base = "";
	} else {
		_base = _fromBase;
	};
};

if ((!_isDirectAttack) and (diag_fps < minimoFPS)) exitWith {};

private _isMarker = false;
private _exit = false;
private _position = "";
if (typeName _marcador == typeName "") then {
	_isMarker = true;
	_position = getMarkerPos _marcador;
else {
	_position = _marcador;
};

if (_isMarker and !_isDirectAttack and (_marcador in smallCAmrk)) exitWith {}; // marker already being patrolled.

private _exit = false;
if (!_isMarker) {
	// do not patrol closeby patrol locations.
	_closestPatrolPosition = [smallCApos, _position] call BIS_fnc_nearestPosition;
	if (_closestPatrolPosition distance _position < (distanciaSPWN/2)) exitWith {_exit = true;};

	// do not patrol closeby to patrolled markers.
	if (count smallCAmrk > 0) then {
		_closestPatrolMarker = [smallCAmrk, _position] call BIS_fnc_nearestPosition;
		if ((getMarkerPos _closestPatrolMarker) distance _position < (distanciaSPWN/2)) then {_exit = true;};
	};
};

if (_exit) exitWith {};

// if marker has no radio, do not send patrol.
if (!_isDirectAttack and !([_marcador] call radioCheck)) exitWith {};

// select base to attack from.
if (!_isDirectAttack) then {
		_base = [_marcador] call findBasesForCA;
		if (_base == "") then {_aeropuerto = [_marcador] call findAirportsForCA};
};

// check if CSAT will help.
private _hayCSAT = false;
if ((_base == "") and (_aeropuerto == "") and (random 100 < server getVariable "prestigeCSAT")) then
	_hayCSAT = true;
};

if ((_base == "") and (_aeropuerto == "") and (!_hayCSAT)) exitWith {};  // if no way to create patrol, exit.

// decide to not send Air units if treat of AA is too high.
if ((_base == "") and ((_aeropuerto != "") or (_hayCSAT))) then {
	_threatEval = [_position] call AAthreatEval;
	if ((_aeropuerto != "") and !_isDirectAttack) then {
		if (((_threatEval > 15) and count (planesAAF - planes) >= count planesAAF) or 
			((_threatEval > 10) and count (planesAAF - heli_armed - planes) >= count planesAAF)) then {
			_aeropuerto = "";
		};
	};
};

// decide to not send if treat is too high.
if (_base != "") then {
	_threatEval = [_position] call landThreatEval;
	if (!_isDirectAttack) then {
		if (((_threatEval > 15) and !((count (vehAAFAT - vehTank) < count vehAAFAT))) or 
			((_threatEval > 5) && (count (vehAAFAT - vehIFV - vehTank) < count vehAAFAT))) then {
			_base = "";
		};
	};

if ((_base == "") and (_aeropuerto == "") and (!_hayCSAT)) exitWith {};

////////////////////// All checks passed. Build the patrol.

// save the marker or position
if (_isMarker) then {
	smallCAmrk pushBackUnique _marcador; publicVariable "smallCAmrk";
} else {
	smallCApos pushBack _marcador;
};

// lists of spawned stuff to delete in the end.
private _soldados = [];
private _vehiculos = [];
private _grupos = [];

if (_base != "") then {
	_aeropuerto = "";
	_hayCSAT = false;
	if (!_isDirectAttack) then {[_base,20] execVM "addTimeForIdle.sqf"};
	private _posorigen = getMarkerPos _base;
	private _tam = 10;
	private _roads = [];
	while {true} do {
		_roads = _posorigen nearRoads _tam;
		if (count _roads < 1) then {_tam = _tam + 10};
		if (count _roads > 0) exitWith {};
	};
	private _road = _roads select 0;
	private _tipoVeh = "";
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
	private _pos = (position _road) findEmptyPosition [0,100,_tipoVeh];
	if (count _pos == 0) then {_pos = (position _road)};
	([_pos, random 360,_tipoVeh, side_green] call bis_fnc_spawnvehicle) params ["_veh", "_vehCrew", "_grupoVeh"];
	{[_x] spawn AS_fnc_initUnitOPFOR} forEach _vehCrew;
	[_veh] spawn genVEHinit;
	_soldados = _soldados + _vehCrew;
	_grupos = _grupos + [_grupoVeh];
	_vehiculos = _vehiculos + [_veh];

	_landPos = [];
	_landPos = [_posdestino,position _road,_threatEval] call findSafeRoadToUnload;
	_tipoGrupo = "";
	if !(_tipoVeh in vehTank) then {
		if (_tipoVeh in vehIFV) then {
			_tipoGrupo = [infSquad, side_green] call fnc_pickGroup;
		}
		else {
			_tipoGrupo = [infTeam, side_green] call fnc_pickGroup;
		};
		_grupo = [_posorigen, side_green, _tipogrupo] call BIS_Fnc_spawnGroup;
		{[_x] spawn AS_fnc_initUnitOPFOR; _x assignAsCargo _veh; _x moveInCargo _veh; _soldados = _soldados + [_x]} forEach units _grupo;

		if !(_tipoVeh in vehTrucks) then {
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
		else {  // is truck
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
			if (_isMarker) then
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
	} else { // is tank
		_Vwp0 = _grupoVeh addWaypoint [_landPos, 0];
		_Vwp0 setWaypointBehaviour "SAFE";
		[_veh,"Tank"] spawn inmuneConvoy;
		_Vwp0 setWaypointType "SAD";
		_veh allowCrewInImmobile true;
	};
};

if (_aeropuerto != "") then {
	if (!_isDirectAttack) then {[_aeropuerto,20] execVM "addTimeForIdle.sqf"};
	_posorigen = getMarkerPos _aeropuerto;
	_planesAAF = planesAAF - planes;
	_cuenta = 1;
	if (_isMarker) then {_cuenta = 2};
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

if (_hayCSAT) then {
	private _posorigen = getMarkerPos "spawnCSAT";
	private _posorigen set [2,300];  // high in the skies
	for "_i" from 1 to 3 do {
		private _tipoVeh = "";
		if (_i == 3) then {
			_tipoVeh = selectRandom opHeliTrans;
		} else {
			if (_threatEval > 10) then {_tipoVeh = selectRandom (opAir - opHeliTrans)} else {_tipoVeh = selectRandom opAir};
		};
		private _pos = _posorigen findEmptyPosition [0,100,_tipoVeh];
		if (count _pos == 0) then {_pos = _posorigen};

		([_pos, 0,_tipoVeh, side_red] call bis_fnc_spawnvehicle) params ["_heli", "_heliCrew", "_grupoheli"];
		_soldados = _soldados + _heliCrew;
		_grupos = _grupos + [_grupoheli];
		_vehiculos = _vehiculos + [_heli];
		[_heli] spawn CSATVEHinit;
		{[_x] spawn CSATinit} forEach _heliCrew;
		if (!(_tipoVeh in opHeliTrans)) then {  // attack heli
			private _wp1 = _grupoheli addWaypoint [_posdestino, 0];
			private _wp1 setWaypointType "SAD";
			[_heli,"CSAT Air Attack"] spawn inmuneConvoy;
		} else {  // transport heli
			{_x setBehaviour "CARELESS";} forEach units _grupoheli;
			private _tipoGrupo = [opGroup_Squad, side_red] call fnc_pickGroup;
			_grupo = [_posorigen, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
			{_x assignAsCargo _heli; _x moveInCargo _heli; _soldados = _soldados + [_x]; [_x] spawn CSATinit} forEach units _grupo;
			_grupos = _grupos + [_grupo];
			[_heli,"CSAT Air Transport"] spawn inmuneConvoy;

			if ((_marcador in bases) or (_marcador in aeropuertos) or (random 10 < _threatEval)) then {
				[_heli,_grupo,_marcador,_threatEval] spawn airdrop;
			} else {
				if ((random 100 < 50) or (_tipoVeh == opHeliDismount)) then {
					{_x disableAI "TARGET"; _x disableAI "AUTOTARGET"} foreach units _grupoheli;
					private _landpos = [];
					_landpos = [_posdestino, 300, 500, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
					_landPos set [2, 0];
					private _pad = createVehicle ["Land_HelipadEmpty_F", _landpos, [], 0, "NONE"];
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
				else {
					[_heli,_grupo,_posdestino,_posorigen,_grupoheli] spawn fastropeCSAT;
				};
			};
		};
		sleep 15;  // time between spawning choppers
	};
};

//// All units sent. Cleanup below.

if (_isMarker) then {
	_solMax = round ((count _soldados)/3);
	_tiempo = time + 3600;

	waitUntil {sleep 5; (({not (captive _x)} count _soldados) < ({captive _x} count _soldados)) or ({alive _x} count _soldados < _solMax) or (_marcador in mrkAAF) or (time > _tiempo)};

	smallCAmrk = smallCAmrk - [_marcador]; publicVariable "smallCAmrk";

	waitUntil {sleep 1; not (spawner getVariable _marcador)};
}
else {
	waitUntil {sleep 1; !([distanciaSPWN,1,_position,"BLUFORSpawn"] call distanceUnits)};
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