#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_getAdmin");
if not isMultiplayer exitWith {2};

// in hosted MPs, admin is the host and does not need to be logged in
if not isDedicated exitWith {2};

// in dedicated MPs, admin is the logged admin
private _admin = -1;
{
    // == 2: is logged in
    if (admin _x == 2) exitWith {_admin = _x};
} forEach allPlayers;
_admin
