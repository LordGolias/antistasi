private ["_killed","_killer","_cost","_enemy","_group"];
_killed = _this select 0;
_killer = _this select 1;
if (_killed getVariable ["OPFORSpawn",false]) then {_killed setVariable ["OPFORSpawn",nil,true]};

[_killed] remoteExec ["AS_fnc_activateCleanup",2];

if (hayACE) then {
	if ((isNull _killer) || (_killer == _killed)) then {
		_killer = _killed getVariable ["ace_medical_lastDamageSource", _killer];
	};
};

if ((side _killer == side_blue) || (captive _killer)) then {
	["kill"] remoteExec ["fnc_BE_XP", 2];
	_group = group _killed;

	// scoring.
	if (isPlayer _killer) then {
		[player, "score", 2, false] remoteExec ["AS_players_fnc_change", 2];
	};

	// if dead has no weapons, it is an unlawful kill
	if (count weapons _killed < 1) then {
		[-1,0] remoteExec ["AS_fnc_changeForeignSupport",2];
		[2,0,getPos _killed] remoteExec ["AS_fnc_changeCitySupport",2];
		if (isPlayer _killer) then {
			[_killer, "score", -20, false] remoteExec ["AS_players_fnc_change", 2];
		};
	} else {
		// otherwise, it decreases by -0.5.
		_cost = AS_data_allCosts getVariable (typeOf _killed);
		if (isNil "_cost") then {diag_log format ["[AS] ERROR: cost of %1 not defined.",typeOf _killed]; _cost = 0};
		[-_cost] remoteExec ["AS_fnc_changeAAFmoney",2];
		[-0.5,0,getPos _killed] remoteExec ["AS_fnc_changeCitySupport",2];
		if (isPlayer _killer) then {
			[_killer, "score", 2, false] remoteExec ["AS_players_fnc_change", 2];
		};
	};

	// surrender and fleeing updates.
	{
		if (alive _x) then {
			if (fleeing _x) then {
				if !(_x getVariable ["surrendered",false]) then {
					if ((vehicle _x == _x) and {[100, _x, "BLUFORSpawn", "boolean"] call AS_fnc_unitsAtDistance}) then {
						[_x] spawn AS_AI_fnc_surrender;
					} else {
						if (_x == leader group _x) then {
							if (random 1 < 0.1) then {
								_enemy = _x findNearestEnemy _x;
								if (!isNull _enemy) then {
									[position _enemy, "AS_movement_fnc_sendAAFpatrol"] remoteExec ["AS_scheduler_fnc_execute", 2];
								};
							};
						};
					[_x,_x] spawn AS_AI_fnc_smokeCover;
					};
				};
			} else {
				if (random 1 < 0.5) then {_x allowFleeing (0.5 -(_x skill "courage") + (({(!alive _x) or (_x getVariable ["surrendered",false])} count units _group)/(count units _group)))};
			};
		};
	} forEach units _group;
};
