#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_hq_toDict");
private _dict = call DICT_fnc_create;

private _array = [];
{
    _array pushback [getPos _x, getDir _x];
} forEach AS_permanent_HQplacements;
[_dict, "permanents", _array] call DICT_fnc_set;

_array = [];
{
    _array pushback [getPos _x, getDir _x, typeOf _x];
} forEach AS_HQ_placements;
[_dict, "placed", _array] call DICT_fnc_set;
[_dict, "inflame", inflamed fuego] call DICT_fnc_set;

_dict
