#include "../macros.hpp"
AS_SERVER_ONLY("AS_AAFarsenal_fnc_initialize");

[AS_container, "aaf_arsenal", call DICT_fnc_create] call DICT_fnc_setGlobal;

// AAF will only buy and use vehicles of the types added here. See template.
private _names = [
    "Trucks", "Cars", "Armed cars", "APCs", "Boats",
    "Transport Helicopters", "Tanks", "Armed Helicopters", "Planes"
];
// The list of all categories.
private _categories = [
    "trucks", "cars_transport", "cars_armed", "apcs", "boats", "helis_transport", "tanks", "helis_armed", "planes"
];
private _costs = [300, 150, 300, 5000, 600, 10000, 4000, 10000, 20000];

{
    [call AS_AAFarsenal_fnc_dictionary, _x, call DICT_fnc_create] call DICT_fnc_setGlobal;
    [_x, "name", _names select _forEachIndex] call AS_AAFarsenal_fnc_set;
    [_x, "count", 0] call AS_AAFarsenal_fnc_set;
    [_x, "cost", _costs select _forEachIndex] call AS_AAFarsenal_fnc_set;
    [_x, "value", (_costs select _forEachIndex)/2] call AS_AAFarsenal_fnc_set;
} forEach _categories;

// the order of which the AAF buys from categories (AS_fnc_spendAAFmoney.sqf)
AS_AAFarsenal_buying_order = +_categories;
