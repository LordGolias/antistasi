#include "../macros.hpp"
AS_SERVER_ONLY("AS_players_fnc_update_single");
#define PLAYERS_DICT ([AS_container, "players"] call DICT_fnc_get)
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
                    _money = _money + ([typeOf _veh] call AS_fnc_getFIAvehiclePrice);
                    {_money = _money + ([typeOf _x] call AS_fnc_getFIAvehiclePrice)} forEach attachedObjects _veh;
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
