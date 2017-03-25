params ["_box", "_validWeapons", "_recomendedMags"];

private _availableItems = getWeaponCargo _box;
private _availableMags = getMagazineCargo _box;

private _fnc_magazineCount = {
	params ["_magazines"];
	private _total = 0;
	private "_i";
	for "_i" from 0 to count (_availableMags select 0) - 1 do {
		private _mag = (_availableMags select 0) select _i;
		private _amount = (_availableMags select 1) select _i;
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

private _sortingFunction = {
	private _index = _input0 find _x;
	private _weight = (_input1 select _index) select 0;
	private _bullet_energy = (_input1 select _index) select 1;
	private _amount = (_input1 select _index) select 3;
	private _m_count = (_input1 select _index) select 4;

	private _w_factor = 1.0/(1 + exp (-2*_amount + 10));  // 0 => 0; 5 => 0.5; 10 => 1
	private _m_factor = 1.0/(1 + exp (-2*_m_count + 2*_recomendedMags));  // 0 => 0; _recomendedMags => 0.5; 100 => 1

	_m_factor*_w_factor*(1 + _bullet_energy)/(1 + _weight)
};

private _allItems = AS_allWeapons;
private _allItemsAttrs = AS_allWeaponsAttrs;

// create the list of _indexes to be sorted and respective properties to use for sorting.
private _indexes = [];
private _attributes = [];
private _index = 0;
for "_index" from 0 to count _allItems - 1 do {
	private _name = _allItems select _index;

	if (_name in _validWeapons) then {
		private _i = (unlockedWeapons + (_availableItems select 0)) find _name;

		if (_i != -1) then {
			// if the item is unlocked, use amount=100 for this purpose. Otherwise, use the available amount.
			private _amount = 100;
			if (_i >= count unlockedWeapons) then {
				_amount = (_availableItems select 1) select (_i - count unlockedWeapons);
			};

			// compute magazines count for this weapon
			private _m_amount = [(_allItemsAttrs select _index) select 2] call _fnc_magazineCount;

			_indexes pushBack _index;
			_attributes pushBack ((_allItemsAttrs select _index) + [_amount, _m_amount]);
		};
	};
};

private _item = "";
if ((count _indexes) > 0) then {
	// select the best item
	private _indexes = [_indexes, [_indexes, _attributes], _sortingFunction, "DESCEND"] call BIS_fnc_sortBy;
	_item = _allItems select (_indexes select 0);
};
_item
