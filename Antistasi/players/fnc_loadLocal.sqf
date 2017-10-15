#include "../macros.hpp"
AS_CLIENT_ONLY("fnc_loadLocal");
private _player = player getVariable ["owner", player];

private _id = getPlayerUID player;
_player setUnitRank ([AS_container, "players", _id, "rank"] call DICT_fnc_get);
{
    _player setUnitTrait [[AS_traits, _x, "trait"] call DICT_fnc_get, true];
} forEach ([AS_container, "players", _id, "traits"] call DICT_fnc_get);
hint "Profile loaded.";
