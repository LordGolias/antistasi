#include "macros.hpp"
waitUntil {!isNull player};
waitUntil {player == player};

if hasACEhearing then {player addItem "ACE_EarPlugs"};

[player, "FIA"] call AS_fnc_setSide;

player addEventHandler ["HandleDamage", AS_fnc_EH_handleDamage_AIcontrol];
player call AS_medical_fnc_initUnit;

player setPos ((getMarkerPos "FIA_HQ") findEmptyPosition [2, 10, typeOf (vehicle player)]);

player addEventHandler ["WeaponAssembled", {
	params ["_EHunit", "_EHobj"];
	if (_EHobj isKindOf "StaticWeapon") then {
		if !(_EHobj in AS_P("vehicles")) then {
            [_EHobj] remoteExec ["AS_fnc_changePersistentVehicles", 2];
		};
	};
    [_EHobj, "FIA"] call AS_fnc_initVehicle;
}];

player addEventHandler ["WeaponDisassembled", {
    [_this select 1, "FIA"] call AS_fnc_initVehicle;
	[_this select 2, "FIA"] call AS_fnc_initVehicle;
}];

if (isMultiplayer) then {
    player addEventHandler ["Fired", {
		private _tipo = _this select 1;
		if ((_tipo == "Put") or (_tipo == "Throw")) then {
			if (player distance petros < 50) then {
				deleteVehicle (_this select 6);
				if (_tipo == "Put") then {
					if (player distance petros < 10) then {[player,60] spawn AS_fnc_penalizePlayer};
				};
			};
		};
	}];
};

player addEventHandler ["GetInMan", {
    params ["_unit", "_seat", "_vehicle"];
	private _exit = false;
	if isMultiplayer then {
		private _owner = _vehicle getVariable "AS_vehOwner";
		if (!isNil "_owner" and
            {{getPlayerUID _x == _owner} count (units group player) == 0}) then {
			hint "You can only enter in other's vehicle if you are in its group";
			moveOut _unit;
			_exit = true;
		};
	};
	if not _exit then {
		[false] spawn AS_fnc_activateUndercover;

		if (_seat == "driver" and _vehicle isKindOf "Truck_F") then {
			private _EHid = [_vehicle, "transferFrom"] call AS_fnc_addAction;
			player setVariable ["transferID", _EHid];
		};
	};
}];

player addEventHandler ["GetOutMan", {
    params ["_unit", "_seat", "_vehicle"];
	if ((player getVariable ["transferID", -1]) != -1) then {
		_vehicle removeAction (player getVariable "transferID");
		player setVariable ["transferID", nil];
	};
}];
