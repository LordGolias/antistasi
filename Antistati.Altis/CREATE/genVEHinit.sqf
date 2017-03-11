private ["_veh","_tipo"];

_veh = _this select 0;

if ((_veh isKindOf "FlagCarrier") or (_veh isKindOf "Building")) exitWith {};
if (_veh isKindOf "ReammoBox_F") exitWith {[_veh] call cajaAAF};
if ((hayACE) && !(random 8 < 1)) then {_veh setVariable ["ace_cookoff_enable", false, true]};

_tipo = typeOf _veh;

if ((hayACE) && (random 8 < 7)) then {_veh setVariable ["ace_cookoff_enable", false, true]};

if ((_tipo in vehTrucks) or (_tipo in vehPatrol) or (_tipo in vehSupply) or (_tipo in vehAAFAT) or (_tipo == "I_Boat_Armed_01_minigun_F")) then
	{
	if !(_tipo in vehAAFAT) then
		{
		if (_tipo == vehAmmo) then
			{
			if (_veh distance getMarkerPos "respawn_west" > 50) then {[_veh] call cajaAAF};
			};
		_veh addEventHandler ["killed",{
			[-1000] remoteExec ["resourcesAAF",2];
			if (hayBE) then {["des_veh"] remoteExec ["fnc_BE_XP", 2]};
		}];
		if (_veh isKindOf "Car") then
			{
			_veh addEventHandler ["HandleDamage",{if (((_this select 1) find "wheel" != -1) and (_this select 4=="") and (!isPlayer driver (_this select 0))) then {0;} else {(_this select 2);};}];
			};
		}
	else
		{
		if ((_tipo in vehAPC) or (_tipo in vehIFV)) then
			{
			_veh addEventHandler ["killed",{
				if (side (_this select 1) == side_blue) then {
					[_this select 0] call AAFassets;
					[-2,2,position (_this select 0)] remoteExec ["citySupportChange",2];
					if (hayBE) then {["des_arm"] remoteExec ["fnc_BE_XP", 2]};
				}
			}];
			_veh addEventHandler ["HandleDamage",{private ["_veh"]; _veh = _this select 0; if (!canFire _veh) then {[_veh] call smokeCoverAuto}}];
			}
		else
			{
			if (_tipo in vehTank) then
				{
				_veh addEventHandler ["killed",{
					if (side (_this select 1) == side_blue) then {
						[_this select 0] call AAFassets; call AAFassets;
						[-5,5,position (_this select 0)] remoteExec ["citySupportChange",2];
						if (hayBE) then {["des_arm"] remoteExec ["fnc_BE_XP", 2]};
					}
				}];
				_veh addEventHandler ["HandleDamage",{private ["_veh"]; _veh = _this select 0; if (!canFire _veh) then {[_veh] call smokeCoverAuto}}];
				};
			};
		};
	}
else
	{
	if (_tipo in planesAAF) then
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
			if (_veh isKindOf "Helicopter") then {_veh addEventHandler ["killed",{[_this select 0] call AAFassets;[1,1] remoteExec ["prestige",2]; [-2,2,position (_this select 0)] remoteExec ["citySupportChange",2]}]};
			if (_veh isKindOf "Plane") then {_veh addEventHandler ["killed",{[_this select 0] call AAFassets; call AAFassets;[2,1] remoteExec ["prestige",2]; [-5,5,position (_this select 0)] remoteExec ["citySupportChange",2]}]};
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
			if (_veh isKindOf "StaticWeapon") then
				{
				[[_veh,"steal"],"flagaction"] call BIS_fnc_MP;
				}
			};
		};
	};
[_veh] spawn cleanserVeh;

//_veh addEventHandler ["Killed",{[_this select 0] spawn postmortem}];

if ((count crew _veh) > 0) then
	{
	[_veh] spawn VEHdespawner
	}
else
	{
	_veh addEventHandler ["GetIn",
		{
		_veh = _this select 0;
		[_veh] spawn VEHdespawner;
		}
		];
	};