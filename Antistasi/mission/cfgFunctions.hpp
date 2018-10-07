class AS_mission {

    class server {
        FNC(mission,initialize);
        FNC(mission,deinitialize);
        FNC(mission,add);
        FNC(mission,create);
        FNC(mission,remove);
        FNC(mission,set);
        FNC(mission,updateAvailable);
        FNC(mission,activate);
        FNC(mission,toDict);
        FNC(mission,fromDict);

        FNC(mission,execute);
        FNC(mission,success);
        FNC(mission,fail);

        FNC(mission,createDefendLocation);
        FNC(mission,createDefendCamp);
        FNC(mission,createDefendCity);
        FNC(mission,createDefendHQ);
    };

    class common {
        FNC(mission,dictionary);
        FNC(mission,all);
        FNC(mission,get);
        FNC(mission,status);
        FNC(mission,type);
        FNC(mission,location);
        FNC(mission,active_missions);
        FNC(mission,available_missions);
        FNC(mission,title);
        FNC(mission,name);
        FNC(mission,spawn_states);

        FNC(mission,_description);
        FNC(mission,_getSuccessData);
        FNC(mission,_getFailData);
        FNC(mission,getSuccessDescription);
        FNC(mission,getFailDescription);

        INIT_FNC(mission\spawns,assassinate);
        INIT_FNC(mission\spawns,black_market);
        INIT_FNC(mission\spawns,broadcast);
        INIT_FNC(mission\spawns,conquer);
        INIT_FNC(mission\spawns,CONVOY);
        INIT_FNC(mission\spawns,defend_camp);
        INIT_FNC(mission\spawns,defend_city);
        INIT_FNC(mission\spawns,defend_hq);
        INIT_FNC(mission\spawns,defend_location);
        INIT_FNC(mission\spawns,destroy_antenna);
        INIT_FNC(mission\spawns,destroy_helicopter);
        INIT_FNC(mission\spawns,destroy_vehicle);
        INIT_FNC(mission\spawns,establishFIAlocation);
        INIT_FNC(mission\spawns,establishFIAminefield);
        INIT_FNC(mission\spawns,help_meds);
        INIT_FNC(mission\spawns,kill_traitor);
        INIT_FNC(mission\spawns,NATOAmmo);
        INIT_FNC(mission\spawns,natoArmor);
        INIT_FNC(mission\spawns,natoArtillery);
        INIT_FNC(mission\spawns,natoAttack);
        INIT_FNC(mission\spawns,natoCAS);
        INIT_FNC(mission\spawns,natoQRF);
        INIT_FNC(mission\spawns,natoRoadblock);
        INIT_FNC(mission\spawns,natoUAV);
        INIT_FNC(mission\spawns,pamphlets);
        INIT_FNC(mission\spawns,repair_antenna);
        INIT_FNC(mission\spawns,rescue);
        INIT_FNC(mission\spawns,rob_bank);
        INIT_FNC(mission\spawns,send_meds);
        INIT_FNC(mission\spawns,stealAmmo);
    };
};

class AS_mission_spawn {
    class common {
        FNC(mission\spawn,clean);
        FNC(mission\spawn,saveTask);
        FNC(mission\spawn,loadTask);
    };
};
