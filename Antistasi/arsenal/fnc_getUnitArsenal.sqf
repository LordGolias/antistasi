params ["_unit", ["_restrict", false]];

private _weapons = [];
private _items = [];
private _magazines = [];
private _backpacks = [];

private _backpack = backpack _unit;
if (_backpack != "") then {
	_backpacks pushback (_backpack call BIS_fnc_basicBackpack);
};

// items
{
	if (_x != "") then {
		_items pushBack _x;
	};
} forEach [headgear _unit, vest _unit] + items _unit + assignedItems _unit;

// weapons and attachments
private _result = [weaponsItems _unit] call AS_fnc_getWeaponItemsCargo;
_weapons = _weapons + (_result select 0);
_magazines = _magazines + (_result select 1);
_items = _items + (_result select 2);

// magazines
{
_magazines pushBack (_x select 0);
} forEach magazinesAmmoFull _unit;


if (_restrict) then {
	_weapons = _weapons - unlockedWeapons;
	_magazines = _magazines - unlockedMagazines;
	_items = _items - unlockedItems;
	_backpacks = _backpacks - unlockedBackpacks;
};

// transform in cargoList
private _cargo_w = [_weapons] call AS_fnc_listToCargoList;
private _cargo_m = [_magazines] call AS_fnc_listToCargoList;
private _cargo_i = [_items] call AS_fnc_listToCargoList;
private _cargo_b = [_backpacks] call AS_fnc_listToCargoList;

[_cargo_w, _cargo_m, _cargo_i, _cargo_b]
