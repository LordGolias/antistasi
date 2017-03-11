private ["_killed","_killer","_cost","_enemy","_group"];
_killed = _this select 0;
_killer = _this select 1;
if (_killed getVariable ["OPFORSpawn",false]) then {_killed setVariable ["OPFORSpawn",nil,true]};
[_killed] spawn postmortem;

if (hayACE) then {
	if ((isNull _killer) || (_killer == _killed)) then {
		_killer = _killed getVariable ["ace_medical_lastDamageSource", _killer];
	};
};

if ((side _killer == side_blue) || (captive _killer)) then {
	if (hayBE) then {["kill"] remoteExec ["fnc_BE_XP", 2]};
	_group = group _killed;
	
	// scoring and captive.
	if (isPlayer _killer) then {
		[2,_killer,false] call playerScoreAdd;
	} else {
		_skill = skill _killer;
		[_killer,_skill + 0.05] remoteExec ["setSkill",_killer];
	};

	// if dead has no weapons, AAF support increases by 2.
	if (count weapons _killed < 1) then {
		[-1,0] remoteExec ["prestige",2];
		[2,0,getPos _killed] remoteExec ["citySupportChange",2];
		if (isPlayer _killer) then {_killer addRating -1000};
	} else {
		// otherwise, it decreases by -0.5.
		_cost = server getVariable (typeOf _killed);
		if (isNil "_cost") then {diag_log format ["Cost of %1 not defined.",typeOf _killed]; _cost = 0};
		[-_cost] remoteExec ["resourcesAAF",2];
		[-0.5,0,getPos _killed] remoteExec ["citySupportChange",2];
	};

	// surrender and fleeing updates.
	{
		if (alive _x) then {
			if (fleeing _x) then {
				if !(_x getVariable ["surrendered",false]) then {
					if (([100,1,_x,"BLUFORSpawn"] call distanceUnits) and (vehicle _x == _x)) then {
						[_x] spawn surrenderAction;
					} else {
						if (_x == leader group _x) then {
							if (random 1 < 0.1) then {
								_enemy = _x findNearestEnemy _x;
								if (!isNull _enemy) then {
									[position _enemy] remoteExec ["patrolCA",HCattack];
								};
							};
						};
					[_x,_x] spawn cubrirConHumo;
					};
				};
			} else {
				if (random 1 < 0.5) then {_x allowFleeing (0.5 -(_x skill "courage") + (({(!alive _x) or (_x getVariable ["surrendered",false])} count units _group)/(count units _group)))};
			};
		};
	} forEach units _group;
};