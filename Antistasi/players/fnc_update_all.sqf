#include "../macros.hpp"
AS_SERVER_ONLY("AS_players_fnc_update_all");
{
    if (hasInterface and isMultiplayer) then {
        _x call AS_players_fnc_update_single;
    };
} forEach allPlayers;
