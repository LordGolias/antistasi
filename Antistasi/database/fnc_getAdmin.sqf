#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_getAdmin");

// in singleplayer/hosted MPs, the host (ownerID 2) is automatically the admin
if not isDedicated exitWith {2};

// in dedicated MPs, admin is the logged admin
private _admin = -1;
{
    if (_x call AS_fnc_isAdmin) exitWith {_admin = owner _x};
} forEach allPlayers;
_admin
