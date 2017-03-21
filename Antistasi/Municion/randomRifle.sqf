params ["_unit"];

removeAllItemsWithMagazines _unit;
{_unit removeWeaponGlobal _x} forEach weapons _unit;
removeBackpackGlobal _unit;
removeVest _unit;

/*
_soldiers = [
	"B_G_Soldier_LAT_F", // AT rifleman
	"B_G_Soldier_F", // rifleman
	"B_G_Soldier_GL_F", // granadier
	"B_G_Soldier_lite_F", // light rifleman
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
_type = typeOf _unit;

// survivors have no weapons.
if (_type == "B_G_Survivor_F") exitWith {};


_vest = ([caja, "vest"] call AS_fnc_getBestItem);
if (!isnil "_vest") then {
	_unit addVest _vest;
	caja removeItem _vest;
};

_helmet = ([caja, "helmet"] call AS_fnc_getBestItem);
if (!isnil "_helmet") then {
	_unit addHeadgear _helmet;
	caja removeItem _helmet;
};

// choose a list of weapons to choose from the unit type.
// see initVar.sqf where AS_weapons is populated.
_primaryWeapons = (AS_weapons select 13); // Rifles
_secondaryWeapons = [];
_useBackpack = false;
if (_type == "B_G_Soldier_GL_F") then {
	_primaryWeapons = AS_weapons select 3; // G. Launchers
	// todo: check that secondary magazines exist.
};
if (_type == "B_G_Soldier_AR_F") then {
	_primaryWeapons = AS_weapons select 6; // Machine guns
};
if (_type == "B_G_Soldier_M_F") then {
	_primaryWeapons = AS_weapons select 15;  // Snipers
};
if (_type == "B_G_Soldier_LAT_F") then {
	_secondaryWeapons = (AS_weapons select 8); // missile launchers
	_useBackpack = true;
};

if (_useBackpack) then {
	_backpack = ([caja, "backpack"] call AS_fnc_getBestItem);
	if (!isnil "_backpack") then {
		_unit addBackpackGlobal _backpack;
		caja removeBackpackGlobal _backpack;
	};
};

_addWeapon = {
	params ["_weapons", "_mags"];
	_weapon = ([caja, _weapons, _mags] call AS_fnc_getBestWeapon);
	if (!isnil "_weapon") then {
		[_unit, _weapon, 0, 0] call BIS_fnc_addWeapon;
		caja removeWeaponGlobal _weapon;

		// The weapon was choosen to have mags available, so this is guaranteed to give ammo.
		_cargo_m = ([caja, _weapon, _mags] call AS_fnc_getBestMagazines);

		for "_i" from 0 to (count (_cargo_m select 0) - 1) do {
			_name = (_cargo_m select 0) select _i;
			_amount = (_cargo_m select 1) select _i;
			_unit addMagazines [_name, _amount];
			// todo: _unit may not be able to carry then all, but all are currently removed from the box.
			for "_j" from 0 to _amount do {caja removeMagazineGlobal _name;};
		};
	};
};

[_primaryWeapons, 6 + 1] call _addWeapon;
[_secondaryWeapons, 2 + 1] call _addWeapon;


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
