params ["_unit"];
private _group = group _unit;

private _spot_distance = 50;
private _unspot_distance = 100;

_unit setVariable ["BIS_fnc_animalBehaviour_disable", true];
_unit disableAI "FSM";
_unit setBehaviour "CARELESS";
_unit setRank "PRIVATE";

private _spotted = objNull;
while {alive _unit} do {
	if ((_unit == leader _group) and (!captive _unit)) then {_unit setCaptive true};
	if (isNull _spotted) then {
		sleep 10;
		_unit moveTo getPosATL leader _group;

		// spot every unit within 50m
		{
			_spotted = _x;

			// spotted a unit. It loses its cover
			if (captive _spotted) then {
				(leader _group) reveal [_spotted, 4];
				[_spotted, false] remoteExec ["setCaptive", _spotted];
			};
		} forEach ([_spot_distance, position _unit, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

		if ((random 10 < 1) and (isNull _spotted)) then {
			playSound3D [missionPath + (selectRandom AS_dog_sounds), _unit, false, getPosASL _unit, 1, 1, 100];
		};
		if (_unit distance (leader _group) > 50) then {_unit setPos position (leader _group)};
	} else {
		// someone is spotted. Move towards it while barking
		_unit doWatch _spotted;
		playSound3D [missionPath + (selectRandom AS_dog_barking_sounds), _unit, false, getPosASL _unit, 1, 1, 100];
		_unit moveTo getPosATL _spotted;
		if (_spotted distance _unit > _unspot_distance) then {_spotted = objNull};
		sleep 3;
	};
};
