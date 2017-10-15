#include "../macros.hpp"
AS_SERVER_ONLY("players_fnc_change");
params ["_player", "_attribute", "_value"];
private _id = getPlayerUID _player;
if not ([AS_container, "players", _id] call DICT_fnc_exists) then {
    [AS_container, "players", _id, call DICT_fnc_create] call DICT_fnc_setGlobal;
};
[AS_container, "players", _id, _attribute, _value] call DICT_fnc_setGlobal;
