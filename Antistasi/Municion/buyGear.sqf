#include "../macros.hpp"
params ["_type", "_money"];
private ["_weapons", "_accessories", "_amount"];

if (AS_P("resourcesFIA") < _money) exitWith {
	_l1 = ["Devin", "Get lost ya cheap wanker!"];
    [[_l1],"DIRECT",0.15] execVM "createConv.sqf";
};

switch (_type) do {
	case "ASRifles": {_weapons = (AS_weapons select 0); _amount = 10;};  // assault + G. launchers
	case "Machineguns": {_weapons = (AS_weapons select 6); _amount = 5;};
	case "Sniper Rifles": {_weapons = (AS_weapons select 15); _amount = 2;};
	case "Launchers": {_weapons = (AS_weapons select 8) + (AS_weapons select 10) + (AS_weapons select 5); _amount = 2;};
	case "Pistols": {_weapons = (AS_weapons select 4); _amount = 20;};
	case "GLaunchers": {_weapons = (AS_weapons select 3); _amount = 5;};

	case "assessories": {
        _accessories = AS_allAssessories - unlockedItems;
        for "_i" from 1 to 4 do {
			expCrate addItemCargoGlobal [selectRandom _accessories, 1];
		};
	};

	case "explosives": {
        expCrate addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 2];
        expCrate addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2];
	};

	case "mines": {
        expCrate addMagazineCargoGlobal [apMine, 2];
        expCrate addMagazineCargoGlobal [atMine, 2];
        expCrate addMagazineCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 1];
        expCrate addMagazineCargoGlobal ["SLAMDirectionalMine_Wire_Mag", 1];
        expCrate addMagazineCargoGlobal ["APERSBoundingMine_Range_Mag", 1];
        expCrate addMagazineCargoGlobal ["APERSTripMine_Wire_Mag", 1];
	};
};


if (_type in ["ASRifles", "Machineguns", "Sniper Rifles", "Launchers", "Pistols", "GLaunchers"]) then {
	_weapons = _weapons - unlockedWeapons;
    for "_i" from 1 to _amount do {
        _weapon = selectRandom _weapons;
        expCrate addItemCargoGlobal [_weapon, 1];
        _magazines = AS_allWeaponsAttrs select (AS_allWeapons find _weapon);
        expCrate addMagazineCargoGlobal [selectRandom _magazines, 10];
    };
};

_l2 = ["Devin", "Aye, the market for explosives is boomin'. They be hard to get a hold of, don't ya know."];
if (_money > 1000) then {_l2 = ["Devin", "Yer a fine customer. Give ya an even better deal next time."]};
[[_l2],"DIRECT",0.15] execVM "createConv.sqf";

[0, -_money] remoteExec ["resourcesFIA",2];
