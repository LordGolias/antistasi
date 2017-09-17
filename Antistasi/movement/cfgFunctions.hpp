class AS_movement {

    class server {
        FNC(movement,sendAAFroadPatrol);
        FNC(movement,sendAAFpatrol);
        FNC(movement,sendEnemyQRF);
        FNC(movement,sendAAFattack);
    };

    class common {
        INIT_FNC(movement\spawns,AAFpatrol);
        INIT_FNC(movement\spawns,AAFroadPatrol);
    };
};
