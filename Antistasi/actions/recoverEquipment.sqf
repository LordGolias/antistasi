params ["_vehicle"];

if (player getVariable ["loadingCrate", false]) exitWith {
	hint "You are already transfering cargo...";
};
player setVariable ["loadingCrate", true];

private _position = position _vehicle;
private _size = 20;

private _totalRecovered = 0;

// dropped equipment
private _holders = nearestObjects [_position, ["WeaponHolderSimulated", "WeaponHolder"], _size];
_holders = _holders select {count (weaponCargo _x + magazineCargo _x + itemCargo _x) > 0};
{
    private _total = count (weaponCargo _x + magazineCargo _x + itemCargo _x);
    // 1s for every 5 objects in the body
    [_x, _total/5, {true}, {speed _vehicle > 0}, "", "Keep the truck still"] call AS_fnc_wait_or_fail;

	if (speed _vehicle == 0) then {
		[_x, _vehicle] call AS_fnc_transferToBox;
		deleteVehicle _x;
		_totalRecovered = _totalRecovered + _total;
	};
} forEach _holders;


// dead bodies
{
    if not (alive _x) then {
        ([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];

		private _total = 0;
		{
			{_total = _total + _x} forEach (_x select 1);
		} forEach [_cargo_w, _cargo_m, _cargo_i, _cargo_b];

		[_x, _total/5, {true}, {speed _vehicle > 0}, "", "Keep the truck still"] call AS_fnc_wait_or_fail;

		if (speed _vehicle == 0) then {
			[_vehicle, _cargo_w, _cargo_m, _cargo_i, _cargo_b] call AS_fnc_populateBox;
	        _x call AS_fnc_emptyUnit;
			_totalRecovered = _totalRecovered + _total;
		};
    };
} forEach (_position nearObjects ["Man", _size]);

hint format ["%1 items recovered into the truck", _totalRecovered];
[0,true] remoteExec ["AS_fnc_showProgressBar",player];
player setVariable ["loadingCrate", false];
