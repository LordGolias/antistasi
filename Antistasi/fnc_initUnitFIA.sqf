#include "macros.hpp"
params ["_unit", ["_spawned", true], ["_place", nil], ["_equipment", []]];

[_unit] call AS_DEBUG_initUnit;

if (_spawned) then {
	_unit setVariable ["BLUFORSpawn",true,true];
}
else {
	if (!isNil "_place") then {_unit setVariable ["marcador", _place]};
};

[_unit] call AS_fnc_initMedical;
_unit allowFleeing 0;

[_unit, AS_P("skillFIA")] call AS_fnc_setDefaultSkill;

if (count _equipment == 0) then {
    _equipment = [[_unit] call AS_fnc_getFIAUnitType] call AS_fnc_getBestEquipment;
};
[_unit, _equipment] call AS_fnc_equipUnit;

if (player == leader _unit) then {
	if ([_unit] call AS_fnc_getFIAUnitType != "Survivor") then {
		private _idUnit = selectRandom namesFIASoldiers;
		namesFIASoldiers = namesFIASoldiers - [_idunit];
		_unit setIdentity _idUnit;
		if (captive player) then {[_unit] spawn undercoverAI};
	};

	_unit addEventHandler ["killed", {
		params ["_unit"];
		[_unit] remoteExec ["postmortem",2];

		if ([_unit] call AS_fnc_getFIAUnitType != "Survivor") then {
			namesFIASoldiers = namesFIASoldiers + [name _unit];
		};
		[0.25,0,getPos _unit] remoteExec ["citySupportChange",2];
		_unit setVariable ["BLUFORSpawn",nil,true];
	}];

	_unit setVariable ["rearming",false];
	if !("ItemRadio" in unlockedItems) then {
		while {alive _unit} do {
			sleep 10;
			if (("ItemRadio" in assignedItems _unit) and ([player] call hasRadio)) exitWith {_unit groupChat format ["This is %1, radiocheck OK",name _unit]};
			if (unitReady _unit) then {
				if ((alive _unit) and (_unit distance (getMarkerPos "FIA_HQ") > 50) and (_unit distance leader group _unit > 500) and ((vehicle _unit == _unit) or ((typeOf (vehicle _unit)) in arrayCivVeh))) then {
					hint format ["%1 lost communication, he will come back with you if possible", name _unit];
					[_unit] join MIASquadUnits;
					if ((vehicle _unit isKindOf "StaticWeapon") or (isNull (driver (vehicle _unit)))) then {unassignVehicle _unit; [_unit] orderGetIn false};
					_unit doMove position player;
					private _tiempo = time + 900;
					waitUntil {sleep 1;(!alive _unit) or (_unit distance player < 500) or (time > _tiempo)};
					if ((_unit distance player >= 500) and (alive _unit)) then {_unit setPos (getMarkerPos "FIA_HQ")};
					[_unit] join group player;
				};
			};
		};
	};

	_unit addEventHandler ["GetInMan", {
		private ["_soldier","_veh"];
		_soldier = _this select 0;
		_veh = _this select 2;

		if (((typeOf _veh) in arrayCivVeh) || ((typeOf _veh) == civHeli)) then {
			if !(_veh in reportedVehs) then {
				[_soldier] spawn undercoverAI;
			};
		};
	}];
} else {
	_unit addEventHandler ["killed", {
		params ["_unit", "_killer"];
		[_unit] remoteExec ["postmortem",2];

		// player team-kill
		if (isPlayer _killer) then {
			[-20,_killer,false] remoteExec ["AS_fnc_changePlayerScore", 2];
		};
		[0,-0.25,getPos _unit] remoteExec ["citySupportChange",2];

		if (_unit getVariable ["BLUFORSpawn",false]) then {
			_unit setVariable ["BLUFORSpawn",nil,true];
		};

		private _location = _unit getVariable "marcador";
		if (!isNil "_location") then {
			if (_location call AS_fnc_location_side == "FIA") then {
				private _garrison = _location call AS_fnc_location_garrison;
				for "_i" from 0 to (count _garrison -1) do {
					if (typeOf _unit == (_garrison select _i)) exitWith {_garrison deleteAt _i};
				};
				[_location, "garrison", _garrison] call AS_fnc_location_set;
			};
		};
	}];
};
