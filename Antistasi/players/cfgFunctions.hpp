#include "../hpp_macros.hpp"

class AS_players {
    class server {
        FNC(players,initialize);
        FNC(players,deinitialize);
        FNC(players,update_single);
        FNC(players,update_all);
        FNC(players,loop);
        FNC(players,toDict);
        FNC(players,fromDict);
    };
};
