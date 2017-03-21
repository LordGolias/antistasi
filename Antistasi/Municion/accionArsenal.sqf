private ["_box","_unit","_computeAll"];

_box = _this select 0;
_unit = _this select 1;

// Get all stuff in the unit before going to the arsenal
_old_cargo = [_unit, true] call AS_fnc_getUnitArsenal;

// specify what is available in the arsenal.
([caja, true] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];

// add allowed stuff.
["AmmoboxInit",[caja, false,{true}]] spawn BIS_fnc_arsenal;
[caja,(_cargo_w select 0) + unlockedWeapons, true] call BIS_fnc_addVirtualWeaponCargo;
[caja,(_cargo_m select 0) + unlockedMagazines, true] call BIS_fnc_addVirtualMagazineCargo;
[caja,(_cargo_i select 0) + unlockedItems, true] call BIS_fnc_addVirtualItemCargo;
[caja,(_cargo_b select 0) + unlockedBackpacks, true] call BIS_fnc_addVirtualBackpackCargo;

["Open",[nil,_box,_unit]] call BIS_fnc_arsenal;

// wait for the arsenal to close.
waitUntil {isnull ( uinamespace getvariable "RSCDisplayArsenal" )};

_new_cargo = [_unit, true] call AS_fnc_getUnitArsenal;

// we update the value since during the wait someone may have removed the last weapon.
([caja, true] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];

// add all the old stuff and removes all the new stuff.
_cargo_w = [_cargo_w, _old_cargo select 0] call AS_fnc_mergeCargoLists;
_cargo_m = [_cargo_m, _old_cargo select 1] call AS_fnc_mergeCargoLists;
_cargo_i = [_cargo_i, _old_cargo select 2] call AS_fnc_mergeCargoLists;
_cargo_b = [_cargo_b, _old_cargo select 3] call AS_fnc_mergeCargoLists;

_cargo_w = [_cargo_w, _new_cargo select 0, false] call AS_fnc_mergeCargoLists;
_cargo_m = [_cargo_m, _new_cargo select 1, false] call AS_fnc_mergeCargoLists;
_cargo_i = [_cargo_i, _new_cargo select 2, false] call AS_fnc_mergeCargoLists;
_cargo_b = [_cargo_b, _new_cargo select 3, false] call AS_fnc_mergeCargoLists;

// remove from unit items that are not available.
for "_i" from 0 to (count (_cargo_w select 0) - 1) do {
	_name = (_cargo_w select 0) select _i;
	_amount = (_cargo_w select 1) select _i;
	if (_amount < 0) then {
		for "_j" from 0 to (-_amount - 1) do {
			// todo: remove items in the weapon.
			_unit removeWeapon _name;
		};
	};
};
for "_i" from 0 to (count (_cargo_m select 0) - 1) do {
	_name = (_cargo_m select 0) select _i;
	_amount = (_cargo_m select 1) select _i;
	if (_amount < 0) then {
		for "_j" from 0 to (-_amount - 1) do {
			_unit removeMagazine _name;
		};
	};
};
for "_i" from 0 to (count (_cargo_i select 0) - 1) do {
	_name = (_cargo_i select 0) select _i;
	_amount = (_cargo_i select 1) select _i;
	if (_amount < 0) then {
		for "_j" from 0 to (-_amount - 1) do {
			// todo: transfer items inside the vest to the box.
			_unit removeItem _name;
		};
	};
};
for "_i" from 0 to (count (_cargo_b select 0) - 1) do {
	_name = (_cargo_b select 0) select _i;
	_amount = (_cargo_b select 1) select _i;
	if (_amount < 0) then {
		for "_j" from 0 to (-_amount - 1) do {
			// todo: transfer items inside the backpack to the box.
			removeBackpack _unit;
		};
	};
};

[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;
