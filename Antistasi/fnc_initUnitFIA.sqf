#include "macros.hpp"
params ["_unit", ["_spawned", true], ["_place", nil], ["_equipment", []]];

[_unit, "FIA"] call AS_fnc_setSide;

[_unit] call AS_debug_fnc_initUnit;

if (_spawned) then {
	_unit setVariable ["BLUFORSpawn",true,true];
}
else {
	if (!isNil "_place") then {_unit setVariable ["marcador", _place]};
};

_unit addEventHandler ["HandleDamage", AS_fnc_EH_handleDamage_AIcontrol];
[_unit] call AS_medical_fnc_initUnit;
_unit allowFleeing 0;

[_unit, AS_P("skillFIA")] call AS_fnc_setDefaultSkill;

if (count _equipment == 0) then {
    _equipment = [[_unit] call AS_fnc_getFIAUnitType] call AS_fnc_getBestEquipment;
};
[_unit, _equipment] call AS_fnc_equipUnit;

if (player == leader _unit) then {
	if (captive player) then {[_unit] spawn AS_fnc_activateUndercoverAI};

	_unit addEventHandler ["killed", {
		params ["_unit"];
		[_unit] remoteExec ["AS_fnc_activateCleanup",2];

		[0.25,0,getPos _unit] remoteExec ["AS_fnc_changeCitySupport",2];
		_unit setVariable ["BLUFORSpawn",nil,true];
	}];

	_unit setVariable ["rearming",false];

	_unit addEventHandler ["GetInMan", {
		private ["_soldier","_veh"];
		_soldier = _this select 0;
		_veh = _this select 2;

		private _undercoverVehicles = (["CIV", "vehicles"] call AS_fnc_getEntity) + [civHeli];
		if ((typeOf _veh) in _undercoverVehicles) then {
			if !(_veh in AS_S("reportedVehs")) then {
				[_soldier] spawn AS_fnc_activateUndercoverAI;
			};
		};
	}];
} else {
	_unit addEventHandler ["killed", {
		params ["_unit", "_killer"];
		[_unit] remoteExec ["AS_fnc_activateCleanup",2];

		// player team-kill
		if (isPlayer _killer) then {
			[player, "score", -20, false] remoteExec ["AS_players_fnc_change", 2];
		};
		[0,-0.25,getPos _unit] remoteExec ["AS_fnc_changeCitySupport",2];

		if (_unit getVariable ["BLUFORSpawn",false]) then {
			_unit setVariable ["BLUFORSpawn",nil,true];
		};

		private _location = _unit getVariable "marcador";
		if (!isNil "_location") then {
			if (_location call AS_location_fnc_side == "FIA") then {
				private _garrison = _location call AS_location_fnc_garrison;
				_garrison deleteAt (_garrison find (_unit call AS_fnc_getFIAUnitType));
				[_location, "garrison", _garrison] call AS_location_fnc_set;
			};
		};
	}];
};

_unit enableIRLasers true;
_unit enableGunLights "AUTO";
