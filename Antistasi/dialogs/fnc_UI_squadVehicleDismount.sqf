if (count hcSelected player != 1) exitWith {
	hint "Select one squad from the High Command";
};

private _grupo = (hcSelected player select 0);

private _isStatic = false;
{
    if (vehicle _x isKindOf "StaticWeapon") exitWith {
        _isStatic = true;
    };
} forEach units _grupo;
if _isStatic exitWith {
    hint "Static Weapon squad vehicles cannot be dismounted"
};

private _veh = objNull;
{
    private _owner = _x getVariable "owner";
    if (!isNil "_owner" and {_owner == _grupo}) exitWith {
        _veh = _x;
    };
} forEach vehicles;

if (isNull _veh) exitWith {
    hint "The squad has no vehicle assigned"
};

private _transporte = true;
if (count allTurrets [_veh, false] > 0) then {
    _transporte = false;
};

if _transporte then {
    if (leader _grupo in _veh) then {
        hint format ["%1 dismounting",groupID _grupo];
        {[_x] orderGetIn false; [_x] allowGetIn false} forEach units _grupo;
    } else {
        hint format ["%1 boarding",groupID _grupo];
        {[_x] orderGetIn true; [_x] allowGetIn true} forEach units _grupo;
    };
} else {
    if (leader _grupo in _veh) then {
        hint format ["%1 dismounting",groupID _grupo];
        if (canMove _veh) then {
            {[_x] orderGetIn false; [_x] allowGetIn false} forEach assignedCargo _veh;
        } else {
            _veh allowCrewInImmobile false;
            {[_x] orderGetIn false; [_x] allowGetIn false} forEach units _grupo;
        }
    } else {
        hint format ["%1 boarding",groupID _grupo];
        {[_x] orderGetIn true; [_x] allowGetIn true} forEach units _grupo;
    };
};
