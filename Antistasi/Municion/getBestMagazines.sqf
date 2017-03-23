params ["_box", "_weapon", "_maxAmount"];

private _availableMags = getMagazineCargo _box;

private _index = AS_allUsableWeapons find _weapon;
if (_index == -1) exitWith {};

// all magazines of this weapon.
private _suitableMags = (AS_allUsableWeaponsAttrs select _index) select 2;

// all magazines of this weapon that are unlocked.
private _alwaysAvailable = _suitableMags arrayIntersect unlockedMagazines;

private _result = [[], []];  // magazines names, magazines count
private _totalMags = 0;  // sum of the second list of _result.

private _i = 0;
private _count = count (_availableMags select 0);
for "_i" from 0 to _count - 1 do {
	if (_totalMags == _maxAmount) exitWith {};

	private _mag = (_availableMags select 0) select _i;
	private _amount = (_availableMags select 1) select _i;

	if (_mag in _suitableMags) then {
		(_result select 0) pushBack _mag;
		// cap on maxAmount.
		if (_totalMags + _amount >= _maxAmount) then {
			_amount = _maxAmount - _totalMags;
		};
		(_result select 1) pushBack _amount;

		_totalMags = _totalMags + _amount;
	};

	// after last _i
	if ((_i == _count - 1) and (_totalMags < _maxAmount) and (count _alwaysAvailable > 0)) then {
		// todo: choose best?
		_mag = _alwaysAvailable select 0;

		(_result select 0) pushBack _mag;
		(_result select 1) pushBack (_maxAmount - _totalMags);
		_totalMags = _maxAmount;
	};
};
_result
