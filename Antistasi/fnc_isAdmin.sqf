params ["_player"];
// admin == 2: is logged in admin
(not isMultiplayer) or {admin owner _player == 2} or {owner _player == 2}
