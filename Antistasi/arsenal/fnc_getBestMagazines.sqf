params ["_box", "_weapon", "_maxAmount"];

private _index = AS_allWeapons find _weapon;
if (_index == -1) exitWith {};

// all magazines of this weapon.
private _suitableMags = (AS_allWeaponsAttrs select _index) select 2;

// all magazines of this weapon that are unlocked.
private _alwaysAvailable = _suitableMags arrayIntersect unlockedMagazines;

// check if mags are unlimited. If yes, exit with then
if (count _alwaysAvailable > 0) exitWith {
	// todo: choose best?
	private _mag = _alwaysAvailable select 0;

	[[_mag], [_maxAmount]]
};

// else, fill result with the mags from the box
private _availableMags = getMagazineCargo _box;
private _result = [[], []];  // magazines names, magazines count
private _totalMags = 0;  // sum of the second list of _result.
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
};
_result
