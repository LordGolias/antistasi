// the maximum number of vehicles of a given category.
switch _this do {
    case "planes";
    case "armedHelis": {count (["airfield","AAF"] call AS_location_fnc_TS)};
    case "transportHelis": {2*(count (["airfield","AAF"] call AS_location_fnc_TS))};
    case "tanks": {count (["base","AAF"] call AS_location_fnc_TS)};
    case "boats": {count (["seaport","AAF"] call AS_location_fnc_TS)};
    case "apcs";
    case "trucks": {2*(count (["base","AAF"] call AS_location_fnc_TS))};
    case "supplies": {4 + round((count (["base","AAF"] call AS_location_fnc_TS))/2)};
}
