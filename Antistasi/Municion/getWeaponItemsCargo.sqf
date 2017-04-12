// add everything inside _weaponsItemsCargo (includes the weapon)
params ["_weaponsItemsCargo"];
private ["_weapons", "_magazines", "_items"];
_weapons = [];
_magazines = [];
_items = [];

{
	_weapon = [(_x select 0)] call BIS_fnc_baseWeapon;
	_weapons pushBack ([(_x select 0)] call BIS_fnc_baseWeapon);

	_magazines pushBack ((_x select 4) select 0);

	for "_i" from 1 to (count _x) - 1 do {
		_cosa = _x select _i;
		if (typeName _cosa == typeName "") then {
			if (_cosa != "") then {_items pushBack _cosa};
		};
	};
} forEach _weaponsItemsCargo;
[_weapons, _magazines, _items]
