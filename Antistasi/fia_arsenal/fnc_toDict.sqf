#include "../macros.hpp"
AS_SERVER_ONLY("AS_FIAarsenal_fnc_toDict");
private _dict = call DICT_fnc_create;

private _all = [[[], []], [[], []], [[], []], [[], []]];

private _fnc_getUnitsEquipment = {
    params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];

    {
        if ((_x call AS_fnc_getSide == "FIA") and {alive _x}) then {
            private _arsenal = [_x, true] call AS_fnc_getUnitArsenal;
            _cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
            _cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
            _cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
            _cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
        };
    } forEach allUnits;
    [_cargo_w, _cargo_m, _cargo_i, _cargo_b]
};

private _fnc_getVehiclesEquipment = {
    params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
    {
        private _closest = (getPos _x) call AS_location_fnc_nearest;
        if ((_closest call AS_location_fnc_side == "FIA") and
                ((_x in AS_permanent_HQplacements) or {(_x call AS_fnc_getSide) == "FIA"}) and
                {alive _x} and
                {_x distance (_closest call AS_location_fnc_position) < 100} and
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

_all = _all call _fnc_getUnitsEquipment;
_all = _all call _fnc_getVehiclesEquipment;

[_dict, "weapons", _all select 0] call DICT_fnc_setGlobal;
[_dict, "magazines", _all select 1] call DICT_fnc_setGlobal;
[_dict, "items", _all select 2] call DICT_fnc_setGlobal;
[_dict, "backpacks", _all select 3] call DICT_fnc_setGlobal;

[_dict, "unlockedWeapons", unlockedWeapons] call DICT_fnc_setGlobal;
[_dict, "unlockedMagazines", unlockedMagazines] call DICT_fnc_setGlobal;
[_dict, "unlockedItems", unlockedItems] call DICT_fnc_setGlobal;
[_dict, "unlockedBackpacks", unlockedBackpacks] call DICT_fnc_setGlobal;

_dict
