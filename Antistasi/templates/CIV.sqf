private _dict = createSimpleObject ["Static", [0, 0, 0]];
[_dict, "side", str civilian] call DICT_fnc_setLocal;
[_dict, "roles", ["civilian"]] call DICT_fnc_setLocal;
[_dict, "name", "Altis"] call DICT_fnc_setLocal;

[_dict, "units", [
"C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_hunter_1_F",
"C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_fugitive_F",
"C_man_p_shorts_1_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F",
"C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F",
"C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_scientist_F"
]] call DICT_fnc_setLocal;

[_dict, "vehicles", [
"C_Hatchback_01_F",
"C_Hatchback_01_sport_F",
"C_Offroad_01_F",
"C_SUV_01_F",
"C_Van_01_box_F",
"C_Van_01_fuel_F",
"C_Van_01_transport_F",
"C_Truck_02_transport_F",
"C_Truck_02_covered_F"
]] call DICT_fnc_setLocal;

_dict
