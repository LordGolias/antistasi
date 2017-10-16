#include "../macros.hpp"
AS_CLIENT_ONLY("fnc_loadLocal");
private _player = player getVariable ["owner", player];

_player setUnitRank ([player, "rank"] call AS_players_fnc_get);
{
    _player setUnitTrait [[AS_traits, _x, "trait"] call DICT_fnc_get, true];
} forEach ([player, "traits"] call AS_players_fnc_get);
hint "Profile loaded.";
