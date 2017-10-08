// the maximum number of vehicles of a given category.
switch _this do {
    case "planes";
    case "helis_armed": {count (["airfield","AAF"] call AS_location_fnc_TS)};
    case "helis_transport": {2*(count (["airfield","AAF"] call AS_location_fnc_TS))};
    case "tanks": {count (["base","AAF"] call AS_location_fnc_TS)};
    case "boats": {count (["seaport","AAF"] call AS_location_fnc_TS)};
    case "apcs";
    case "cars_armed";
    case "cars_transport";
    case "trucks": {1 + (count (["base","AAF"] call AS_location_fnc_TS))/2};
}
