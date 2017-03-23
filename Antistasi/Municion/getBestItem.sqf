params ["_box", "_type"];

private _availableItems = getItemCargo _box;

// best item based on "log(_amount)*(_armor + 1)/(_weight + 1)"
private _sortingFunction = {
	private _index = _input0 find _x;
	private _weight = (_input1 select _index) select 0;
	private _armor = (_input1 select _index) select 1;
	private _amount = (_input1 select _index) select 2;

	private _w_factor = 1.0/(1 + exp (-2*(_amount - 5)));  // 0 => 0; 5 => 0.5; 10 => 1

	_w_factor*(0.1 + _armor)/(1 + _weight/200)
};

private _allItems = [];
private _allItemsAttrs = [];
private _unlockedItems = [];
if (_type == "vest") then {
	_allItems = AS_allVests;
	_allItemsAttrs = AS_allVestsAttrs;
	_unlockedItems = unlockedItems;
};
if (_type == "helmet") then {
	_allItems = AS_allHelmets;
	_allItemsAttrs = AS_allHelmetsAttrs;
	_unlockedItems = unlockedItems;
};
if (_type == "backpack") then {
	_allItems = AS_allBackpacks;
	_allItemsAttrs = AS_allBackpacksAttrs;
	_unlockedItems = unlockedBackpacks;
};

// create the list of _indexes to be sorted and respective properties to use for sorting.
private _indexes = [];
private _attributes = [];
for "_index" from 0 to count _allItems - 1 do {
	private _name = _allItems select _index;
	private _i = (_unlockedItems + (_availableItems select 0)) find _name;

	if (_i != -1) then {
		// if the item is unlocked, use amount=100 for this purpose. Otherwise, use the available amount.
		private _amount = 100;
		if (_i >= count _unlockedItems) then {
			_amount = (_availableItems select 1) select (_i - count _unlockedItems);
		};

		_indexes pushBack _index;
		_attributes pushBack ((_allItemsAttrs select _index) + [_amount]);
	};
};

private _item = "";
if ((count _indexes) > 0) then {
	// select the best item
	_indexes = [_indexes, [_indexes, _attributes], _sortingFunction, "DESCEND"] call BIS_fnc_sortBy;
	_item = _allItems select (_indexes select 0);
};
_item
