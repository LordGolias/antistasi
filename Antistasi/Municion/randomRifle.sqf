params ["_unit"];

removeAllItemsWithMagazines _unit;
{_unit removeWeaponGlobal _x} forEach weapons _unit;
removeBackpackGlobal _unit;
removeVest _unit;
_unit unlinkItem "ItemRadio";

/*
_soldiers = [
	"B_G_Soldier_LAT_F", // AT rifleman
	"B_G_Soldier_F", // rifleman
	"B_G_Soldier_GL_F", // granadier
	"B_G_Soldier_lite_F", // AA rifleman
	"B_G_Soldier_SL_F", // squad leader
	"B_G_Soldier_TL_F", // team leader
	"B_G_Soldier_AR_F", // autorifleman
	"B_G_medic_F",
	"B_G_engineer_F",
	"B_G_Soldier_exp_F", // exp. specialist
	"B_G_Soldier_A_F", // ammo bearer
	"B_G_Soldier_M_F", // sniper
	"B_G_Survivor_F",
];
*/
private _type = typeOf _unit;

// survivors have no weapons.
if (_type == "B_G_Survivor_F") exitWith {};

_vest = ([caja, "vest"] call AS_fnc_getBestItem);
if (_vest != "") then {
	_unit addVest _vest;
};

_helmet = ([caja, "helmet"] call AS_fnc_getBestItem);
if (_helmet != "") then {
	_unit addHeadgear _helmet;
};

// choose a list of weapons to choose from the unit type.
// see initVar.sqf where AS_weapons is populated.
private _primaryWeapons = (AS_weapons select 0) + (AS_weapons select 13) + (AS_weapons select 14); // Assault Rifles + Rifles + SubmachineGun
private _secondaryWeapons = [];
private _useBackpack = false;
if (_type == "B_G_Soldier_GL_F") then {
	_primaryWeapons = AS_weapons select 3; // G. Launchers
	// todo: check that secondary magazines exist.
};
if (_type == "B_G_Soldier_AR_F") then {
	_primaryWeapons = AS_weapons select 6; // Machine guns
	_useBackpack = true;
};
if (_type == "B_G_Soldier_M_F") then {
	_primaryWeapons = AS_weapons select 15;  // Snipers
};
if (_type == "B_G_Soldier_LAT_F") then {
	// todo: this list includes AT and AA. Fix it.
	_secondaryWeapons = (AS_weapons select 8); // missile launchers
	_useBackpack = true;
};
if (_type == "B_G_Soldier_lite_F") then {
	// todo: this list includes AT and AA. Fix it.
	_secondaryWeapons = (AS_weapons select 8); // missile launchers
	_useBackpack = true;
};

if (_useBackpack) then {
	_backpack = ([caja, "backpack"] call AS_fnc_getBestItem);
	if (_backpack != "") then {
		_unit addBackpackGlobal _backpack;
	};
};

private _addWeapon = {
	params ["_weapons", "_mags"];
	_weapon = ([caja, _weapons, _mags] call AS_fnc_getBestWeapon);
	if (_weapon != "") then {
		[_unit, _weapon, 0, 0] call BIS_fnc_addWeapon;

		// The weapon was choosen to have mags available, so this is guaranteed to give ammo.
		_cargo_m = ([caja, _weapon, _mags] call AS_fnc_getBestMagazines);

		for "_i" from 0 to (count (_cargo_m select 0) - 1) do {
			_name = (_cargo_m select 0) select _i;
			_amount = (_cargo_m select 1) select _i;
			_unit addMagazines [_name, _amount];
		};
	};
};

[_primaryWeapons, 6 + 1] call _addWeapon;
[_secondaryWeapons, 2 + 1] call _addWeapon;

// todo: add attachments, optics and other items.

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


if (sunOrMoon < 1) then {
	if (indNVG in unlockedItems) then {
		_unit linkItem indNVG;
		if (indLaser in unlockedItems) then {
			_unit addPrimaryWeaponItem indLaser;
	        _unit assignItem indLaser;
	        _unit enableIRLasers true;
		};
	}
	else {
		if (indFL in unlockedItems) then {
			_unit unassignItem indLaser;
	        _unit removePrimaryWeaponItem indLaser;
	        _unit addPrimaryWeaponItem indFL;
	        _unit enableGunLights "forceOn";
	    };
	};
};
