#include "macros.hpp"
waitUntil {!isNull player};
waitUntil {player == player};

if hayACEhearing then {player addItem "ACE_EarPlugs"};

if (!hayACEMedical) then {
    player call initRevive;
};

player setPos ((getMarkerPos "FIA_HQ") findEmptyPosition [2, 10, typeOf (vehicle player)]);

player addEventHandler ["WeaponAssembled", {
	params ["_EHunit", "_EHobj"];
	if (_EHobj isKindOf "StaticWeapon") then {
		if !(_EHobj in AS_P("vehicles")) then {
            [_EHobj] call remoteExec ["AS_fnc_addPersistentVehicles", 2];
		};
	};
    [_EHobj, "FIA"] call AS_fnc_initVehicle;
    _EHobj addEventHandler ["Killed",{[_this select 0] remoteExec ["postmortem",2]}];
}];

player addEventHandler ["WeaponDisassembled", {
    [_this select 1, "FIA"] call AS_fnc_initVehicle;
	[_this select 2, "FIA"] call AS_fnc_initVehicle;
}];

if (isMultiplayer) then {
	player addEventHandler ["InventoryOpened", {
        private _notAMemberMessage = "You are not in the Member's List of this Server.\n\n" +
    			             "Ask the Commander in order to be allowed to access the HQ Ammobox.\n\n"+
    				         "In the meantime you may use the other box to store equipment and share it with others.";
		private _control = false;
		if !([_this select 0] call isMember) then {
			if ((_this select 1 == caja) or ((_this select 0) distance caja < 3)) then {
				_control = true;
				hint _notAMemberMessage;
			};
		};
		_control
	}];

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

    player addEventHandler ["InventoryClosed", {
		[] spawn skillAdjustments;
	}];

	player addEventHandler ["Take", {
	    [] spawn skillAdjustments;
	}];

	[missionNamespace, "arsenalClosed", {[] spawn skillAdjustments;}] call BIS_fnc_addScriptedEventHandler;
};

[] execVM "reinitY.sqf";
[] execVM "statistics.sqf";

[player] execVM "OrgPlayers\unitTraits.sqf";
[] spawn rankCheck;
