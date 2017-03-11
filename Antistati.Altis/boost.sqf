if (!isServer) exitWith {};

private ["_weapons", "_magazines", "_items", "_optics"];
scriptName "boost";

server setVariable ["hr",20,true];
server setVariable ["resourcesFIA",10000,true];
server setVariable ["prestigeNATO",30,true];

call {
	if (hayGREF) exitWith {
		_weapons = ["rhs_weap_m92", "rhs_weap_rpg26"];
		_magazines = ["rhs_30Rnd_762x39mm", "rhs_rpg26_mag", "rhs_mag_rgd5"];
		_items = ["ItemGPS", "ItemRadio", "rhsgref_acc_oko21", "rhsgref_TacVest_ERDL", "rhsgref_ssh68_un"];
		_optics = ["rhsgref_acc_oko21"];
	};
	if (hayRHS) exitWith {
		_weapons = ["rhs_weap_ak74m_camo", "rhs_weap_rpg26"];
		_magazines = ["rhs_30Rnd_545x39_AK", "rhs_rpg26_mag", "rhs_mag_rgd5"];
		_items = ["ItemGPS", "ItemRadio", "rhs_acc_1p29", "rhs_6b23_digi_rifleman", "rhs_6b28_ess_bala"];
		_optics = ["rhs_acc_1p29"];
	};
	_weapons = ["arifle_TRG21_F", "launch_NLAW_F"];
	_magazines = ["30Rnd_556x45_Stanag", "NLAW_F", "HandGrenade"];
	_items = ["ItemGPS", "ItemRadio", "optic_Arco", "V_Chestrig_oli", "H_HelmetIA"];
	_optics = ["optic_Arco"];
};

unlockedWeapons = unlockedWeapons + _weapons;
unlockedMagazines = unlockedMagazines + _magazines;
unlockedItems = unlockedItems + _items;
unlockedOptics = unlockedOptics + _optics;

publicVariable "unlockedWeapons";
publicVariable "unlockedMagazines";
publicVariable "unlockedItems";
publicVariable "unlockedOptics";

if (hayBE) then {[] call fnc_BE_gearUpdate; [] call fnc_BE_refresh};
[false] call fnc_MAINT_arsenal;