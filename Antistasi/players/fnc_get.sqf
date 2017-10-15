params ["_player", "_attribute"];

private _id = getPlayerUID _player;

if not ([AS_container, "players", _id] call DICT_fnc_exits) then {
    [AS_container, "players", _id, call DICT_fnc_create] call DICT_fnc_setGlobal;
};

if ([AS_container, "players", _id, _attribute] call DICT_fnc_exits) then {
    [AS_container, "players", _id, _attribute] call DICT_fnc_get
} else {
    switch _attribute do {
        case "traits": {[]};
        case "rank": {AS_ranks select 0};
        case "elegible": {if (_player == AS_commander) then {false} else {true}};
        case "money": {100};
        case "score": {if (_player == AS_commander) then {25} else {0}};
        default {nil};
    }
};
