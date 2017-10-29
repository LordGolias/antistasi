// whether a player controls an ai
params ["_player"];
_player getVariable ["AS_controller", _player] != _player
