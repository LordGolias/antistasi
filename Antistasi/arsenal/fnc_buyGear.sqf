#include "../macros.hpp"
AS_SERVER_ONLY("AS_fnc_buyGear.sqf");
params ["_type", "_money"];
private ["_weapons", "_accessories", "_amount"];

if (AS_P("resourcesFIA") < _money) exitWith {
	hint "not enough money :(";
};

private _buyableWeapons = CSATweapons + NATOweapons;
private _buyableItems = CSATItems + NATOItems;

switch (_type) do {
	case "ASRifles": {_weapons = _buyableWeapons arrayIntersect (AS_weapons select 0); _amount = 10;};  // assault + G. launchers
	case "Machineguns": {_weapons = _buyableWeapons arrayIntersect (AS_weapons select 6); _amount = 5;};
	case "Sniper Rifles": {_weapons = _buyableWeapons arrayIntersect (AS_weapons select 15); _amount = 2;};
	case "Launchers": {_weapons = _buyableWeapons arrayIntersect ((AS_weapons select 8) + (AS_weapons select 10) + (AS_weapons select 5)); _amount = 2;};
	case "Pistols": {_weapons = _buyableWeapons arrayIntersect (AS_weapons select 4); _amount = 20;};
	case "GLaunchers": {_weapons = _buyableWeapons arrayIntersect (AS_weapons select 3); _amount = 5;};

	case "assessories": {
        _accessories = _buyableItems arrayIntersect (AS_allOptics + AS_allBipods + AS_allMuzzles + AS_allMounts + AS_allUAVs) - unlockedItems;
        for "_i" from 1 to 4 do {
			expCrate addItemCargoGlobal [selectRandom _accessories, 1];
		};
	};

	case "explosives": {
		{
			expCrate addMagazineCargoGlobal [_x call AS_fnc_mineMag, 2];
		} forEach AAFExponsives;
	};

	case "mines": {
        expCrate addMagazineCargoGlobal [apMine call AS_fnc_mineMag, 2];
        expCrate addMagazineCargoGlobal [atMine call AS_fnc_mineMag, 2];
	};
};

if (_type in ["ASRifles", "Machineguns", "Sniper Rifles", "Launchers", "Pistols", "GLaunchers"]) then {
	_weapons = _weapons - unlockedWeapons;
    for "_i" from 1 to _amount do {
        private _weapon = selectRandom _weapons;
        expCrate addItemCargoGlobal [_weapon, 1];
        private _magazines = AS_allWeaponsAttrs select (AS_allWeapons find _weapon);
        expCrate addMagazineCargoGlobal [selectRandom _magazines, 10];
    };
};

[0, -_money] remoteExec ["AS_fnc_changeFIAmoney",2];
