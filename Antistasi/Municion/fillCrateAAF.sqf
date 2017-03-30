if (!isServer and hasInterface) exitWith {};

params ["_crate"];
private ["_item", "_mag"];

[_crate] call emptyCrate;

private _getWeaponMags = {
    params ["_weapon"];
    private _index = AS_allWeapons find _weapon;
    if (_index == -1) exitWith {[]};

    // all magazines of this weapon.
    ((AS_allWeaponsAttrs select _index) select 2) - unlockedMagazines
};

_fnc_gear = {
	params ["_cat", ["_typeRan", 4], ["_classRan", 4], ["_magMult", 3]];

    private _typeInt = 1 + (floor random _typeRan);
	private _classInt = _classRan;

	if (_cat == "weapon") exitWith {
		for "_i" from 0 to _typeInt do {
			_item = selectRandom (AAFWeapons - unlockedWeapons);
			_crate addWeaponCargoGlobal [_item, _classInt];

            _mag = selectRandom ([_item] call _getWeaponMags);
            _crate addMagazineCargoGlobal [_mag, _classInt * _magMult];
		};
	};

	if (_cat == "magazine") exitWith {
		for "_i" from 0 to _typeInt do {
			_item = selectRandom (AAFMagazines - unlockedMagazines);
			_crate addMagazineCargoGlobal [_item, _classInt];
		};
	};

	if (_cat == "item") exitWith {
		for "_i" from 0 to _typeInt do {
			_item = selectRandom (AAFItems - unlockedItems);
			_crate addItemCargoGlobal [_item, _classInt];
		};
	};

	if (_cat == "optic") exitWith {
		for "_i" from 0 to _typeInt do {
			_item = selectRandom (AAFOptics - unlockedItems);
			_crate addItemCargoGlobal [_item, _classInt];
		};
	};

	if (_cat == "launcher") exitWith {
		for "_i" from 0 to _typeInt do {
			_item = selectRandom (AAFLaunchers - unlockedWeapons);
			_crate addWeaponCargoGlobal [_item, _classInt];

            _mag = selectRandom ([_item] call _getWeaponMags);
			_crate addMagazineCargoGlobal [_mag, _classInt * _magMult];
		};
	};

	if (_cat == "mine") exitWith {
		for "_i" from 0 to _typeInt do {
			_item = selectRandom (AAFMines - unlockedMagazines);
			_crate addMagazineCargoGlobal [_item, _classInt];
		};
	};

    if (_cat == "grenades") exitWith {
		for "_i" from 0 to _typeInt do {
			_item = selectRandom (AAFGrenades - unlockedMagazines);
			_crate addMagazineCargoGlobal [_item, _classInt];
		};
    };
};

call {
	if (typeOf _crate in ["I_supplyCrate_F", vehAmmo]) exitWith {
		["weapon", 3, 2, 5] call _fnc_gear;
		["magazine", 5, 5] call _fnc_gear;
		["item", 5, 5] call _fnc_gear;
		["mine", 3, 2] call _fnc_gear;
        ["grenades", 5, 5] call _fnc_gear;
		["optic", 2, 2] call _fnc_gear;
		["launcher", 2, 2, 3] call _fnc_gear;
	};

	if (typeOf _crate == opCrate) exitWith {
		_item = genAALaunchers call BIS_Fnc_selectRandom;
		_crate addWeaponCargoGlobal [_item, 5];
		_crate addMagazineCargoGlobal [([_item] call _getWeaponMags) select 0, 10];
	};
};

_items = ([] call AS_fnc_CrateMeds);

if (typeOf _crate != campCrate) then {
	_items pushBack [indNVG, 2];
	_items pushBack ["ItemGPS", 5];

	if (!hayTFAR) then {
		_items pushBack ["ItemRadio", 5];
	} else {
		if (4 < random 5) then {
			_items pushBack [lrRadio,1];
		};
	};
};

for "_i" from 0 to count _items - 1 do {
	private _name = (_items select _i) select 0;
	private _amount = (_items select _i) select 1;

    _crate addItemCargoGlobal [_name, _amount];
};

_crate addBackpackCargoGlobal ["B_Carryall_oli", 1];
