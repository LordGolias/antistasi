class AS_database {
    class server {
        FNC(database,saveGame);
        FNC(database,loadGame);
        FNC(database,serialize);
        FNC(database,deserialize);
        FNC(database,migrate);
        FNC(database,apply_migration);
        FNC(database,hq_toDict);
        FNC(database,hq_fromDict);
        FNC(database,persistents_toDict);
        FNC(database,persistents_fromDict);
        FNC(database,persistents_start);
        INIT_FNC(database,init);
    };

    class common {
        FNC(database,getData);
        FNC(database,setData);
        FNC(database,deleteSavedGame);
    };

    class withInterface {
        FNC(database,receiveSavedData);
    };
};
