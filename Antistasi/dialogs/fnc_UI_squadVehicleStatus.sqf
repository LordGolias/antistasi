if (count hcSelected player != 1) exitWith {
	hint "Select one squad from the High Command";
};

private _grupo = (hcSelected player select 0);

private _isStatic = false;
{
    if (vehicle _x isKindOf "StaticWeapon") exitWith {
        _isStatic = true;
    };
} forEach units _grupo;
if _isStatic exitWith {
    hint "Static Weapon squad vehicles cannot be dismounted"
};

private _veh = objNull;
{
    private _owner = _x getVariable "owner";
    if (!isNil "_owner" and {_owner == _grupo}) exitWith {
        _veh = _x;
    };
} forEach vehicles;

if (isNull _veh) exitWith {
    hint "The squad has no vehicle assigned"
};

if (_this select 0 == "stats") then {
	private _texto = format ["Squad %1 Vehicle Stats\n\n%2",groupID _grupo,getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName")];
	if (!alive _veh) then {
		_texto = format ["%1\n\nDESTROYED",_texto];
	} else {
		if (!canMove _veh) then {
			_texto = format ["%1\n\nDISABLED",_texto]
		};
		if (count allTurrets [_veh, false] > 0) then {
			if (!canFire _veh) then {
				_texto = format ["%1\n\nWEAPON DISABLED",_texto]
			};
			if (someAmmo _veh) then {
				_texto = format ["%1\n\nMunitioned",_texto]
			};
		};
	};
	hint format ["%1",_texto];
};
