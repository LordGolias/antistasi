params ["_cargoList1", "_cargoList2", ["_add", true]];

private _fnc_add = {
    params ["_cargo1", "_cargo2"];
    {
		private _amount2 = (_cargo2 select 1 select _forEachIndex);
        private _index = (_cargo1 select 0) find _x;
        if (_index != -1) then {
			private _amount1 = (_cargo1 select 1 select _index);
            (_cargo1 select 1) set [_index, _amount1 + _amount2];
        } else {
            (_cargo1 select 0) pushBack _x;
            (_cargo1 select 1) pushBack _amount2;
        };
    } forEach (_cargo2 select 0);
};

private _fnc_remove = {
    params ["_cargo1", "_cargo2"];
    {
		private _amount2 = (_cargo2 select 1 select _forEachIndex);
        private _index = (_cargo1 select 0) find _x;
        if (_index != -1) then {
			private _amount1 = (_cargo1 select 1 select _index);
			if (_amount2 >= _amount1) then {
				(_cargo1 select 0) deleteAt _index;
	            (_cargo1 select 1) deleteAt _index;
			} else {
				(_cargo1 select 1) set [_index, _amount1 - _amount2];
			};
        };
    } forEach (_cargo2 select 0);
};

private _fnc = _fnc_add;
if not _add then {
	_fnc = _fnc_remove;
};

[_cargoList1, _cargoList2] call _fnc;
_cargoList1
