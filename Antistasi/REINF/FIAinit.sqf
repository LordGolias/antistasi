params ["_unit"];
private ["_tipo"];

_unit setVariable ["BLUFORSpawn",true,true];

[_unit] call initRevive;
_unit allowFleeing 0;

[_unit, server getVariable "skillFIA"] call AS_fnc_setDefaultSkill;

_tipo = typeOf _unit;

if !("ItemRadio" in unlockedItems) then {
	if ((_unit != leader _unit) && (_tipo != "b_g_soldier_unarmed_f")) then {_unit unlinkItem "ItemRadio"};
};

if (player == leader _unit) then {
	_EHkilledIdx = _unit addEventHandler ["killed", {
		_muerto = _this select 0;
		[_muerto] remoteExec ["postmortem",2];

		if (typeOf _muerto != "b_g_survivor_F") then {namesFIASoldiers = namesFIASoldiers + [name _muerto]};
		[0.25,0,getPos _muerto] remoteExec ["citySupportChange",2];
		_muerto setVariable ["BLUFORSpawn",nil,true];
	}];
	if (_tipo != "b_g_survivor_F") then {
		_idUnit = namesFIASoldiers call BIS_Fnc_selectRandom;
		namesFIASoldiers = namesFIASoldiers - [_idunit];
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
					[_unit] join MIASquadUnits;
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
		_muerto setVariable ["BLUFORSpawn",nil,true];
		[0,-0.25,getPos _muerto] remoteExec ["citySupportChange",2];
	}];
};