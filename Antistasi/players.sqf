#include "macros.hpp"
#define PLAYERS_DICT ([AS_container, "players"] call DICT_fnc_get)

AS_players_fnc_initialize = {
    AS_SERVER_ONLY("AS_players_fnc_initialize");

    if isNil "AS_container" then {
        AS_container = call DICT_fnc_create;
        publicVariable "AS_container";
    };
    [AS_container, "players"] call DICT_fnc_add;

    [] spawn AS_players_fnc_loop;
};

AS_players_fnc_deinitialize = {
    AS_SERVER_ONLY("AS_players_fnc_deinitialize");
    [AS_container, "players"] call DICT_fnc_del;
};

AS_players_fnc_update_single = {
    AS_SERVER_ONLY("AS_players_fnc_update_single");
    params ["_player"];

    // uid must be before going to the original unit since it is attached to the controller
    private _uid = tolower getPlayerUID _player;
    _player = _player getVariable ["owner", _player];
    private _score = _player getVariable "score";
    private _rank = _player getVariable "rank";
    private _money = _player getVariable "money";
    private _garage = _player getVariable "garage";
    {
        if ((!isPlayer _x) and (alive _x)) then {
            _money = _money + (AS_data_allCosts getVariable (_x call AS_fnc_getFIAUnitName));
            if (vehicle _x != _x) then {
                private _veh = vehicle _x;
                if (not(_veh in AS_P("vehicles"))) then {
                    if ((_veh isKindOf "StaticWeapon") or (driver _veh == _x)) then {
                        _money = _money + ([typeOf _veh] call FIAvehiclePrice);
                        {_money = _money + ([typeOf _x] call FIAvehiclePrice)} forEach attachedObjects _veh;
                    };
                };
            };
        };
    } forEach units group _player;

    if not ([PLAYERS_DICT, _uid] call DICT_fnc_exists) then {
        [PLAYERS_DICT, _uid] call DICT_fnc_add;
    };
    [PLAYERS_DICT, _uid, "score", _score] call DICT_fnc_set;
    [PLAYERS_DICT, _uid, "rank", _rank] call DICT_fnc_set;
    [PLAYERS_DICT, _uid, "money", _money] call DICT_fnc_set;
    [PLAYERS_DICT, _uid, "garage", _garage] call DICT_fnc_set;
};

AS_players_fnc_update_all = {
    AS_SERVER_ONLY("AS_players_fnc_update_all");
    {
		if hasInterface then {
            _x call AS_players_fnc_update_single;
		};
	} forEach allPlayers;
};

AS_players_fnc_loop = {
    AS_SERVER_ONLY("AS_players_fnc_loop");
    AS_players_looping = true; // used to stop the loop
    while {AS_players_looping} do {
        call AS_players_fnc_update_all;
        sleep 60;
    };
};

AS_players_fnc_toDict = {
    PLAYERS_DICT call DICT_fnc_copy
};

AS_players_fnc_fromDict = {
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
};
