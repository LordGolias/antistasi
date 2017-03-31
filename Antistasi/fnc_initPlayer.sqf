waitUntil {!isNull player};
waitUntil {player == player};

if (hayACEhearing) then {player addItem "ACE_EarPlugs"};
if (!hayACEMedical) then {
    [player] execVM "Revive\initRevive.sqf";
} else {
    player setVariable ["inconsciente",false,true];
};

player addEventHandler ["HandleHeal", {
	_player = _this select 0;
	if (captive _player) then {
		if ({((side _x== side_red) or (side _x== side_green)) and (_x knowsAbout player > 1.4)} count allUnits > 0) then {
			_player setCaptive false;
		} else {
			_ciudad = [ciudades,_player] call BIS_fnc_nearestPosition;
			_size = [_ciudad] call sizeMarker;

			_data = [_ciudad, ["prestigeOPFOR"]] call AS_fnc_getCityAttrs;
			_prestigeOPFOR = _data select 0;

			if (random 100 <_prestigeOPFOR) then {
				if (_player distance getMarkerPos _ciudad < _size * 1.5) then {
					_player setCaptive false;
				};
			};
		};
	};
}];

player addEventHandler ["WeaponAssembled", {
	params ["_EHunit", "_EHobj"];
	if (_EHunit isKindOf "StaticWeapon") then {
		_EHobj addAction [localize "STR_act_moveAsset", "moveObject.sqf","static",0,false,true,"","(_this == AS_commander)"];
		if !(_EHunit in staticsToSave) then {
			staticsToSave pushBack _EHunit;
			publicVariable "staticsToSave";
			[_EHunit] spawn VEHinit;
		};
	} else {
		_EHobj addEventHandler ["Killed",{[_this select 0] remoteExec ["postmortem",2]}];
	};
}];

player addEventHandler ["WeaponDisassembled", {
    [_this select 1] spawn VEHinit;
	[_this select 2] spawn VEHinit;
}];

if (isMultiplayer) then {
    _notAMemberMessage = "You are not in the Member's List of this Server.\n\n" +
			             "Ask the Commander in order to be allowed to access the HQ Ammobox.\n\n"+
				         "In the meantime you may use the other box to store equipment and share it with others.";

	player addEventHandler ["InventoryOpened", {
		_control = false;
		if !([_this select 0] call isMember) then {
			if ((_this select 1 == caja) or ((_this select 0) distance caja < 3)) then {
				_control = true;
				hint _notAMemberMessage;
			};
		};
		_control
	}];

    player addEventHandler ["Fired", {
		_tipo = _this select 1;
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

if (!isMultiplayer and hayACEMedical) then {
	player setVariable ["respawning",false];
	player addEventHandler ["HandleDamage", {
		if (player getVariable ["ACE_isUnconscious", false]) then {
			[] spawn {
                sleep 15;
                if !(player getVariable ["inconsciente", false]) then {
                    // put the player in the inconscious state where it can respawn with "SPACEBAR".
                    player setDamage 0.9;
                    [player] spawn inconsciente;
                };
            };
		};
	}];
};

[] execVM "reinitY.sqf";
[] execVM "statistics.sqf";

[player] execVM "OrgPlayers\unitTraits.sqf";
[player] spawn rankCheck;
[player] spawn localSupport;  // show local support when close to city.
