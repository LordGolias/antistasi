#define DICT_DOUBLES(var1,var2) ##var1##_##var2
#define DICT_QUOTE(var1) #var1
#define DICT_FNC_FILE_BASE(func) DICT_QUOTE(dictionary\DICT_DOUBLES(fnc,func).sqf)
#define DICT_FNC(func) class func {file = DICT_FNC_FILE_BASE(func);}

class DICT {
    class common {
        DICT_FNC(create);

        DICT_FNC(keys);

        DICT_FNC(_set);
        DICT_FNC(set);
        DICT_FNC(setGlobal);

        DICT_FNC(_get);
        DICT_FNC(get);
        DICT_FNC(exists);

        DICT_FNC(_del);
        DICT_FNC(del);
        DICT_FNC(delGlobal);

        DICT_FNC(_copy);
        DICT_FNC(copy);
        DICT_FNC(copyGlobal);

        DICT_FNC(_splitString);
        DICT_FNC(_splitStringDelimited);
        DICT_FNC(serialize);
        DICT_FNC(deserialize);

        DICT_FNC(test);
    };
};
