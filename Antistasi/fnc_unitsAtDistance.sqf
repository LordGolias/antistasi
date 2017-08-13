/*
Returns all units from a given distance from a given reference point that have a given variable true
if mode is not "array", it just returns whether there is any units or not:
	_distance: the distance.
	_reference: the position
	_variable: the variable. Normally "OPFORSpawn" or "BLUFORSpawn"
	_mode: "array" (default) to select units, "boolean" to check the existence
*/
params ["_distance", "_reference", "_variable", ["_mode", "array"]];

if (_mode == "array") then {
	allUnits select {_x getVariable [_variable,false] and {_x distance _reference < _distance}}
} else {
	private _result = false;
	{
		if ((_x getvariable [_variable,false]) and {_x distance _reference < _distance}) exitWith {
			_result = true
		};
	} forEach allUnits;
	_result
};
