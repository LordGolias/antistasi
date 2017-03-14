private ["_type", "_money", "_weaponsTypeList"];
_type = _this select 0;
_money = _this select 1;

if ((server getVariable "resourcesFIA") < _money) exitWith {
	_l1 = ["Devin", "Get lost ya cheap wanker!"];
    [[_l1],"DIRECT",0.15] execVM "createConv.sqf";
};

_weapons = lockedWeapons;
_accessories = allAccessories;
_standardWeapons = vanillaWeapons;
_standardAccessories = vanillaAccessories;

if (hayACE) then {
	_standardWeapons = vanillaWeapons + aceWeapons;
	_standardAccessories = vanillaAccessories + aceAccessories;
};

_noWeaponMods = true;
if (count (lockedWeapons - _standardWeapons) != 0) then {
	_noWeaponMods = false;
	_weapons = lockedWeapons - _standardWeapons;
	_accessories = allAccessories - _standardAccessories;
};

if (hayRHS) then {
	if (count (_weapons - rhsWeaponsAFRF - rhsWeaponsUSAF) != 0) then {
		_weapons = _weapons - rhsWeaponsAFRF - rhsWeaponsUSAF;
		_accessories = _accessories - rhsAccessoriesAFRF - rhsAccessoriesUSAF;
	};
};

_noGear = false;

switch (_type) do {
	case "ASRifles": {_weaponsTypeList = arifles;};
	case "Machineguns": {_weaponsTypeList = mguns;};
	case "Sniper Rifles": {_weaponsTypeList = srifles;};
	case "Launchers": {_weaponsTypeList = mlaunchers + rlaunchers;};
	case "Pistols": {_weaponsTypeList = hguns;};
	case "Random": {/* _weaponsTypeList = _weapons; => pick from any weapon.*/};

	case "aCache": {
		if (count _accessories == 0) exitWith {_noGear = true};
		if (_money == 500) exitWith {
			for "_i" from 1 to 2 do {
				_cosa = _accessories call BIS_Fnc_selectRandom;
				_num = 1;
				expCrate addItemCargoGlobal [_cosa, _num];
			};
		};
		if (_money == 5000) exitWith {
			for "_i" from 1 to 10 do {
				_cosa = _accessories call BIS_Fnc_selectRandom;
				_num = 1 + (floor random 2);
				expCrate addItemCargoGlobal [_cosa, _num];
			};
		};
	};

	case "expLight": {
		if (_money == 300) exitWith {
			expCrate addMagazineCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 1];
			expCrate addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 3];
		};
		if (_money == 800) exitWith {
			expCrate addMagazineCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 3];
			expCrate addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 8];
			expCrate addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 8];
		};
	};
	
	case "expHeavy": {
		if (_money == 300) exitWith {
			expCrate addMagazineCargoGlobal [apMine, 5];
			expCrate addMagazineCargoGlobal [atMine, 2];
			expCrate addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 2];
		};
		if (_money == 800) exitWith {
			expCrate addMagazineCargoGlobal [apMine, 8];
			expCrate addMagazineCargoGlobal [atMine, 4];
			expCrate addMagazineCargoGlobal ["SLAMDirectionalMine_Wire_Mag", 4];
			expCrate addMagazineCargoGlobal ["APERSBoundingMine_Range_Mag", 1];
			expCrate addMagazineCargoGlobal ["APERSTripMine_Wire_Mag", 3];
		};
	};
};

if (_type in ["ASRifles", "Machineguns", "Sniper Rifles", "Launchers", "Pistols", "Random"]) then {
	_weapons = _weapons arrayIntersect _weaponsTypeList;
	if (count _weapons != 0) then {
		if (_money == 1000) exitWith {
			for "_i" from 1 to 3 do {
				_cosa = _weapons call BIS_Fnc_selectRandom;
				_num = 1 + (floor random 2);
				expCrate addItemCargoGlobal [_cosa, _num];
				_magazines = getArray (configFile / "CfgWeapons" / _cosa / "magazines");
				expCrate addMagazineCargoGlobal [_magazines select 0, _num * 4];
			};
		};
		if (_money == 2500) exitWith {
			for "_i" from 1 to 8 do {
				_cosa = _weapons call BIS_Fnc_selectRandom;
				_num = 2 + (floor random 4);
				expCrate addItemCargoGlobal [_cosa, _num];
				_magazines = getArray (configFile / "CfgWeapons" / _cosa / "magazines");
				expCrate addMagazineCargoGlobal [_magazines select 0, _num * 6];
			};
		};
	}
	else {
		_noGear = true;
	};
};

if (_noGear) exitWith {
	_l3 = ["Devin", "Sorry, lad. Don't have any guns right now. Check back later."];
	[[_l3],"DIRECT",0.15] execVM "createConv.sqf";
};

expCrate addBackpackCargoGlobal ["B_Carryall_oli", 1];

_l2 = ["Devin", "Aye, the market for explosives is boomin'. They be hard to get a hold of, don't ya know."];
if (_money > 1000) then {_l2 = ["Devin", "Yer a fine customer. Give ya an even better deal next time."]};
[[_l2],"DIRECT",0.15] execVM "createConv.sqf";

[0, -_money] remoteExec ["resourcesFIA",2];