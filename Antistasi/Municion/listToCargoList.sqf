/* 
	Given an array of _items with names and a optional "cargo" with [[name1, ...], [count1, ...]]
	it adds "_value" to "_count" for each item with the name, or appends to both lists a new name and count.
	E.g.

	_cargo = [["a", "c"], [1, 1]];
	_cargo = [["a", "b"], _cargo] call listToCargoList;
	// _cargo == [["a", "b", "c"], [2, 1, 1]];
	
	_cargo = [["a", "b", "a"]] call listToCargoList;
	// _cargo == [["a", "b"], [2, 1]]
*/
params ["_items", ["_cargo", [[], []]], ["_value", 1]];

for "_i" from 0 to (count _items - 1) do {
	_name = _items select _i;
	_index = (_cargo select 0) find _name;
	if (_index != -1) then {
		_amount = ((_cargo select 1) select _index);
		(_cargo select 1) set [_index, _amount + _value];
	}
	else {
		(_cargo select 0) pushBack _name;
		(_cargo select 1) pushBack _value;
	};
};
_cargo
