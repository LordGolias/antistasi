class AS_AAFarsenal {
    class common {
        // iterators
        FNC(aaf_arsenal,all);

        // getters
        FNC(aaf_arsenal,get);
        FNC(aaf_arsenal,count);
        FNC(aaf_arsenal,max);
        FNC(aaf_arsenal,name);
        FNC(aaf_arsenal,valid);
        FNC(aaf_arsenal,value);
        FNC(aaf_arsenal,cost);
        FNC(aaf_arsenal,canAdd);
        FNC(aaf_arsenal,category);
    };

    class server {
        // initialize
        FNC(aaf_arsenal,initialize);
        FNC(aaf_arsenal,deinitialize);
        FNC(aaf_arsenal,dictionary);

        // setters
        FNC(aaf_arsenal,set);
        FNC(aaf_arsenal,addVehicle);
        FNC(aaf_arsenal,deleteVehicle);

        // serialize
        FNC(aaf_arsenal,toDict);
        FNC(aaf_arsenal,fromDict);
    };
};
