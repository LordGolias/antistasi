#include "..\..\macros.hpp"
disableSerialization;
private _trait = lbData [0, lbCurSel 0];

if (_trait != "") then {

    if (player call AS_fnc_controlsAI) exitWith {
        hint "You cannot do this while controlling an AI";
    };

    private _cost = [AS_traits, _trait, "cost"] call DICT_fnc_get;
    private _money = if isMultiplayer then {
        [player, "money"] call AS_players_fnc_get
    } else {
        AS_P("resourcesFIA")
    };

    if (_money < _cost) exitWith {
        hint "You do not have enough money for this";
    };
    if isMultiPlayer then {
        [player, "money", -_cost] remoteExec ["AS_players_fnc_change", 2];
    } else {
        [0, -_cost] remoteExec ["AS_fnc_changeFIAmoney", 2];
    };

    player setUnitTrait [[AS_traits, _trait, "trait"] call DICT_fnc_get, true];
    [player, "traits", [_trait]] remoteExec ["AS_players_fnc_change"];
    hint ("You are now also a " + ([AS_traits, _trait, "name"] call DICT_fnc_get));
    waitUntil {sleep 0.1; _trait in ([player, "traits"] call AS_players_fnc_get)};
    call AS_fnc_UI_manageTraits_update;
} else {
    hint "no expertise selected";
};
