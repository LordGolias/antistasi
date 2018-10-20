params ["_group"];

private _unit = _group createUnit ["B_RangeMaster_F", position leader _group, [], 0, "FORM"];
_unit setVariable ["isDog", true, true];

// logic to have a dog following a group
// see https://forums.bohemia.net/forums/topic/210830-release-directly-controllabe-dog/
[_unit] spawn {
	params ["_guy"];
	private _dog = createAgent ["Fin_random_F", getPos _guy, [], 0, "CAN_COLLIDE"];
	_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_dog attachTo [_guy, [0,0,0]];
	_guy hideObjectGlobal true;

	while {alive _guy and {alive _dog}} do {
		if (speed _guy > 10) then {
			_dog playMoveNow "Dog_Sprint";
		} else {
			if (speed _guy > 6) then {
				_dog playMoveNow "Dog_Run";
			} else {
				if ((speed _guy > 2) || (speed _guy < -2)) then {
					_dog playMoveNow "Dog_Walk";
				} else {
					if !(_guy getVariable ["barking", false]) then {
						if ((stance _guy) == "STAND") then {
							_dog playMoveNow "Dog_Stop";
						} else {
							if ((stance _guy) == "PRONE") then {
								_dog playMoveNow "Dog_Sit";
							} else {
								_dog playMoveNow "Dog_Idle_Stop";
							};
						};
					};
				};
			};
		};
		sleep 0.05;
	};
	deleteVehicle _guy;
};

// logic for spotting undercover units and barking
[_unit] spawn {
	params ["_guy"];
	private _dog = attachedObjects _guy select 0;

	private _spotted = objNull;

	while {alive _guy and {alive _dog}} do {
		// spot every enemy within 50m
		{
			if ((side _x != side _guy) and {_x distance _guy < 50}) then {
				// spotted loses its cover
				(leader group _guy) reveal [_x, 4];
				if (captive _x) then {
					[_x, false] remoteExec ["setCaptive", _x];
				};
				_spotted = _x;
			};
		} forEach allUnits;

		if (isNil "_spotted" or {_guy distance _spotted > 75}) then {
			_spotted = objNull;
		};

		// bark when unit is spotted
		if (not isNull _spotted) then {
			_dog playMoveNow "Dog_Idle_Bark";
			_guy setVariable["barking",true,true];
			sleep 1.5;
			playSound3D [format["A3\Sounds_F\ambient\animals\dog%1.wss", ceil random 3],
				_guy, false, getPosASL _guy, 40, 1, 10];
			sleep 2;
			_guy setVariable ["barking",false,true];
		};

		sleep 5;
	};
};
_unit
