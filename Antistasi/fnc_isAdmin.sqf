params ["_player"];

if (isServer) then {
    // admin == 2: is logged in admin
    (not isMultiplayer) or {admin owner _player == 2} or {owner _player == 2}
} else {
    // admin function is server-only, detect permissions via serverCommandAvailable (just like CBA's IS_ADMIN macro)
    serverCommandAvailable "#kick"
}
