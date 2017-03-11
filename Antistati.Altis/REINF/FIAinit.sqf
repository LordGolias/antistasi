private ["_unit","_muerto","_killer","_skill","_nombre","_tipo"];

_unit = _this select 0;

[_unit] call initRevive;
_unit setVariable ["BLUFORSpawn",true,true];

_skillFIA = server getVariable "skillFIA";

_unit allowFleeing 0;
_skill = 0.2 + (_skillFIA * 0.04);
if ((!isMultiplayer) and (leader _unit == stavros)) then {_skill = _skill + 0.2};
_unit setSkill _skill;
_aiming = _skill;
_spotD = _skill;
_spotT = _skill;
_cour = _skill;
_comm = _skill;
_aimingSh = _skill;
_aimingSp = _skill;
_reload = _skill;

_tipo = typeOf _unit;
_skillSet = 0;

if !("ItemRadio" in unlockedItems) then {
	if ((_unit != leader _unit) && (_tipo != "b_g_soldier_unarmed_f")) then {_unit unlinkItem "ItemRadio"};
};

if !(hayRHS) then {
	call {
		if (_tipo == "B_G_Soldier_LAT_F") exitWith {
			if ("launch_I_Titan_short_F" in unlockedWeapons) then {
				_unit removeMagazines "RPG32_F";
				_unit removeMagazines "RPG32_HE_F";
				_unit removeWeaponGlobal "launch_RPG32_F";
				[_unit, "launch_I_Titan_short_F", 4, 0] call BIS_fnc_addWeapon;
			}
			else {
				if ("launch_NLAW_F" in unlockedWeapons) then {
					_unit removeMagazines "RPG32_F";
					_unit removeMagazines "RPG32_HE_F";
					_unit removeWeaponGlobal "launch_RPG32_F";
					[_unit, "launch_NLAW_F", 4, 0] call BIS_fnc_addWeapon;
				};
			};
			[_unit,true,true,true,false] call randomRifle;
		};

		if (_tipo == "B_G_Soldier_F") exitWith {
			[_unit,true,true,true,true] call randomRifle;
			if (loadAbs _unit < 340) then {
				if ((random 20 < _skillFIA) && ("launch_I_Titan_F" in unlockedWeapons)) then {
					removeBackpackGlobal _unit;
					_unit addBackpackGlobal "B_AssaultPack_blk";
					[_unit, "launch_I_Titan_F", 2, 0] call BIS_fnc_addWeapon;
					removeBackpackGlobal _unit;
				}
				else {
					if ((random 20 < _skillFIA) && ("launch_NLAW_F" in unlockedWeapons)) then {
						removeBackpackGlobal _unit;
						_unit addBackpackGlobal "B_AssaultPack_blk";
						[_unit, "launch_NLAW_F", 2, 0] call BIS_fnc_addWeapon;
						removeBackpackGlobal _unit;
					};
				};
			};
		};

		if (_tipo == "B_G_Soldier_GL_F") exitWith {
			[_unit,false,true,true,false] call randomRifle;
		};

		if (_tipo == "B_G_Soldier_lite_F") exitWith {
			[_unit,true,true,true,true] call randomRifle;
			_skillSet = 1;
		};

		if (_tipo == "b_g_soldier_unarmed_f") exitWith {
			_skillSet = 1;
		};

		if (_tipo == "B_G_Soldier_SL_F") exitWith {
			[_unit,false,true,true,false] call randomRifle;
			_skillSet = 2;
		};

		if (_tipo == "B_G_Soldier_TL_F") exitWith {
			[_unit,false,true,true,false] call randomRifle;
			_skillSet = 3;
		};

		if (_tipo == "B_G_Soldier_AR_F") exitWith {
			[_unit,false,true,true,false] call randomRifle;
			_skillSet = 4;
		};

		if (_tipo == "B_G_medic_F") exitWith {
			_skillSet = 5;
			[_unit,true,true,true,false] call randomRifle;
		};

		if (_tipo == "B_G_engineer_F") exitWith {
			_skillSet = 5;
			[_unit,true,true,true,false] call randomRifle;
		};

		if (_tipo == "B_G_Soldier_exp_F") exitWith {
			_skillSet = 5;
			[_unit,true,true,true,false] call randomRifle;
			_unit addmagazine atMine;
		};

		if (_tipo == "B_G_Soldier_A_F") exitWith {
			_skillSet = 5;
			[_unit,true,true,true,false] call randomRifle;
		};

		if (_tipo == "B_G_Soldier_M_F") exitWith {
			if ("srifle_GM6_F" in unlockedWeapons) then {
				_mag = currentMagazine _unit;
				_unit removeMagazines _mag;
				_unit removeWeaponGlobal (primaryWeapon _unit);
				[_unit, "srifle_GM6_SOS_F", 8, 0] call BIS_fnc_addWeapon;
			};
			_skillSet = 6;
		};

		if (_tipo == "B_G_Sharpshooter_F") exitWith {
			_skillSet = 6;
		};
	};
}
else {

	removeVest _unit;
	_unit addVest "V_Chestrig_oli";
	_unit addItem "FirstAidKit";
	_unit addItem "FirstAidKit";
	_unit addMagazine "rhs_mag_rdg2_white";
	_unit addMagazine "rhs_mag_rgd5";

	call {
		if (_tipo == "B_G_Soldier_LAT_F") exitWith {
			_unit removeMagazines "RPG32_F";
			_unit removeMagazines "RPG32_HE_F";
			_unit removeWeaponGlobal "launch_RPG32_F";
			removeBackpackGlobal _unit;

			if ("rhs_weap_rpg7" in unlockedWeapons) then {
				_unit addBackpackGlobal "rhs_rpg_empty";
				[_unit, "rhs_weap_rpg7", 3, 0] call BIS_fnc_addWeapon;
				}
			else {
				if ("rhs_weap_rpg26" in unlockedWeapons) then {
					_unit addBackpack "B_AssaultPack_blk";
					[_unit, "rhs_weap_rpg26", 1] call BIS_fnc_addWeapon;
				};
			};
			[_unit,true,true,true,false] call randomRifle;
		};

		if (_tipo == "B_G_Soldier_F") exitWith {
			[_unit,true,true,true,true] call randomRifle;
			if ((random 25 < _skillFIA) and ("rhs_weap_igla" in unlockedWeapons)) then {
				removeBackpackGlobal _unit;
				_unit addBackpack "B_AssaultPack_blk";
				[_unit, "rhs_weap_igla", 2, 0] call BIS_fnc_addWeapon;
				removeBackpackGlobal _unit;
			}
			else {
				if ((random 25 < _skillFIA) and ("rhs_weap_rpg26" in unlockedWeapons)) then {
					[_unit, "rhs_weap_rpg26", 1] call BIS_fnc_addWeapon;
				};
			};
		};

		if (_tipo == "B_G_Soldier_GL_F") exitWith {
			removeAllItemsWithMagazines _unit;
			_unit removeWeaponGlobal (primaryWeapon _unit);
			removeBackpackGlobal _unit;
			_unit addBackpackGlobal "rhs_sidor";
			[_unit,false,true,true,true] call randomRifle;
			for "_i" from 1 to 4 do {_unit addMagazineGlobal "rhs_VOG25";};
			[_unit, "rhs_weap_akms_gp25", 4, "rhs_30Rnd_762x39mm"] call BIS_fnc_addWeapon;
		};

		if (_tipo == "B_G_Soldier_lite_F") exitWith {
			[_unit,true,true,true,true] call randomRifle;
			_skillSet = 1;
		};

		if (_tipo == "b_g_soldier_unarmed_f") exitWith {
			_skillSet = 1;
		};

		if (_tipo == "B_G_Soldier_SL_F") exitWith {
			_skillSet = 2;
			removeAllItemsWithMagazines _unit;
			removeBackpackGlobal _unit;
			_unit addBackpackGlobal "rhs_sidor";
			_unit removeWeaponGlobal (primaryWeapon _unit);
			[_unit,false,true,true,false] call randomRifle;
			for "_i" from 1 to 6 do {_unit addMagazineGlobal "rhs_VOG25";};
			[_unit, "rhs_weap_ak74m_gp25", 4, "rhs_30Rnd_545x39_7N10_AK"] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem "rhs_acc_1p29";
			_unit addMagazineGlobal "SmokeShell";
			_unit addMagazineGlobal "SmokeShell";
		};

		if (_tipo == "B_G_Soldier_TL_F") exitWith {
			removeAllItemsWithMagazines _unit;
			removeBackpackGlobal _unit;
			_unit addBackpackGlobal "rhs_sidor";
			_unit removeWeaponGlobal (primaryWeapon _unit);
			[_unit,false,true,true,false] call randomRifle;
			for "_i" from 1 to 6 do {_unit addMagazineGlobal "rhs_VOG25";};
			[_unit, "rhs_weap_ak74m_gp25", 4, "rhs_30Rnd_545x39_7N10_AK"] call BIS_fnc_addWeapon;
			_unit addPrimaryWeaponItem "rhs_acc_1p29";
			_unit addMagazineGlobal "SmokeShell";
			_unit addMagazineGlobal "SmokeShell";
			_skillSet = 3;
		};

		if (_tipo == "B_G_Soldier_AR_F") exitWith {
			removeAllItemsWithMagazines _unit;
			[_unit,false,true,true,true] call randomRifle;
			_unit removeWeaponGlobal (primaryWeapon _unit);
			removeBackpackGlobal _unit;
			_unit addBackpackGlobal "rhs_sidor";
			[_unit, "rhs_weap_pkm", 3, "rhs_100Rnd_762x54mmR"] call BIS_fnc_addWeapon;
			_skillSet = 4;
		};

		if (_tipo == "B_G_medic_F") exitWith {
			removeVest _unit;
			_unit addVest "rhs_6b23_digi_medic";
			removeAllItemsWithMagazines _unit;
			_unit removeWeaponGlobal (primaryWeapon _unit);
			[_unit,false,true,true,false] call randomRifle;
			removeBackpackGlobal _unit;
			_unit addBackpack "rhs_assault_umbts_medic";
			_unit addMagazine "rhs_mag_rdg2_white";
			_unit addMagazine "rhs_mag_rdg2_white";
			[_unit, "rhs_weap_aks74u", 4, "rhs_30Rnd_545x39_7N10_AK"] call BIS_fnc_addWeapon;
			_skillSet = 5;
		};

		if (_tipo == "B_G_engineer_F") exitWith {
			removeVest _unit;
			_unit addVest "rhs_6b23_digi_engineer";
			removeAllItemsWithMagazines _unit;
			_unit removeWeaponGlobal (primaryWeapon _unit);
			[_unit,false,true,true,false] call randomRifle;
			removeBackpackGlobal _unit;
			_unit addBackpackGlobal "rhs_assault_umbts_engineer";
			[_unit, "rhs_weap_aks74u", 4, "rhs_30Rnd_545x39_7N10_AK"] call BIS_fnc_addWeapon;
			_skillSet = 5;
		};

		if (_tipo == "B_G_Soldier_exp_F") exitWith {
			_skillSet = 5;
			[_unit,true,true,true,true] call randomRifle;
			removeBackpackGlobal _unit;
			_unit addBackpackGlobal "B_Carryall_oli";
			_unit addItemToBackpack atMine;
			_unit addItem "SatchelCharge_Remote_Mag";
			_unit addItem "DemoCharge_Remote_Mag";
		};

		if (_tipo == "B_G_Soldier_A_F") exitWith {
			_skillSet = 5;
			[_unit,true,true,true,false] call randomRifle;
		};

		if (_tipo == "B_G_Soldier_M_F") exitWith {
			_mag = currentMagazine _unit;
			_unit removeMagazines _mag;
			_unit removeWeaponGlobal (primaryWeapon _unit);
			if !("srifle_GM6_F" in unlockedWeapons) then {
				[_unit, "rhs_weap_svdp_wd", 8, 0] call BIS_fnc_addWeapon; _unit addPrimaryWeaponItem "rhs_acc_pso1m2";
			}
			else {
				[_unit, "srifle_GM6_SOS_F", 5, 0] call BIS_fnc_addWeapon;
			};
			_skillSet = 6;
		};

		if (_tipo == "B_G_Sharpshooter_F") exitWith {
			_mag = currentMagazine _unit;
			_unit removeMagazines _mag;
			_unit removeWeaponGlobal (primaryWeapon _unit);
			if !("srifle_GM6_F" in unlockedWeapons) then {
				[_unit, "rhs_weap_svdp_wd", 8, 0] call BIS_fnc_addWeapon; _unit addPrimaryWeaponItem "rhs_acc_pso1m2";
			}
			else {
				[_unit, "srifle_GM6_SOS_F", 5, 0] call BIS_fnc_addWeapon;
			};
			_skillSet = 6;
		};
	};
};

call {
	if (_skillSet == 0) exitWith {
		_aiming = _aiming -0.2;
		_aimingSh = _aimingSh - 0.2;
		_aimingSp = _aimingSp - 0.2;
		_reload = _reload - 0.2;
	};

	if (_skillSet == 1) exitWith {
		_aiming = _aiming -0.1;
		_spotD = _spotD - 0.1;
		_aimingSh = _aimingSh - 0.1;
		_aimingSp = _aimingSp + 0.2;
		_reload = _reload + 0.1;
	};

	if (_skillSet == 2) exitWith {
		_aiming = _aiming - 0.1;
		_spotD = _spotD + 0.2;
		_spotT = _spotT + 0.2;
		_cour = _cour + 0.1;
		_comm = _comm + 0.2;
		_aimingSh = _aimingSh - 0.1;
		_aimingSp = _aimingSp - 0.1;
		_reload = _reload - 0.2;
	};

	if (_skillSet == 3) exitWith {
		_aiming = _aiming + 0.1;
		_spotD = _spotD + 0.1;
		_spotT = _spotT + 0.1;
		_cour = _cour + 0.1;
		_comm = _comm + 0.1;
		_aimingSh = _aimingSh - 0.1;
		_aimingSp = _aimingSp - 0.1;
		_reload = _reload - 0.1;
	};

	if (_skillSet == 4) exitWith {
		_aiming = _aiming - 0.1;
		_aimingSh = _aimingSh + 0.2;
		_aimingSp = _aimingSp - 0.2;
		_reload = _reload - 0.2;
	};

	if (_skillSet == 5) exitWith {
		_aiming = _aiming - 0.1;
		_spotD = _spotD - 0.1;
		_spotT = _spotT - 0.1;
		_aimingSh = _aimingSh - 0.1;
		_aimingSp = _aimingSp - 0.1;
		_reload = _reload - 0.1;
	};

	if (_skillSet == 6) exitWith {
		_aiming = _aiming + 0.2;
		_spotD = _spotD + 0.4;
		_spotT = _spotT + 0.2;
		_cour = _cour - 0.1;
		_comm = _comm - 0.1;
		_aimingSh = _aimingSh + 0.1;
		_aimingSp = _aimingSp + 0.1;
		_reload = _reload - 0.4;
	};
};

_unit selectWeapon (primaryWeapon _unit);

if (sunOrMoon < 1) then {
	if (indNVG in unlockedItems) then {
		_unit linkItem indNVG;
		if (indLaser in unlockedItems) then {
			_unit addPrimaryWeaponItem indLaser;
	        _unit assignItem indLaser;
	        _unit enableIRLasers true;
		};
	}
	else {
		if (indFL in unlockedItems) then {
			_unit unassignItem indLaser;
	        _unit removePrimaryWeaponItem indLaser;
	        _unit addPrimaryWeaponItem indFL;
	        _unit enableGunLights "forceOn";
			_spotD = ((_spotD - 0.2) max 0.2);
			_spotT = ((_spotT - 0.2) max 0.2);
	    };
	};
};

if ((_tipo != "B_G_Soldier_M_F") and (_tipo != "B_G_Sharpshooter_F")) then {if (_aiming > 0.35) then {_aiming = 0.35}};

_unit setskill ["aimingAccuracy",_aiming];
_unit setskill ["spotDistance",_spotD];
_unit setskill ["spotTime",_spotT];
_unit setskill ["courage",_cour];
_unit setskill ["commanding",_comm];
_unit setskill ["aimingShake",_aimingSh];
_unit setskill ["aimingSpeed",_aimingSp];
_unit setskill ["reloadSpeed",_reload];

if (player == leader _unit) then {
	_EHkilledIdx = _unit addEventHandler ["killed", {
		_muerto = _this select 0;
		[_muerto] spawn postmortem;
		if (typeOf _muerto != "b_g_survivor_F") then {arrayids = arrayids + [name _muerto]};
		[0.25,0,getPos _muerto] remoteExec ["citySupportChange",2];
		_muerto setVariable ["BLUFORSpawn",nil,true];
	}];
	if (_tipo != "b_g_survivor_F") then {
		_idUnit = arrayids call BIS_Fnc_selectRandom;
		arrayids = arrayids - [_idunit];
		_unit setIdentity _idUnit;
		if (captive player) then {[_unit] spawn undercoverAI};
	};
	_unit setVariable ["rearming",false];
	if !("ItemRadio" in unlockedItems) then {
		while {alive _unit} do {
			sleep 10;
			if (("ItemRadio" in assignedItems _unit) and ([player] call hasRadio)) exitWith {_unit groupChat format ["This is %1, radiocheck OK",name _unit]};
			if (unitReady _unit) then {
				if ((alive _unit) and (_unit distance (getMarkerPos "respawn_west") > 50) and (_unit distance leader group _unit > 500) and ((vehicle _unit == _unit) or ((typeOf (vehicle _unit)) in arrayCivVeh))) then {
					hint format ["%1 lost communication, he will come back with you if possible", name _unit];
					[_unit] join rezagados;
					if ((vehicle _unit isKindOf "StaticWeapon") or (isNull (driver (vehicle _unit)))) then {unassignVehicle _unit; [_unit] orderGetIn false};
					_unit doMove position player;
					_tiempo = time + 900;
					waitUntil {sleep 1;(!alive _unit) or (_unit distance player < 500) or (time > _tiempo)};
					if ((_unit distance player >= 500) and (alive _unit)) then {_unit setPos (getMarkerPos "respawn_west")};
					[_unit] join group player;
				};
			};
		};
	};

	_unit addEventHandler ["GetInMan",
	{
	private ["_soldier","_veh"];
	_soldier = _this select 0;
	_veh = _this select 2;

	if (((typeOf _veh) in arrayCivVeh) || ((typeOf _veh) == civHeli)) then {
		if !(_veh in reportedVehs) then {
				[_soldier] spawn undercoverAI;
			};
	};
	}];
}
else {
	_EHkilledIdx = _unit addEventHandler ["killed", {
		_muerto = _this select 0;
		_killer = _this select 1;
		[_muerto] remoteExec ["postmortem",2];
		if (isPlayer _killer) then {
			if (!isMultiPlayer) then {
				[0,-20] remoteExec ["resourcesFIA",2];
				_killer addRating -1000;
			};
		};
		[_muerto] spawn postmortem;
		_muerto setVariable ["BLUFORSpawn",nil,true];
		[0,-0.25,getPos _muerto] remoteExec ["citySupportChange",2];
	}];
};