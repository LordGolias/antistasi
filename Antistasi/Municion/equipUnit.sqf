params ["_unit", "_arsenal"];

removeAllItemsWithMagazines _unit;
{_unit removeWeaponGlobal _x} forEach weapons _unit;
removeBackpackGlobal _unit;
removeVest _unit;
_unit unlinkItem "ItemRadio";

_arsenal params ["_vest", "_helmet", "_googles", "_backpack", "_primaryWeapon", "_primaryMags", "_secondaryWeapon", "_secondaryMags", "_scope", "_uniformItems", "_backpackItems", "_primaryWeaponItems"];

private _fnc_equipUnit = {
    params ["_weapon", "_mags"];
    if (_weapon != "") then {
        [_unit, _weapon, 0, 0] call BIS_fnc_addWeapon;

        for "_i" from 0 to (count (_mags select 0) - 1) do {
            _name = (_mags select 0) select _i;
            _amount = (_mags select 1) select _i;
            _unit addMagazines [_name, _amount];
        };
    };
};

if (_vest != "") then {
    _unit addVest _vest;
};

if (_helmet != "") then {
    _unit addHeadgear _helmet;
};

if (_googles != "") then {
    _unit linkItem _googles;
};

if (_backpack != "") then {
    _unit addBackpackGlobal _backpack;

    private _isFull = false;
    private _i = 0;
    while {!_isFull and _i < count _backpackItems} do {
        private _name = (_backpackItems select _i) select 0;
        private _amount = (_backpackItems select _i) select 1;

        private _j = 0;
        while {!_isFull and _j < _amount} do {
            _fits = _unit canAddItemToBackpack _name;
            if (_fits) then {
                _unit addItemToBackpack _name;
            } else {
                _isFull = true;
            };
            _j = _j + 1;
        };
        _i = _i + 1;
    };
};

// add items to uniform
private _isFull = false;
private _i = 0;
while {!_isFull and _i < count _uniformItems} do {
    private _name = (_uniformItems select _i) select 0;
    private _amount = (_uniformItems select _i) select 1;

    private _j = 0;
    while {!_isFull and _j < _amount} do {
        _fits = _unit canAddItemToUniform _name;
        if (_fits) then {
            _unit addItemToUniform _name;
        } else {
            _isFull = true;
        };
        _j = _j + 1;
    };
    _i = _i + 1;
};

[_primaryWeapon, _primaryMags] call _fnc_equipUnit;
[_secondaryWeapon, _secondaryMags] call _fnc_equipUnit;

if (_scope != "") then {
    _unit addPrimaryWeaponItem _scope;
};

{
    if (_x == indLaser) then {
        _unit addPrimaryWeaponItem indLaser;
        _unit assignItem indLaser;
        _unit enableIRLasers true;
    };
    if (_x == indFL) then {
        _unit addPrimaryWeaponItem indFL;
        _unit enableGunLights "AUTO";
    };
} forEach _primaryWeaponItems;


// remove from box stuff that was used.
private _cargo = [_unit, true] call AS_fnc_getUnitArsenal;
([caja] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
private _cargo_w = [_cargo_w, _cargo select 0, false] call AS_fnc_mergeCargoLists;
private _cargo_m = [_cargo_m, _cargo select 1, false] call AS_fnc_mergeCargoLists;
private _cargo_i = [_cargo_i, _cargo select 2, false] call AS_fnc_mergeCargoLists;
private _cargo_b = [_cargo_b, _cargo select 3, false] call AS_fnc_mergeCargoLists;
[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;


if (hayTFAR) then {
    _unit addItem "tf_anprc152";
    _unit assignItem "tf_anprc152";
};

_unit selectWeapon (primaryWeapon _unit);
