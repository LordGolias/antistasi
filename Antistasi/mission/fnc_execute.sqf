// converts the outcome values to changes in the game state of the game.
#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_execute");
params [["_commander_score", 0],
        ["_players_score", 0],
        ["_prestige", [0, 0]],
        ["_resourcesFIA", [0, 0]],
        ["_citySupport", [0, 0, []]],
        ["_changeAAFattack", 0],
        ["_custom", []],
        ["_increaseBusy", ["", 0]]
];
private _increase_players_score = {
    params ["_size", "_position", "_value"];
    {
        if (isPlayer _x) then {[_value,_x] call AS_fnc_changePlayerScore;};
    } forEach ([_size, _position, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);
};

if not (_commander_score == 0) then {
    [_commander_score, AS_commander] call AS_fnc_changePlayerScore;
};
if not (_players_score IsEqualTo 0) then {
    _players_score call _increase_players_score;
};
if not (_prestige IsEqualTo [0, 0]) then {
    _prestige call AS_fnc_changeForeignSupport;
};
if not (_resourcesFIA IsEqualTo [0, 0]) then {
    _resourcesFIA call AS_fnc_changeFIAmoney;
};
if not (_citySupport IsEqualTo [0, 0, []]) then {
    _citySupport call AS_fnc_changeCitySupport;
};
if not (_changeAAFattack == 0) then {
    [1800] call AS_fnc_changeSecondsforAAFattack;
};
if not (_increaseBusy IsEqualTo ["", 0]) then {
    _increaseBusy call AS_location_fnc_increaseBusy;
};
if not (_custom IsEqualTo []) then {
    {
        (_x select 2) call (_x select 1);
    } forEach _custom;
};
