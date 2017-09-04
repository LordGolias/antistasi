params ["_truck", "_waitTime", "_fnc_unloadCondition", "_fnc_missionFailedCondition",
		["_str_unloadStopped", "Stay close to the truck and keep it clear"],
		["_str_unloadStart", "Guard the truck!"]];

// wait by the truck or the mission to fail
private _active = false;
private _counter = 0;
while {(_counter < _waitTime) and {not call _fnc_missionFailedCondition}} do {
	while {(_counter < _waitTime) and {not call _fnc_missionFailedCondition} and _fnc_unloadCondition} do {

		if !(_active) then {
			{
				if (isPlayer _x) then {
					[_waitTime - _counter, false] remoteExec ["pBarMP", _x];
				};
			} forEach ([100, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
			_active = true;
			if (_str_unloadStart != "") then {
				[[petros, "sideChat", _str_unloadStart], "commsMP"] call BIS_fnc_MP;
			};
		};
		_counter = _counter + 1;
		sleep 1;
	};

	// if the loading is interrupted, we wait until load is allowed or mission fails
	if not (call _fnc_unloadCondition) then {
		_counter = 0;
		_active = false;
		{
			if (isPlayer _x) then {
				[0, true] remoteExec ["pBarMP", _x];
			};
		} forEach ([100, _truck, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

		if (not call _fnc_missionFailedCondition) then {
			if (_str_unloadStopped != "") then {
				[[petros, "sideChat", _str_unloadStopped], "commsMP"] call BIS_fnc_MP;
			};
		};

		waitUntil {sleep 1; call _fnc_unloadCondition or _fnc_missionFailedCondition};
	};
};
