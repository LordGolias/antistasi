#include "macros.hpp"
waitUntil {!isNull player};
waitUntil {player == player};

if hayACEhearing then {player addItem "ACE_EarPlugs"};

player setVariable ["AS_side", "FIA", true];

player call AS_fnc_initMedical;

player setPos ((getMarkerPos "FIA_HQ") findEmptyPosition [2, 10, typeOf (vehicle player)]);

player addEventHandler ["WeaponAssembled", {
	params ["_EHunit", "_EHobj"];
	if (_EHobj isKindOf "StaticWeapon") then {
		if !(_EHobj in AS_P("vehicles")) then {
            [_EHobj] call remoteExec ["AS_fnc_addPersistentVehicles", 2];
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
					if (player distance petros < 10) then {[player,60] spawn castigo};
				};
			};
		};
	}];
};

[] execVM "reinitY.sqf";
[] execVM "statistics.sqf";

[player] execVM "OrgPlayers\unitTraits.sqf";
[] spawn rankCheck;
