params ["_crate", "_NATOSupp"];
private ["_intNATOSupp", "_weapons","_magazines","_items","_backpacks","_addWeapon"];

_intNATOSupp = floor (_NATOSupp/10);

_weapons = [[],[]];
_magazines = [[],[]];
_items = [[],[]];
_backpacks = [[],[]];

_addWeapon = {
	params ["_weapon", "_amount", "_mags"];
	if (_amount < 1) exitWith {};
	_mag = selectRandom (getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"));

	(_weapons select 0) pushBack _weapon;
	(_weapons select 1) pushBack _amount;
	(_magazines select 0) pushBack _mag;
	(_magazines select 1) pushBack _mags;
};

// Handguns and submachine guns
[selectRandom (NATOweapons arrayIntersect ((AS_weapons select 4) + (AS_weapons select 14))), 4*_intNATOSupp, 10*4*_intNATOSupp] call _addWeapon;
// Rifles
[selectRandom (NATOweapons arrayIntersect (AS_weapons select 0)), 3*_intNATOSupp, 10*3*_intNATOSupp] call _addWeapon;
// Machine guns
[selectRandom (NATOweapons arrayIntersect (AS_weapons select 6)), _intNATOSupp, 3*_intNATOSupp] call _addWeapon;

// GLs
[selectRandom (NATOweapons arrayIntersect (AS_weapons select 3)), _intNATOSupp, 10*_intNATOSupp] call _addWeapon;
// HE Grenades
(_magazines select 0) pushBack ((NATOMagazines arrayIntersect AS_allGrenades) select 0);
(_magazines select 1) pushBack 6*_intNATOSupp;
// Any grenades
(_magazines select 0) pushBack (selectRandom (NATOMagazines arrayIntersect AS_allGrenades));
(_magazines select 1) pushBack 6*_intNATOSupp;

// Snipers
[selectRandom (NATOweapons arrayIntersect (AS_weapons select 15)), _intNATOSupp, 10*_intNATOSupp] call _addWeapon;
private _bestScope = [NATOItems arrayIntersect AS_allOptics, "sniperScope"] call AS_fnc_getBestItem;
(_items select 0) pushBack _bestScope;
(_items select 1) pushBack _intNATOSupp;

[selectRandom bluAT, _intNATOSupp, 3*_intNATOSupp] call _addWeapon;
[selectRandom bluAA, _intNATOSupp, 3*_intNATOSupp] call _addWeapon;

(_magazines select 0) pushBack (selectRandom NATOThrowGrenades);
(_magazines select 1) pushBack 10*_intNATOSupp;

for "_i" from 1 to 5 do {
    (_items select 0) pushBack (selectRandom NATOVests);
    (_items select 1) pushBack _intNATOSupp;
};

for "_i" from 1 to 5 do {
    (_items select 0) pushBack (selectRandom NATOHelmets);
    (_items select 1) pushBack _intNATOSupp;
};

for "_i" from 1 to 3 do {
	(_items select 0) pushBack (selectRandom (NATOItems arrayIntersect (AS_allBipods + AS_allMuzzles + AS_allMounts)));
	(_items select 1) pushBack _intNATOSupp;
};

if (hayACE and !hayRHS) then {
	(_magazines select 0) pushBack "ACE_HuntIR_M203";
	(_magazines select 1) pushBack 3*_intNATOSupp;

	(_items select 0) pushBack "ACE_HuntIR_monitor";
	(_items select 1) pushBack _intNATOSupp;

	(_items select 0) pushBack "ACE_Vector";
	(_items select 1) pushBack _intNATOSupp;

	(_items select 0) pushBack "ACE_microDAGR";
	(_items select 1) pushBack _intNATOSupp;

	(_items select 0) pushBack "ACE_ATragMX";
	(_items select 1) pushBack _intNATOSupp;

	(_items select 0) pushBack "ACE_Kestrel4500";
	(_items select 1) pushBack _intNATOSupp;
};

if (hayTFAR) then {
    (_backpacks select 0) pushBack lrRadio;
	(_backpacks select 1) pushBack 2*_intNATOSupp;
};

[_crate, _weapons, _magazines, _items, _backpacks, true, true] call AS_fnc_populateBox;
