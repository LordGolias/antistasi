params ["_box", "_weapon", ["_maxAmount", 6]];
private ["_availableItems", "_availableMags", "_fnc_magazineCount", "_indexes", "_attributes", "_allItems", "_allItemsAttrs"];

_availableMags = getMagazineCargo _box;

_index = AS_allUsableWeapons find _weapon;
if (_index == -1) exitWith {};

// all magazines of this weapon.
_suitableMags = (AS_allUsableWeaponsAttrs select _index) select 2;

// all magazines of this weapon that are unlocked.
_alwaysAvailable = _suitableMags arrayIntersect unlockedMagazines;

_result = [[], []];  // magazines names, magazines count
_totalMags = 0;  // sum of the second list of _result.

_i = 0;
_count = count (_availableMags select 0);
while {_totalMags < _maxAmount or (_i < _count)} do {
	_mag = (_availableMags select 0) select _i;
	_amount = (_availableMags select 1) select _i;

	if (_mag in _suitableMags) then {
		(_result select 0) pushBack _mag;
		// cap on maxAmount.
		if (_totalMags + _amount >= _maxAmount) then {
			_amount = _maxAmount - _totalMags;
		};
		(_result select 1) pushBack _amount;

		_totalMags = _totalMags + _amount;
	};
	_i = _i + 1;

	// after last _i
	if ((_i == _count) and (_totalMags < _maxAmount) and (count _alwaysAvailable > 0)) then {
		// todo: choose best?
		_mag = _alwaysAvailable select 0;

		(_result select 0) pushBack _mag;
		(_result select 1) pushBack (_maxAmount - _totalMags);
		_totalMags = _maxAmount;
	};
};

_result
