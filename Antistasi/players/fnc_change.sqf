#include "../macros.hpp"
AS_SERVER_ONLY("players_fnc_change");
params ["_player", "_attribute", "_difference", ["_notify", true]];
private _id = getPlayerUID _player;

private _old_amount = [_player, _attribute] call AS_players_fnc_get;
[AS_container, "players", _id, _attribute, _old_amount + _difference] call DICT_fnc_setGlobal;

if (_notify and {_attribute == "money"}) then {
    private _texto = format ["<br/><br/><br/><br/><br/><br/>Money %1 €", _difference];
	[petros, "income", _texto] remoteExec ["AS_fnc_localCommunication", _player];
};
