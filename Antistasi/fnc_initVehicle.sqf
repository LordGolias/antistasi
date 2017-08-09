params ["_veh", "_side"];
// _side can only be FIA, AAF, NATO or CSAT
// We need this because FIA can steal from others, and thus the vehicle class
// does not uniquely define the necessary initialization.

if ((_veh isKindOf "FlagCarrier") or (_veh isKindOf "Building")) exitWith {};
if (_veh isKindOf "ReammoBox_F" and _side == "AAF") exitWith {[_veh,"Watchpost"] call AS_fnc_fillCrateAAF};

// So the vehicle appears in debug mode. Does nothing otherwise.
[_veh] call AS_DEBUG_initVehicle;

private _tipo = typeOf _veh;
private _type = [_tipo] call AS_fnc_AAFarsenal_category;

// Equipment-related initialisation
[_veh] call emptyCrate;
if (_tipo == vehAmmo and _side == "AAF") then {[_veh, "Convoy"] call AS_fnc_fillCrateAAF};
if (_tipo == opCrate and _side == "AAF") then {[_veh, "AA"] call AS_fnc_fillCrateAAF};
// todo: add more equipment depending on spawing side / vehicle

if ((hayACE) && !(random 8 < 1)) then {_veh setVariable ["ace_cookoff_enable", false, true]};

_veh addEventHandler ["Killed", {[_this select 0] spawn postmortem}];

private _aaf_veh_EHkilled = {
	params ["_veh", "_killer"];
	if (side _killer == side_blue) then {
		[typeOf _veh] call AS_fnc_AAFarsenal_deleteVehicle;

		private _citySupportEffect = 0;
		private _xpEffect = "";
		switch (_type) do {
			case "planes": {
				_citySupportEffect = 5;
				_xpEffect = "des_arm";
			};
			case "armedHelis": {
				_citySupportEffect = 5;
				_xpEffect = "des_arm";
			};
			case "tanks": {
				_citySupportEffect = 4;
				_xpEffect = "des_arm";
			};
			case "transportHelis": {
				_citySupportEffect = 3;
				_xpEffect = "des_veh";
			};
			case "apcs": {
				_citySupportEffect = 2;
				_xpEffect = "des_arm";
			};
			case "trucks": {
				// these are unlimited, so they cost money but no support
				[-1000] remoteExec ["resourcesAAF", 2];
				_xpEffect = "des_veh";
			};
			default {
				diag_log format ["[AS] ERROR in AS_AAF_VE_EHkilled: '%1' is invalid type", typeOf _veh];
			};
		};
		if (_citySupportEffect != 0) then {
			[-_citySupportEffect,_citySupportEffect,position _veh] remoteExec ["citySupportChange",2];
		};
		if (_xpEffect != "") then {[_xpEffect] remoteExec ["fnc_BE_XP", 2]};
	};
};

if (_side  == "AAF" and _type in AS_AAFarsenal_categories) then {
	// todo: add code for when the car is stolen (instead of killed)
	_veh addEventHandler ["killed", _aaf_veh_EHkilled];
};
if (_side == "CSAT") then {
	// todo: add code for when the car is stolen (instead of killed)
	_veh addEventHandler ["killed", _aaf_veh_EHkilled];
};

// UAV is not part of the AAF arsenal, so the killing of it is dealt separately
if (_side == "AAF" and _tipo == AS_AAFarsenal_uav) then {
    _veh addEventHandler ["killed",{[-2500] remoteExec ["resourcesAAF",2]}];
};

// static weapons can be stolen by FIA from AAF and CSAT
if (_side in ["AAF","CSAT"] and (_veh isKindOf "StaticWeapon")) then {
    [[_veh,"steal"], "AS_fnc_addAction"] call BIS_fnc_MP;
};

if (_tipo in allStatMortars) then {
	// mortars may denounce position for every shot fired.
	_veh addEventHandler ["Fired", {
		params ["_mortar"];
		private _side = side gunner _mortar;

		if (_side == side_blue) then {
			if (random 8 < 1) then {
				if (_mortar distance (getMarkerPos "FIA_HQ") < 200) then {
					if (count ("aaf_attack_hq" call AS_fnc_active_missions) == 0) then {
						private _lider = leader (gunner _mortar);
						if (!isPlayer _lider or {[_lider] call isMember}) then {
							[] remoteExec ["ataqueHQ",HCattack];
						};
					};
				} else {
					[position _mortar] remoteExec ["patrolCA",HCattack];
				};
			};
		} else {
			// todo: chance of being detected by FIA if shot by AAF
		};
	}];
};

// start smoke script when hit for non-statics
if !(_veh isKindOf "StaticWeapon") then {
	_veh addEventHandler ["HandleDamage", {
        params ["_veh", "_part", "_dam"];
        if (_part == "") then {
            if ((_dam > 0.9) and (!isNull driver _veh)) then {
                [_veh] call smokeCoverAuto;
            };
        };
    }];
};

// air units can only be piloted by humans
if (_type in ["planes", "armedHelis", "transportHelis"]) then {
	_veh addEventHandler ["GetIn", {
		_posicion = _this select 1;
		if (_posicion == "driver") then {
			_unit = _this select 2;
			if ((!isPlayer _unit) and (_unit getVariable ["BLUFORSpawn",false])) then {
				moveOut _unit;
				hint "Only Humans can pilot an air vehicle";
			};
		};
	}];
};

// cars receive no damage to wheels if no projectile is involved and driver is not player.
// to avoid becoming stuck
if (_veh isKindOf "Car") then {
	_veh addEventHandler ["HandleDamage", {
		params ["_unit", "_part", "_dam", "_attacker", "_proj"];
		if ((_part find "wheel" != -1) and (_proj == "") and (!isPlayer driver _unit)) then {
			0
		} else {
			"_dam"
		};
	}];
};

// NATO vehicles are locked and take support on destruction.
if (_side == "NATO") then {
    _veh lock 3;  // locked for players

    // do not accept AIs from players groups to enter.
    _veh addEventHandler ["GetIn", {
        _unit = _this select 2;
        if ({isPlayer _x} count units group _unit > 0) then {
            moveOut _unit;
        };
    }];
    // lose support when vehicle is destroyed
    _veh addEventHandler ["killed", {
        [-2,0] remoteExec ["AS_fnc_changeForeignSupport",2];
        [2,-2,position (_this select 0)] remoteExec ["citySupportChange",2];
    }];
};

[_veh] spawn cleanserVeh;

// todo: explain in comments what this does
if ((count crew _veh) > 0) then {
	[_veh] spawn VEHdespawner;
} else {
	_veh addEventHandler ["GetIn", {
		_veh = _this select 0;
		[_veh] spawn VEHdespawner;
	}];
};
