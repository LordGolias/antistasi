#include "../macros.hpp"
AS_SERVER_ONLY("AS_players_fnc_loop");
AS_players_looping = true; // used to stop the loop
while {AS_players_looping} do {
    call AS_players_fnc_update_all;
    sleep 60;
};
