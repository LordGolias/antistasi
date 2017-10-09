params ["_type"];

private _vest = ([caja, "vest"] call AS_fnc_getBestItem);
private _helmet = ([caja, "helmet"] call AS_fnc_getBestItem);

// survivors have no weapons.
if (_type == "Survivor") exitWith {
    ["", "", "", "", "", [], "", [], "", [], [], []]
};

// choose a list of weapons to choose from the unit type.
private _primaryWeapons = (AS_weapons select 0) + (AS_weapons select 13) + (AS_weapons select 14); // Assault Rifles + Rifles + SubmachineGun
private _secondaryWeapons = [];
private _useBackpack = false;
private _backpackItems = [];
private _uniformItems = call AS_medical_fnc_FIAuniformMeds;
private _scopeType = "rifleScope";  // "rifleScope" or "sniperScope" to choose betwene "low min zoom and high max zoom" or "very high max zoom".
private _primaryMagCount = 6 + 1;  // +1 for the weapon.
if (_type == "Grenadier") then {
    _primaryWeapons = AS_weapons select 3; // G. Launchers
    // todo: check that secondary magazines exist.
};
if (_type == "Autorifleman") then {
    _primaryWeapons = AS_weapons select 6; // Machine guns
    _useBackpack = true;
    _primaryMagCount = 2 + 1;  // because MG clips have more bullets.
};
if (_type == "Sniper") then {
    _primaryWeapons = AS_weapons select 15;  // Snipers
    _scopeType = "sniperScope";
    _primaryMagCount = 8 + 1;  // because snipers clips have less bullets.
};
if (_type == "AT Specialist") then {
    // todo: this list includes AT and AA. Fix it.
    _secondaryWeapons = (AS_weapons select 8); // missile launchers
    _useBackpack = true;
};
if (_type == "AA Specialist") then {
    // todo: this list includes AT and AA. Fix it.
    _secondaryWeapons = (AS_weapons select 8); // missile launchers
    _useBackpack = true;
};
if (_type == "Medic") then {
    _useBackpack = true;
    _backpackItems = call AS_medical_fnc_FIAmedicBackpack;
};
if (_type == "Engineer") then {
    _useBackpack = true;
    _backpackItems = [["ToolKit", 1]];
};

private _backpack = "";
if (_useBackpack) then {
    _backpack = ([caja, "backpack"] call AS_fnc_getBestItem);
};

private _primaryWeapon = ([caja, _primaryWeapons, _primaryMagCount] call AS_fnc_getBestWeapon);
private _primaryMags = [[], []];
if (_primaryWeapon != "") then {
    _primaryMags = ([caja, _primaryWeapon, _primaryMagCount] call AS_fnc_getBestMagazines);
};

private _secondaryWeapon = ([caja, _secondaryWeapons, 2 + 1] call AS_fnc_getBestWeapon);
private _secondaryMags = [[], []];
if (_secondaryWeapon != "") then {
    _secondaryMags = ([caja, _secondaryWeapon, 2 + 1] call AS_fnc_getBestMagazines);
};

private _scope = ([caja, _scopeType] call AS_fnc_getBestItem);

private _primaryWeaponItems = [];
private _googles = "";
if (SunOrMoon < 1) then {
    _googles = ([caja, "nvg"] call AS_fnc_getBestItem);

    if (_googles != "") then {
        if (indLaser in (itemCargo caja)) then {
            _primaryWeaponItems pushBack indLaser;
        };
    } else {
        if (indFL in (itemCargo caja)) then {
            _primaryWeaponItems pushBack indFL;
        };
    };
};

[_vest, _helmet, _googles, _backpack, _primaryWeapon, _primaryMags, _secondaryWeapon, _secondaryMags, _scope, _uniformItems, _backpackItems, _primaryWeaponItems]
