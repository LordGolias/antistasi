params ["_location", "_side", "_grupo"];

private _posicion = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;
private _buildings = nearestObjects [_posicion, AS_destroyable_buildings, _size*1.5];
private _addChopper = (_side == "AAF") and
	{!([_location] call AS_fnc_location_isFrontline)} and
	{"transportHelis" call AS_AAFarsenal_fnc_count > 0};

// AAF
private _staticAA = statAA;
private _staticMG = statMGtower;
private _gunnerCrew = ["AAF", "gunner"] call AS_fnc_getEntity;
if (_side == "NATO") then {
	_staticAA = ["NATO", "static_aa"] call AS_fnc_getEntity;
	_staticMG = ["NATO", "static_mg"] call AS_fnc_getEntity;
	_gunnerCrew = ["NATO", "gunner"] call AS_fnc_getEntity;
};

private _soldiers = [];
private _vehicles = [];

{
	private _building = _x;
	private _buildingType = typeOf _building;
	if (_buildingType in ["Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V3_F"]) then {
		private _veh = createVehicle [_staticAA, (_building buildingPos 8), [],0, "CAN_COLLIDE"];
		_veh setPosATL [(getPos _building select 0),(getPos _building select 1),(getPosATL _veh select 2)];
		_veh setDir (getDir _building);
		private _unit = _grupo createUnit [_gunnerCrew, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
		_soldiers pushback _unit;
		_vehicles pushback _veh;
	};
	if (_buildingType in ["Land_Cargo_Patrol_V1_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Patrol_V3_F"]) then {
		private _veh = createVehicle [_staticMG, (_building buildingPos 1), [], 0, "CAN_COLLIDE"];
		private _ang = (getDir _building) - 180;
		private _pos = [getPosATL _veh, 2.5, _ang] call BIS_Fnc_relPos;
		_veh setPosATL _pos;
		_veh setDir (getDir _building) - 180;
		private _unit = _grupo createUnit [_gunnerCrew, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
		_soldiers pushback _unit;
		_vehicles pushback _veh;
	};
	if (_addChopper and (_buildingType == "Land_HelipadSquare_F")) then {
		private _veh = createVehicle [selectRandom ("transportHelis" call AS_AAFarsenal_fnc_valid), position _building, [],0, "CAN_COLLIDE"];
		_veh setDir (getDir _building);
		_vehicles pushback _veh;
	};

	if (_buildingType in AS_MGbuildings) then {
		private _veh = createVehicle [_staticMG, (_building buildingPos 13), [], 0, "CAN_COLLIDE"];
		private _unit = _grupo createUnit [_gunnerCrew, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
		_soldiers pushback _unit;
		_vehicles pushback _veh;

		_veh = createVehicle [_staticMG, (_building buildingPos 17), [], 0, "CAN_COLLIDE"];
		_unit = _grupo createUnit [_gunnerCrew, _posicion, [], 0, "NONE"];
		_unit moveInGunner _veh;
		_soldiers pushback _unit;
		_vehicles pushback _veh;
	};
} forEach _buildings;

[_soldiers, _vehicles]
