params ["_box", "_validWeapons", "_recomendedMags"];
private ["_availableItems", "_availableMags", "_fnc_magazineCount", "_indexes", "_attributes", "_allItems", "_allItemsAttrs"];

_availableItems = getWeaponCargo _box;
_availableMags = getMagazineCargo _box;

_fnc_magazineCount = {
	params ["_magazines"];
	_total = 0;
	for "_i" from 0 to count (_availableMags select 0) - 1 do {
		_mag = (_availableMags select 0) select _i;
		_amount = (_availableMags select 1) select _i;
		// if mag is unlocked, then add 100
		if (_mag in unlockedMagazines) then {
			_total = _total + 100;
		} else {
			if (_mag in _magazines) then {
				_total = _total + _amount;
			};
		};
	};
	_total
};

_sortingFunction = {
	private ["_amount", "_bullet_energy", "_weight", "_factor"];
	_weight = (_attributes select _x) select 0;
	_bullet_energy = (_attributes select _x) select 1;
	_amount = (_attributes select _x) select 3;
	_m_count = (_attributes select _x) select 4;

	_w_factor = 1.0/(1 + exp (-2*_amount + 10));  // 0 => 0; 5 => 0.5; 10 => 1
	_m_factor = 1.0/(1 + exp (-2*_m_count + 2*_recomendedMags));  // 0 => 0; _recomendedMags => 0.5; 100 => 1

	_m_factor*_w_factor*(1 + _bullet_energy)/(1 + _weight)
};

_allItems = AS_allUsableWeapons;
_allItemsAttrs = AS_allUsableWeaponsAttrs;

// create the list of _indexes to be sorted and respective properties to use for sorting.
_indexes = [];
_attributes = [];
for "_index" from 0 to count _allItems - 1 do {
	_name = _allItems select _index;

	if (_name in _validWeapons) then {
		_i = (unlockedWeapons + (_availableItems select 0)) find _name;

		if (_i != -1) then {
			// if the item is unlocked, use amount=100 for this purpose. Otherwise, use the available amount.
			_amount = 100;
			if (_i >= count unlockedWeapons) then {
				_amount = (_availableItems select 1) select (_i - count unlockedWeapons);
			};

			// compute magazines count for this weapon
			_m_amount = [(_allItemsAttrs select _index) select 2] call _fnc_magazineCount;

			_indexes pushBack _index;
			_attributes pushBack ((_allItemsAttrs select _index) + [_amount, _m_amount]);
		} else {
			_attributes pushBack ((_allItemsAttrs select _index) + [0, 0]);
		};
	};
};

_item = nil;
if ((count _indexes) > 0) then {
	// select the best item
	_indexes = [_indexes, [], _sortingFunction, "DESCEND"] call BIS_fnc_sortBy;
	_item = _allItems select (_indexes select 0);
};
_item
