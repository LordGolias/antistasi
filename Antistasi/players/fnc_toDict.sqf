#include "../macros.hpp"
AS_SERVER_ONLY("AS_players_fnc_toDict");

private _dict = ([AS_container, "players"] call DICT_fnc_get) call DICT_fnc_copy;
{
    private _player = _x;
    private _money = [_player, "money"] call AS_players_fnc_get;
    {
        if ((!isPlayer _x) and (alive _x)) then {
            _money = _money + ((_x call AS_fnc_getFIAUnitType) call AS_fnc_getCost);
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
    [_dict, getPlayerUID _player, "money", _money] call DICT_fnc_set;
} forEach (allPlayers - (entities "HeadlessClient_F"));

_dict
