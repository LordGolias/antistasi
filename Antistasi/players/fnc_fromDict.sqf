#include "../macros.hpp"
AS_SERVER_ONLY("AS_players_fnc_fromDict");

params ["_dict"];
call AS_players_fnc_deinitialize;
[AS_container, "players", _dict call DICT_fnc_copyGlobal] call DICT_fnc_setGlobal;

{
    private _uid = tolower getPlayerUID _x;
    if ([AS_container, "players", _uid] call DICT_fnc_exists) then {
        [] remoteExec ["AS_players_fnc_loadLocal", owner _x];
    };
    private _pos = (getMarkerPos "FIA_HQ") findEmptyPosition [2, 20, typeOf (vehicle _x)];
    _x call AS_fnc_emptyUnit;
    _x call AS_fnc_equipDefault;
    _x setPos _pos;
} forEach allPlayers;
