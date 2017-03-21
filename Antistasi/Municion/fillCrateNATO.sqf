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

[selectRandom bluSmallWpn, 4*_intNATOSupp, 3*4*_intNATOSupp] call _addWeapon;
[selectRandom bluRifle, 3*_intNATOSupp, 3*3*_intNATOSupp] call _addWeapon;
[selectRandom bluLMG, _intNATOSupp, 3*_intNATOSupp] call _addWeapon;

[selectRandom bluSNPR, _intNATOSupp, 3*_intNATOSupp] call _addWeapon;
(_items select 0) pushBack (bluScopes select 0);
(_items select 1) pushBack _intNATOSupp;

[selectRandom bluAT, _intNATOSupp, 3*_intNATOSupp] call _addWeapon;
[selectRandom bluAA, _intNATOSupp, 3*_intNATOSupp] call _addWeapon;

// - _items because it cannot be repeated.
(_items select 0) pushBack (selectRandom (bluVest - _items));
(_items select 1) pushBack 3*_intNATOSupp;

for "_i" from 1 to 3 do {
	(_items select 0) pushBack (selectRandom (bluAttachments - _items));
	(_items select 1) pushBack _intNATOSupp;
};


if (hayACE) then {
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
	_crate addBackpackCargoGlobal [lrRadio,2];
};

[_crate, _weapons, _magazines, _items, _backpacks, false, true] call AS_fnc_populateBox;
