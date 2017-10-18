// keys that are not to be saved.
#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_toDict");
private _ignore_keys = [];
{
    _ignore_keys append [[_x, "spawn"], [_x, "spawned", "forced_spawned"]];
    if ((_x call AS_location_fnc_type) == "city") then {
        _ignore_keys pushBack [_x, "roads"];
    };
} forEach call AS_location_fnc_all;
[call AS_location_fnc_dictionary, _ignore_keys] call DICT_fnc_copy
