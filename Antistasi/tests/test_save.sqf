[] spawn {
    private _dict = call DICT_fnc_create;

    [_dict, "AS_fia_arsenal", call AS_FIAarsenal_fnc_toDict] call DICT_fnc_set;

    private _string = _dict call DICT_fnc_serialize;
    copyToClipboard _string;

    private _dict1 = _string call DICT_fnc_deserialize;
    private _string1 = _dict1 call DICT_fnc_serialize;

    dict1 call DICT_fnc_delete;
    dict call DICT_fnc_delete;
    hint str (_string1 == _string)
};

[] spawn {
    (call AS_AAFarsenal_fnc_toDict) call AS_AAFarsenal_fnc_fromDict;
    (call AS_location_fnc_toDict) call AS_location_fnc_fromDict;
    (call AS_hq_fnc_toDict) call AS_hq_fnc_fromDict;
    (call AS_FIAarsenal_fnc_toDict) call AS_FIAarsenal_fnc_fromDict;
    (call AS_persistents_fnc_toDict) call AS_persistents_fnc_fromDict;
    (call AS_mission_fnc_toDict) call AS_mission_fnc_fromDict;
    (call AS_players_fnc_toDict) call AS_players_fnc_fromDict;
};
