class AS_location {
    class server {
        FNC(location,initialize);
        FNC(location,deinitialize);
        // setters
        FNC(location,add);
        FNC(location,remove);
        FNC(location,set);
        FNC(location,increaseBusy);
        FNC(location,spawn);
        FNC(location,despawn);
        // initialize
        FNC(location,init);
        FNC(location,addAllRoadblocks);
        FNC(location,addRoadblocks);
        FNC(location,removeRoadblocks);
        FNC(location,addRoadblock);
        FNC(location,getCityRoads);
        FNC(location,addCities);
        FNC(location,addHills);
        FNC(location,updateMarker);
        // serialization
        FNC(location,toDict);
        FNC(location,fromDict);
    };

    class common {
        // getters
        FNC(location,dictionary);
        FNC(location,exists);
        FNC(location,properties);
        FNC(location,get);
        FNC(location,type);
        FNC(location,size);
        FNC(location,garrison);
        FNC(location,position);
        FNC(location,busy);
        FNC(location,spawned);
        FNC(location,forced_spawned);
        FNC(location,side);
        // Iterators
        FNC(location,all);
        FNC(location,nearest);
        FNC(location,S);
        FNC(location,T);
        FNC(location,TS);
        FNC(location,cities);
        // auxiliar
        FNC(location,getNameSize);

        // spawn states of each location
        INIT_FNC(location\spawns,AAFairfield);
        INIT_FNC(location\spawns,AAFbase);
        INIT_FNC(location\spawns,AAFcity);
        INIT_FNC(location\spawns,AAFgeneric);
        INIT_FNC(location\spawns,AAFhill);
        INIT_FNC(location\spawns,AAFhillAA);
        INIT_FNC(location\spawns,AAFoutpost);
        INIT_FNC(location\spawns,AAFoutpostAA);
        INIT_FNC(location\spawns,AAFroadblock);
        INIT_FNC(location\spawns,CIVcity);
        INIT_FNC(location\spawns,FIAairfield);
        INIT_FNC(location\spawns,FIAbase);
        INIT_FNC(location\spawns,FIAbuilt_location);
        INIT_FNC(location\spawns,FIAgeneric);
        INIT_FNC(location\spawns,Minefield);
        INIT_FNC(location\spawns,NATOroadblock);
    };
};

class AS_location_spawn {
    class common {
        // common state functions to spawn locations
        FNC(location\spawn,AAFlocation_clean);
        FNC(location\spawn,AAFwait_capture);
        FNC(location\spawn,FIAlocation_clean);
        FNC(location\spawn,FIAlocation_run);
    };
};
