private ["_veh"];

_veh = _this select 0;

[_veh] call AS_DEBUG_initVehicle;

if (_veh isKindOf "Car") then
	{
	_veh addEventHandler ["HandleDamage",{if (((_this select 1) find "wheel" != -1) and (_this select 4=="") and (!isPlayer driver (_this select 0))) then {0;} else {(_this select 2);};}];
	};

[_veh] spawn cleanserVeh;

_veh addEventHandler ["Killed",{
	[_this select 0] remoteExec ["postmortem",2];
	}];

if (count crew _veh == 0) then
	{
	sleep 10;
	_veh enableSimulationGlobal false;
	_veh addEventHandler ["GetIn",
		{
		_veh = _this select 0;
		if (!simulationEnabled _veh) then {_veh enableSimulationGlobal true};
		[_veh] spawn VEHdespawner;
		}
		];
	_veh addEventHandler ["HandleDamage",
		{
		_veh = _this select 0;
		if (!simulationEnabled _veh) then {_veh enableSimulationGlobal true};
		}
		];
	};
