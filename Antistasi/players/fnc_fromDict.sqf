#include "../macros.hpp"
AS_SERVER_ONLY("AS_players_fnc_fromDict");
#define PLAYERS_DICT ([AS_container, "players"] call DICT_fnc_get)

params ["_dict"];
call AS_players_fnc_deinitialize;
[AS_container, "players", _dict call DICT_fnc_copy] call DICT_fnc_set;

{
    if hasInterface then {
        private _uid = tolower getPlayerUID _x;
        if ([PLAYERS_DICT, _uid] call DICT_fnc_exists) then {
            _x setVariable ["score", [PLAYERS_DICT, _uid, "score"] call DICT_fnc_get, true];
            private _rank = [PLAYERS_DICT, _uid, "rank"] call DICT_fnc_get;
            _x setVariable ["rank", _rank, true];
            _x setUnitRank _rank;
            _x setVariable ["money", [PLAYERS_DICT, _uid, "money"] call DICT_fnc_get, true];
            _x setVariable ["garage", [PLAYERS_DICT, _uid, "garage"] call DICT_fnc_get, true];
            ["Profile loaded."] remoteExecCall ["hint", owner _x];
        };
        private _pos = (getMarkerPos "FIA_HQ") findEmptyPosition [2, 20, typeOf (vehicle _x)];
        _x call AS_fnc_emptyUnit;
        _x setPos _pos;
    };
} forEach allPlayers;
