
// functions below are used to gather all the equipment around locations, units, etc.
// they are used to save the complete arsenal

AS_FIAarsenal_fnc_getUnitsEquipment = {
    params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];

    {
        if ((_x getVariable "AS_side" == "FIA") and {alive _x}) then {
            private _arsenal = [_x, true] call AS_fnc_getUnitArsenal;
            _cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
            _cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
            _cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
            _cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
        };
    } forEach allUnits;
    [_cargo_w, _cargo_m, _cargo_i, _cargo_b]
};

AS_FIAarsenal_fnc_getVehiclesEquipment = {
    params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
    {
        private _closest = (getPos _x) call AS_fnc_location_nearest;
        if ((_closest call AS_fnc_location_side == "FIA") and
                ((_x in AS_permanent_HQplacements) or {(_x getVariable "AS_side") == "FIA"}) and
                {alive _x} and
                {_x distance (_closest call AS_fnc_location_position) < 100} and
                {private _invalid = weaponsItemsCargo _x; not isNil "_invalid"}) then {

            private _arsenal = [_x, true] call AS_fnc_getBoxArsenal;
            _cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
            _cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
            _cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
            _cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
        };
    } forEach vehicles;
    [_cargo_w, _cargo_m, _cargo_i, _cargo_b]
};

AS_FIAarsenal_fnc_toDict = {
    private _dict = call DICT_fnc_create;

    private _all = [[[], []], [[], []], [[], []], [[], []]];

    _all = _all call AS_FIAarsenal_fnc_getUnitsEquipment;
    _all = _all call AS_FIAarsenal_fnc_getVehiclesEquipment;

    [_dict, "weapons", _all select 0] call DICT_fnc_set;
    [_dict, "magazines", _all select 1] call DICT_fnc_set;
    [_dict, "items", _all select 2] call DICT_fnc_set;
    [_dict, "backpacks", _all select 3] call DICT_fnc_set;

    [_dict, "unlockedWeapons", unlockedWeapons] call DICT_fnc_set;
    [_dict, "unlockedMagazines", unlockedMagazines] call DICT_fnc_set;
    [_dict, "unlockedItems", unlockedItems] call DICT_fnc_set;
    [_dict, "unlockedBackpacks", unlockedBackpacks] call DICT_fnc_set;

    _dict
};

AS_FIAarsenal_fnc_fromDict = {
    params ["_dict"];
    private _cargo_w = [_dict, "weapons"] call DICT_fnc_get;
    private _cargo_m = [_dict, "magazines"] call DICT_fnc_get;
    private _cargo_i = [_dict, "items"] call DICT_fnc_get;
    private _cargo_b = [_dict, "backpacks"] call DICT_fnc_get;
    [caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;

    unlockedWeapons = [_dict, "unlockedWeapons"] call DICT_fnc_get;
    unlockedMagazines = [_dict, "unlockedMagazines"] call DICT_fnc_get;
    unlockedItems = [_dict, "unlockedItems"] call DICT_fnc_get;
    unlockedBackpacks = [_dict, "unlockedBackpacks"] call DICT_fnc_get;
    publicVariable "unlockedWeapons";
	publicVariable "unlockedMagazines";
	publicVariable "unlockedItems";
	publicVariable "unlockedBackpacks";
};
