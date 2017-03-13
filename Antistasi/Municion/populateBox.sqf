/*
This function adds stuff to the box. "restrict" is used to only add if a condition is fulfilled.
See implementation below.
*/
params ["_box", "_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b", ["_restrict", false], ["_clear", false]];
private ["_name", "_amount"];

if (_clear) then {
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearBackpackCargoGlobal _box;
};

for "_i" from 0 to (count (_cargo_w select 0) - 1) do {
	_name = (_cargo_w select 0) select _i;
	_amount = (_cargo_w select 1) select _i;
	if (!_restrict or !(_name in unlockedWeapons)) then {
		_box addWeaponCargoGlobal [_name,_amount];
	};
};

for "_i" from 0 to (count (_cargo_m select 0) - 1) do {
	_name = (_cargo_m select 0) select _i;
	_amount = (_cargo_m select 1) select _i;
	if (!_restrict or !(_name in unlockedMagazines)) then {
		_box addMagazineCargoGlobal [_name,_amount];
	};
};

for "_i" from 0 to (count (_cargo_i select 0) - 1) do {
	_name = (_cargo_i select 0) select _i;
	_amount = (_cargo_i select 1) select _i;
	if (!_restrict or !(_name in unlockedItems)) then {
		_box addItemCargoGlobal [_name,_amount];
	};
};

for "_i" from 0 to (count (_cargo_b select 0) - 1) do {
	_name = (_cargo_b select 0) select _i;
	_amount = (_cargo_b select 1) select _i;
	if (!_restrict or !(_name in unlockedBackpacks)) then {
		_box addBackpackCargoGlobal [_name,_amount];
	};
};
