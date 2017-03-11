_g = _this select 0;
_p = _this select 1;

_soldier = ([_p, 0, sol_MK, _g] call bis_fnc_spawnvehicle) select 0;
_soldier = ([_p, 0, sol_MED, _g] call bis_fnc_spawnvehicle) select 0;
_soldier = ([_p, 0, sol_ENG, _g] call bis_fnc_spawnvehicle) select 0;
_soldier = ([_p, 0, sol_LAT2, _g] call bis_fnc_spawnvehicle) select 0;

_g selectLeader (units _g select 1);

_g