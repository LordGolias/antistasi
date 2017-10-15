#include "..\macros.hpp"
disableSerialization;
private _trait = lbData [0, lbCurSel 0];

if (_trait != "") then {

    if (call AS_fnc_controlsAI) exitWith {
        hint "You cannot do this while controlling an AI";
    };

    private _cost = [AS_traits, _trait, "cost"] call DICT_fnc_get;
    private _money = if isMultiplayer then {
        player getVariable "money"
    } else {
        P("resourcesFIA")
    };

    if (_money < _cost) exitWith {
        hint "You do not have enough money for this";
    };
    if isMultiPlayer then {
        [player, -_cost] remoteExec ["AS_fnc_changePlayerMoney", 2];
    } else {
        [0, -_cost] remoteExec ["AS_fnc_changeFIAmoney", 2];
    };

    player setUnitTrait [[AS_traits, _trait, "trait"] call DICT_fnc_get, true];
    private _traits = player getVariable "AS_traits";
    player setVariable ["AS_traits", _traits + [_trait], true];
    hint ("You are now also a " + ([AS_traits, _trait, "name"] call DICT_fnc_get));
} else {
    hint "no type selected";
};
