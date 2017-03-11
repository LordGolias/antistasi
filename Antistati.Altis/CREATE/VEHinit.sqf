private ["_veh","_tipo"];

_veh = _this select 0;

if ((_veh isKindOf "FlagCarrier") or (_veh isKindOf "Building")) exitWith {};
if (_veh isKindOf "ReammoBox_F") exitWith {[_veh] call cajaAAF};
if ((hayACE) && !(random 8 < 1)) then {_veh setVariable ["ace_cookoff_enable", false, true]};

if (_veh isKindOf "Car") then
	{
	_veh addEventHandler ["HandleDamage",{if (((_this select 1) find "wheel" != -1) and (_this select 4=="") and (!isPlayer driver (_this select 0))) then {0;} else {(_this select 2);};}];
	};

_tipo = typeOf _veh;

if ((_tipo in vehNATO) or (_tipo in planesNATO)) then
	{
	clearMagazineCargoGlobal _veh;
	clearWeaponCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	_veh lock 3;
	_veh addEventHandler ["GetIn",
		{
		_unit = _this select 2;
		if ({isPlayer _x} count units group _unit > 0) then {moveOut _unit;};
		}];
	_veh addEventHandler ["killed",{[-2,0] remoteExec ["prestige",2]; [2,-2,position (_this select 0)] remoteExec ["citySupportChange",2]}];
	}
else
	{
	if ((_tipo in vehTrucks) or (_tipo in vehPatrol) or (_tipo in vehSupply) or (_tipo in vehAAFAT) or (_tipo == "I_Boat_Armed_01_minigun_F")) then
		{
		if ((_tipo in vehTrucks) or (_tipo in vehPatrol) or (_tipo in vehSupply) or (_tipo == "I_Boat_Armed_01_minigun_F")) then
			{
			if (_tipo == vehAmmo) then
				{
				if (_veh distance getMarkerPos "respawn_west" > 50) then {[_veh] call cajaAAF};
				};
			_veh addEventHandler ["killed",{
				[-1000] remoteExec ["resourcesAAF",2];
				if (hayBE) then {["des_veh"] remoteExec ["fnc_BE_XP", 2]};
			}];
			}
		else
			{
			if ((_tipo in vehAPC) or (_tipo in vehIFV)) then
				{
				_veh addEventHandler ["killed",{
					[_this select 0] call AAFassets;
					[-2,2,position (_this select 0)] remoteExec ["citySupportChange",2];
					if (hayBE) then {["des_arm"] remoteExec ["fnc_BE_XP", 2]};
				}];
				_veh addEventHandler ["HandleDamage",{private ["_veh"]; _veh = _this select 0; if (_this select 1 == "") then {if ((_this select 2 > 0.9) and (!isNull driver _veh)) then {[_veh] call smokeCoverAuto}}}];
				}
			else
				{
				if (_tipo in vehTank) then
					{
					_veh addEventHandler ["killed",{
						[_this select 0] call AAFassets;
						[-5,5,position (_this select 0)] remoteExec ["citySupportChange",2];
						if (hayBE) then {["des_arm"] remoteExec ["fnc_BE_XP", 2]};
					}];
					_veh addEventHandler ["HandleDamage",{private ["_veh"]; _veh = _this select 0; if (_this select 1 == "") then {if ((_this select 2 > 0.9) and (!isNull driver _veh)) then {[_veh] call smokeCoverAuto}}}];
					};
				};
			};
		}
	else
		{
		if ((_tipo in planesAAF) or (_tipo == civHeli) or (_tipo in opAir)) then
			{
			_veh addEventHandler ["GetIn",
				{
				_posicion = _this select 1;
				if (_posicion == "driver") then
					{
					_unit = _this select 2;
					if ((!isPlayer _unit) and (_unit getVariable ["BLUFORSpawn",false])) then
						{
						moveOut _unit;
						hint "Only Humans can pilot an air vehicle";
						};
					};
				}];
			if (_tipo in heli_unarmed) then
				{
				_veh addEventHandler ["killed",{
					[-4000] remoteExec ["resourcesAAF",2];
					if (hayBE) then {["des_veh"] remoteExec ["fnc_BE_XP", 2]};
				}];
				}
			else
				{
				if (not(_tipo in opAir)) then
					{
					if (_veh isKindOf "Helicopter") then {_veh addEventHandler ["killed",{[_this select 0] call AAFassets;[1,1] remoteExec ["prestige",2]; [-2,2,position (_this select 0)] remoteExec ["citySupportChange",2]}]};
					if (_veh isKindOf "Plane") then {_veh addEventHandler ["killed",{[_this select 0] call AAFassets;[2,1] remoteExec ["prestige",2]; [-5,5,position (_this select 0)] remoteExec ["citySupportChange",2]}]};
					}
				else
					{
					_veh addEventHandler ["killed",{[2,-2] remoteExec ["prestige",2]; [-5,5,position (_this select 0)] remoteExec ["citySupportChange",2]}];
					};
				};
			}
		else
			{
			if (_tipo == indUAV_large) then
				{
				_veh addEventHandler ["killed",{[-2500] remoteExec ["resourcesAAF",2]}];
				}
			else
				{
				if (_tipo in (arrayCivVeh + [civHeli])) then
					{/*
					_veh addEventHandler ["GetIn",
						{
						_veh = _this select 0;
						_unit = _this select 2;
						if (not(_veh in reportedVehs)) then
							{
							if (isPlayer _unit) then {[] remoteExec ["undercover",_unit]};
							};
						}
						];*/
					}
				else
					{
					if ((_veh isKindOf "StaticWeapon") and (not (_veh in staticsToSave)) and ((side gunner _veh == side_green) or (side gunner _veh == side_red))) then
						{
						[[_veh,"steal"],"flagaction"] call BIS_fnc_MP;
						}
					else
						{
						if (_tipo in allStatMortars) then
							{
							if (!isNull gunner _veh) then {[[_veh,"steal"],"flagaction"] call BIS_fnc_MP};
							_eh = _veh addEventHandler ["Fired",
								{
								if (random 8 < 1) then
									{
									_mortero = _this select 0;
									if (_mortero distance posHQ < 200) then
										{
										if (!("DEF_HQ" in misiones)) then
											{
											_lider = leader (gunner _mortero);
											if (!isPlayer _lider) then
												{
												[] remoteExec ["ataqueHQ",HCattack];
												}
											else
												{
												if ([_lider] call isMember) then {[] remoteExec ["ataqueHQ",HCattack]};
												};
											};
										}
									else
										{
										[position _mortero] remoteExec ["patrolCA",HCattack];
										};
									};
								}];
							};
						};
					};
				};
			};
		};
	};

[_veh] spawn cleanserVeh;

_veh addEventHandler ["Killed",{[_this select 0] remoteExec ["postmortem",2]}];

if (not(_veh in staticsToSave)) then
	{
	if ((count crew _veh) > 0) then
		{
		[_veh] spawn VEHdespawner
		}
	else
		{
		if (_veh distance getMarkerPos "respawn_west" > 50) then
			{
			if (_tipo in (arrayCivVeh + [civHeli])) then
				{
				sleep 10;
				_veh enableSimulationGlobal false;
				_veh addEventHandler ["HandleDamage",
					{
					_veh = _this select 0;
					if (!simulationEnabled _veh) then {_veh enableSimulationGlobal true};
					}
					];
				};
			_veh addEventHandler ["GetIn",
				{
				_veh = _this select 0;
				if (!simulationEnabled _veh) then {_veh enableSimulationGlobal true};
				[_veh] spawn VEHdespawner;
				}
				];
			}
		else
			{
			clearMagazineCargoGlobal _veh;
			clearWeaponCargoGlobal _veh;
			clearItemCargoGlobal _veh;
			clearBackpackCargoGlobal _veh;
			};
		};
	};
