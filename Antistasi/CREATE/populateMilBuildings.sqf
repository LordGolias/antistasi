params ["_marcador", "_side", "_grupo"];

private _posicion = getMarkerPos _marcador;
private _buildings = nearestObjects [_posicion, listMilBld, ([_marcador] call sizeMarker)*1.5];
private _addChopper = (_side == side_green) and !([_marcador] call isFrontline);

// FIA
private _staticAA = "B_static_AA_F";
private _staticMG = "B_HMG_01_high_F";
private _gunnerCrew = ["Crew"] call AS_fnc_getFIAUnitClass;
// AAF
if (_side == side_green) then {
	_staticAA = statAA;
	_staticMG = statMGtower;
	_gunnerCrew = infGunner;
};
if (_side == side_blue) then {
	_staticAA = selectRandom bluStatAA;
	_staticMG = bluStatHMG;
	_gunnerCrew = bluGunner;
};

private _soldadosMG = [];
private _vehiculos = [];

{
	_building = _x;
	_tipoB = typeOf _building;
	if ((_tipoB == "Land_Cargo_HQ_V1_F") or (_tipoB == "Land_Cargo_HQ_V2_F") or (_tipoB == "Land_Cargo_HQ_V3_F")) then {
		_veh = createVehicle [_statAA, (_building buildingPos 8), [],0, "CAN_COLLIDE"];
		_veh setPosATL [(getPos _building select 0),(getPos _building select 1),(getPosATL _veh select 2)];
		_veh setDir (getDir _building);
		_unit = _grupo createUnit [_gunnerCrew, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
		if (_side == side_green) then {
			[_unit, false] spawn AS_fnc_initUnitOPFOR;
		};
		_soldadosMG pushback _unit;
		_vehiculos pushback _veh;
		sleep 1;
	};
	if ((_tipoB == "Land_Cargo_Patrol_V1_F") or (_tipoB == "Land_Cargo_Patrol_V2_F") or (_tipoB == "Land_Cargo_Patrol_V3_F")) then {
		_veh = createVehicle [_staticMG, (_building buildingPos 1), [], 0, "CAN_COLLIDE"];
		_ang = (getDir _building) - 180;
		_pos = [getPosATL _veh, 2.5, _ang] call BIS_Fnc_relPos;
		_veh setPosATL _pos;
		_veh setDir (getDir _building) - 180;
		_unit = _grupo createUnit [_gunnerCrew, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
		if (_side == side_green) then {
			[_unit, false] spawn AS_fnc_initUnitOPFOR;
		};
		_soldadosMG pushback _unit;
		_vehiculos pushback _veh;
		sleep 1;
	};
	if (_addChopper and (_tipoB == "Land_HelipadSquare_F")) then {
		_veh = createVehicle [selectRandom heli_unarmed, position _building, [],0, "CAN_COLLIDE"];
		_veh setDir (getDir _building);
		_vehiculos pushback _veh;
		sleep 1;
	};
	if (_tipoB in listbld) then {
		_veh = createVehicle [_staticMG, (_building buildingPos 13), [], 0, "CAN_COLLIDE"];
		_unit = _grupo createUnit [_gunnerCrew, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
		if (_side == side_green) then {
			[_unit, false] spawn AS_fnc_initUnitOPFOR;
		};
		_soldadosMG pushback _unit;
		_vehiculos pushback _veh;
		sleep 1;

		_veh = createVehicle [_staticMG, (_building buildingPos 17), [], 0, "CAN_COLLIDE"];
		_unit = _grupo createUnit [_gunnerCrew, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
		if (_side == side_green) then {
			[_unit, false] spawn AS_fnc_initUnitOPFOR;
		};
		_soldadosMG pushback _unit;
		_vehiculos pushback _veh;
		sleep 1;
	};
} forEach _buildings;

[_soldadosMG, _vehiculos]
