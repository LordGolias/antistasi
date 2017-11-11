params ["_availableWeapons", "_availableMagazines", "_validWeapons", "_recomendedMags"];

_availableWeapons params ["_availableWeaponsTypes", "_availableWeaponsCounts"];
_availableMagazines params ["_availableMagazinesTypes", "_availableMagazinesCounts"];

private _fnc_magazineCount = {
	params ["_magazines"];
	private _total = 0;
    {
        private _indexOfAvailable = _availableMagazinesTypes find _x;
        if (_indexOfAvailable != -1) then {
            private _amount = _availableMagazinesCounts select _indexOfAvailable;
			_total = _total + _amount;
		};
    } forEach _magazines;
	_total
};

private _sortingFunction = {
	private _weight = (_input0 select _x) select 0;
	private _bullet_energy = (_input0 select _x) select 1;
	private _amount = (_input0 select _x) select 3;
	private _m_count = (_input0 select _x) select 4;

	private _w_factor = 1.0/(1 + exp (-2*_amount + 10));  // 0 => 0; 5 => 0.5; 10 => 1
	private _m_factor = 1.0/(1 + exp (-2*_m_count + 2*_recomendedMags));  // 0 => 0; _recomendedMags => 0.5; 100 => 1

	_m_factor*_w_factor*(1 + _bullet_energy)/(1 + _weight)
};

_validWeapons = _validWeapons arrayIntersect _availableWeaponsTypes arrayIntersect AS_allWeapons;

// create the list of attributes respective of each valid weapon type
private _indexes = [];
private _attributes = [];
{
    // compute available weapons and magazines count for this weapon
    private _indexOfAvailable = _availableWeaponsTypes find _x;

    private _w_amount = _availableWeaponsCounts select _indexOfAvailable;
    private _index = AS_allWeapons find _x;
    private _validMagazines = (AS_allWeaponsAttrs select _index) select 2;
    private _m_amount = [_validMagazines] call _fnc_magazineCount;

    _attributes pushBack ((AS_allWeaponsAttrs select _index) + [_w_amount, _m_amount]);
    _indexes pushBack _forEachIndex;
} forEach _validWeapons;

private _bestWeapon = "";
if ((count _validWeapons) > 0) then {
	// select the best item
	private _indexes = [_indexes, [_attributes], _sortingFunction, "DESCEND"] call BIS_fnc_sortBy;
	_bestWeapon = _validWeapons select (_indexes select 0);
};
_bestWeapon
