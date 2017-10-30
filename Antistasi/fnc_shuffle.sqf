// suffle array using in-place Fisher-Yates
private ["_j", "_t"];
for "_i" from count _this - 1 to 1 step -1 do {
	//Select random index
	_j = floor random (_i + 1);

	//Swap
	if (_i != _j) then {
		_t = _this select _i;
		_this set [_i, _this select _j];
		_this set [_j, _t];
	};
};

_this
