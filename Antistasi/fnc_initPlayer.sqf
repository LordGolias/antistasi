#include "macros.hpp"
waitUntil {!isNull player};
waitUntil {player == player};

if hayACEhearing then {player addItem "ACE_EarPlugs"};

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

[] execVM "reinitY.sqf";
[] spawn AS_fnc_UI_showTopBar;

[player] execVM "OrgPlayers\unitTraits.sqf";
[] spawn AS_fnc_activatePlayerRankLoop;
