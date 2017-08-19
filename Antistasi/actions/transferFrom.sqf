params ["_destination"];

if (player getVariable ["loadingCrate", false]) exitWith {
	hint "You are already transfering cargo...";
};

private _candidates = nearestObjects [_destination, ["LandVehicle", "ReammoBox_F"], 20];
_candidates = _candidates select {not (_x isKindOf "StaticWeapon")};
_candidates = _candidates - [_destination];
if (count _candidates == 0) exitWith {hint "No valid target to transfer from."};
private _origin = _candidates select 0;

private _total = count (weaponCargo _origin + magazineCargo _origin + itemCargo _origin);

if (_total == 0) exitWith {
	hint "closest crate has no cargo";
};

player setVariable ["loadingCrate", true];
_total = round (_total / 100);
if (caja in [_destination, _origin]) then {
	// in HQ attacks, transfer is 10x slower.
	if (count ("aaf_attack_hq" call AS_fnc_active_missions) != 0) then {
		_total = round (_total * 10);
	};
};
_total = _total max 1; // min 1s
_total = _total min 120; // max 2m

private _fnc_stopCondition = {
	speed _origin > 0 or {speed _destination > 0}
};

[_origin, _total, {true}, _fnc_stopCondition] call AS_fnc_wait_or_fail;

if (call _fnc_stopCondition) then {
	hint "Movement cancelled transfer";
} else {
	[_origin, _destination] call AS_fnc_transferToBox;
};

[0,true] remoteExec ["pBarMP",player];
player setVariable ["loadingCrate", false];
