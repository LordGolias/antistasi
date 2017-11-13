class AS_database {
    class server {
        FNC(database,saveGame);
        FNC(database,loadGame);
        FNC(database,serialize);
        FNC(database,deserialize);
        FNC(database,hq_toDict);
        FNC(database,hq_fromDict);
        FNC(database,persistents_toDict);
        FNC(database,persistents_fromDict);
        INIT_FNC(database,init);
    };

    class common {
        FNC(database,getData);
        FNC(database,setData);
        FNC(database,deleteSavedGame);
    };

    class withInterface {
        FNC(database,receiveSavedData);

        FNC_UI(database,closeSaveLoadMenu);
        FNC_UI(database,loadSaveMenu);
        FNC_UI(database,selectSave);
        FNC_UI(database,updateSaveGameList);
        FNC_UI(database,saveGame);
        FNC_UI(database,loadFromSavedGame);
        FNC_UI(database,loadFromClipboard);
        FNC_UI(database,deleteGame);
    };
};
