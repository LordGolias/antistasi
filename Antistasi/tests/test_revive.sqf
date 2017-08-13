// other units
if not hayACE then {
    ["Rifleman"] call recruitFIAinfantry;
    ["Rifleman"] call recruitFIAinfantry;
    private _unit = (units group player) select 1;
    [_unit, "", 0.98, _unit] call handleDamage;
    _unit setDammage 0.98;

    [] spawn {
        sleep 1;
        private _unit = player;
        [_unit, "", 0.98, _unit] call handleDamage;
        _unit setDammage 0.98;
    }
};
