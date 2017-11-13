// given a vehicle type (`typeOf _veh`), returns its category (or "" if it belongs to none)
params ["_type"];
private _category = "";
{
	if (_type in (_x call AS_AAFarsenal_fnc_valid)) exitWith {_category = _x;};
} forEach call AS_AAFarsenal_fnc_all;
_category
