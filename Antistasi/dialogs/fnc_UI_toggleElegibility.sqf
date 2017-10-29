if not isMultiplayer exitWith {
    hint "Not possible: in single player you are always the commander.";
};

private _player = player getVariable ["AS_controller", player];

private _text = "";

private _eligible = [_player, "elegible"] call AS_players_fnc_get;

if (_player == AS_commander) then {
    ["resigned"] remoteExec ["AS_fnc_chooseCommander", 2];
    _text = "You resigned as commander. Someone suitable will take the command.";
} else {
    if _eligible then {
        [_player, "elegible", false] remoteExec ["AS_players_fnc_set", 2];
        _text = "You are no longer eligible to be commander.";
    } else {
        [_player, "elegible", true] remoteExec ["AS_players_fnc_set", 2];
        _text = "You are now elegible to be commander.";
    };
};
hint _text;
