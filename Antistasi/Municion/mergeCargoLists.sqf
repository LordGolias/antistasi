params ["_cargoList1", "_cargoList2", ["_add", true]];

if (_add) then {
	_add = 1;
} else {
	_add = -1;
};

for "_index2" from 0 to (count (_cargoList2 select 0) - 1) do {
	_name = (_cargoList2 select 0) select _index2;
	_amount2 = (_cargoList2 select 1) select _index2;
	
	_index1 = (_cargoList1 select 0) find _name;

	if (_index1 != -1) then {
		_amount1 = ((_cargoList1 select 1) select _index1);
		(_cargoList1 select 1) set [_index1, _amount1 + _add*_amount2];
	}
	else {
		(_cargoList1 select 0) pushBack _name;
		(_cargoList1 select 1) pushBack (_add*_amount2);
	};
};
_cargoList1
