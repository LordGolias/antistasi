// Used by non-ACE to direct a medic to heal a unit
params ["_medic", "_unit"];

// lock the units so others cannot help
_unit setVariable ["AS_medical_assignedMedic", _medic];
_medic setVariable ["AS_medical_assignedPatient", _unit];
[_medic, _unit] call AS_AI_fnc_smokeCover;

if (_medic == _unit) exitWith {
    _medic groupChat "I am patching myself";
    _medic action ["HealSoldierSelf",_medic];
    sleep 10;
    [_unit, false] call AS_medical_fnc_setUnconscious;
    [_unit, _medic] call AS_medical_fnc_clearAssignedMedic;
    _unit groupChat "I am ready";
};

private _canHeal = {(!alive _medic) or (!alive _unit) or (_medic distance _unit < 3)};

_medic groupChat format ["Hold on %1, on my way to help you",name _unit];
private _timeOut = time + 60;

while {true} do {
    _medic doMove getPosATL _unit;
    if ((_timeOut < time) or _canHeal or (_medic call AS_medical_fnc_isUnconscious) or (_unit != vehicle _unit) or (_medic != vehicle _medic)) exitWith {};
    sleep 1;
};
if (call _canHeal) then {
    _medic stop true;
    _unit stop true;
    _medic action ["HealSoldier",_unit];
    sleep 10;
    [_unit, false] call AS_medical_fnc_setUnconscious;
    _medic stop false;
    _unit stop false;
    _unit dofollow leader group _unit;
    _medic doFollow leader group _unit;
    _medic groupChat format ["You are ready, %1", name _unit];
};
// release the units so others can help
[_unit, _medic] call AS_medical_fnc_clearAssignedMedic;
_unit groupChat "I am ready";
