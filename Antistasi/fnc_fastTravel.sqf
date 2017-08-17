if (count hcSelected player > 1) exitWith {
	hint "You can only select one group to fast travel";
};

private _isHCfastTravel = false;
private _group = group player;
if (count hcSelected player == 1) then {
	_group = hcSelected player select 0;
	_isHCfastTravel = true;
};

if ((leader _group != player) and (!_isHCfastTravel)) exitWith {hint "Only a group leader can use fast travel"};

if (({isPlayer _x} count units _group > 1) and (!_isHCfastTravel)) exitWith {hint "You cannot fast travel with other players in your group"};

if (call AS_fnc_controlsAI) exitWith {hint "You cannot fast travel while you are controlling AI"};

private _unpreparedVehicles = false;
{
	if ((vehicle _x != _x) and ((isNull (driver vehicle _x)) or (!canMove vehicle _x) or (vehicle _x isKindOf "StaticWeapon"))) then {
		_unpreparedVehicles = true;
	};
} forEach units _group;

if (_unpreparedVehicles) exitWith {
	Hint "You cannot fast travel if you don't have a driver in all your vehicles or your vehicles cannot move";
};

private _enemiesNearby = false;
{
	private _enemy = _x;
	if (side _enemy != side_blue and !(captive _enemy)) then {
		{
			if (_enemy distance _x < 500) exitWith {
				_enemiesNearby = true
			};
		} forEach units _group;
	};
} forEach allUnits;
if (_enemiesNearby) exitWith {Hint "You cannot use fast travel with enemies near the group fast traveling"};

////// First check done. Let us pick a position on the map

posicionTel = [];

if (_isHCfastTravel) then {hcShowBar false};
hint "Click on the zone you want to travel to";
openMap true;
onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (not visiblemap)};
onMapSingleClick "";

private _positionTo = +posicionTel;
posicionTel = nil;

if (count _positionTo == 0) exitWith {};

private _location = _positionTo call AS_fnc_location_nearest;
private _positionTo = _location call AS_fnc_location_position;

private _validLocations = "FIA" call AS_fnc_location_S;
if !(_location in _validLocations) exitWith {
	hint "You can only fast travel to FIA locations";
	openMap [false,false];
};

private _enemiesNearby = false;
{
	if ((side _x != side_blue) and
		(_x distance _positionTo < 500) and
		(not(captive _x))) exitWith {_enemiesNearby = true};
} forEach allUnits;

if (_enemiesNearby) exitWith {
	Hint "You cannot use fast travel to a location with enemies nearby";
	openMap [false,false];
};

private _positionTo = [_positionTo, 10, random 360] call BIS_Fnc_relPos;

private _distance = round ((position (leader _group)) distance _positionTo);

if (!_isHCfastTravel) then {
	disableUserInput true;
	cutText ["Fast traveling, please wait","BLACK",2];
	sleep 5; // wait some time
} else {
	hcShowBar false;
	hcShowBar true;
	hint format ["Moving group %1 to destination.", groupID _group];
	sleep 5; // wait some time
};

private _forcedSpawn = false;
if !(_location call AS_fnc_location_forced_spawned) then {
	_forcedSpawn = true;
	[_location,true] call AS_fnc_location_spawn;
	sleep 5; // wait for spawn of location
};

// put all units in the location
{
	_unit = _x;
	_unit allowDamage false;
	if (_unit != vehicle _unit) then {
		if (driver vehicle _unit == _unit) then {
			// find empty position for a vehicle
			private _tam = 10;
			private _roads = [];
			while {count _roads == 0} do {
				_roads = _positionTo nearRoads _tam;
				_tam = _tam + 10;
			};
			_road = _roads select 0;
			private _position = (position _road) findEmptyPosition [1,50,typeOf (vehicle _unit)];
			vehicle _unit setPos _position;  // other passengers are moved with the vehicle
		};
	} else {  // unit; non-vechicle
		private _position = _positionTo findEmptyPosition [1,50,typeOf _unit];
		_unit setPosATL _position;
		if !(_unit call AS_fnc_isUnconscious) then {
			if (isPlayer leader _unit) then {_unit setVariable ["rearming",false]};
			_unit doWatch objNull;
			_unit doFollow leader _unit;
		};
	};
} forEach units _group;

if (!_isHCfastTravel) then {
	disableUserInput false;
	cutText ["You arrived to destination","BLACK IN",3]
} else {
	hint format ["Group %1 arrived to destination",groupID _group]
};

if (_forcedSpawn) then {
	[_location,true] call AS_fnc_location_despawn;
};
{_x allowDamage true} forEach units _group;

openMap false;
