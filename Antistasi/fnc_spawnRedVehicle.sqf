params ["_spawnPos", "_vehicleType", "_direction", ["_side", side_red], ["_allVehicles", []], ["_allGroups", []], ["_allSoldiers", []], ["_details", false]];

private _vehicleArray = [_spawnPos, _direction, _vehicleType, _side] call bis_fnc_spawnvehicle;
private _vehicle = _vehicleArray select 0;
private _vehicleCrew = _vehicleArray select 1;
private _vehicleGroup = _vehicleArray select 2;

[_vehicleCrew, _side, _vehicle] call AS_fnc_initRedUnits;

_allVehicles pushBackUnique _vehicle;
_allGroups pushBackUnique _vehicleGroup;
_allSoldiers = _allSoldiers + _vehicleCrew;

private _return = [_allVehicles, _allGroups, _allSoldiers];
if (_details) then {
    _return pushBack [_vehicle, _vehicleGroup, _vehicleCrew];
};
_return;
