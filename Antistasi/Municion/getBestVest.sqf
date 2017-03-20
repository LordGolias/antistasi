params ["_box"];
private ["_allItems", "_indexes", "_attributes"];

_allItems = getItemCargo _box;

// create the list of _indexes to be sorted and respective properties to use for sorting.
_indexes = [];
_attributes = [];

for "_index" from 0 to count AS_allVests - 1 do {
	_name = AS_allVests select _index;
	_i = (unlockedItems + (_allItems select 0)) find _name;

	if (_i != -1) then {
		// if the vest is unlocked, use amount=100 for this purpose. Otherwise, use the available amount.
		_amount = 100;
		if (_i >= count unlockedItems) then {
			_amount = (_allItems select 1) select _i;
		};

		_indexes pushBack _index;
		_attributes pushBack ((AS_allVestsAttrs select _index) + [_amount]);
	} else {
		_attributes pushBack ((AS_allVestsAttrs select _index) + [0]);
	};
};

// select the best vest based on "log(_amount)*(_armor + 1)/(_weight + 1)"
_indexes = [_indexes, [], {
	private ["_amount", "_weight", "_armor"];
	_weight = (_attributes select _x) select 0;
	_armor = (_attributes select _x) select 1;
	_amount = (_attributes select _x) select 2;
	(log _amount)*(1 + _armor)/(1 + _weight)
}, "DESCEND"] call BIS_fnc_sortBy;

AS_allVests select (_indexes select 0)
