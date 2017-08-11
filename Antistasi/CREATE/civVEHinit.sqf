params ["_veh"];

[_veh] call AS_DEBUG_initVehicle;

// do not allow wheels to break when AI is driving
if (_veh isKindOf "Car") then {
	_veh addEventHandler ["HandleDamage", {
		params ["_veh", "_part", "_damage", "_injurer"];
		if ((_part find "wheel" != -1) and (_injurer == "") and (!isPlayer driver _veh)) then {
			0
		} else {
			_damage
		};
	}];
};

[_veh] spawn cleanserVeh;

_veh addEventHandler ["Killed", {
	[_this select 0] remoteExec ["postmortem", 2];
}];

if (count crew _veh == 0) then {
	sleep 10;
	// stop its simulation and on
	_veh enableSimulationGlobal false;
	_veh addEventHandler ["GetIn", {
		_veh = _this select 0;
		if (!simulationEnabled _veh) then {
			_veh enableSimulationGlobal true
		};
		[_veh] spawn VEHdespawner;
	}];

	_veh addEventHandler ["HandleDamage", {
		_veh = _this select 0;
		if (!simulationEnabled _veh) then {
			_veh enableSimulationGlobal true
		};
	}];
};
