private ["_center", "_objects"];
private _dict = [AS_compositions, "locations"] call DICT_fnc_get;


_center = [8413.79, 10242];
_objects = [
	["Land_Pallets_stack_F",[7.74902,119.005,0.0240021],126.927,1,0,[-6.23325e-005,0.000395441],"","",true,false],
	["Land_Pallets_stack_F",[7.97656,119.354,-0.0169964],38.7302,1,0,[0.00172157,-0.00131572],"","",true,false],
	["Land_Pallets_stack_F",[8.58496,120.265,0.0240002],36.1388,1,0,[0.000124663,-0.000164637],"","",true,false],
	["Land_Pallets_stack_F",[9.12207,121.061,-0.0169811],106.324,1,0,[0.000490301,-0.000603871],"","",true,false],
	["Land_Pallets_stack_F",[9.49219,121.407,0.0240002],37.6407,1,0,[0.000181983,0.000154705],"","",true,false],
	["Land_BarGate_01_open_F",[118.196,-62.1563,-0.104023],123.573,1,0,[-1.18267,1.78158],"","",true,false],
	["Land_Barricade_01_4m_F",[108.552,-83.5928,0],303.2,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[120.201,-71.0986,-1.90735e-006],303.117,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[138.577,-19.2988,-1.90735e-006],87.8217,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[128.572,-57.1611,-1.90735e-006],301.683,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[89.0098,-112.801,-1.90735e-006],207.011,1,0,[0,0],"","",true,false],
	["Land_Barricade_01_10m_F",[138.569,54.7109,0],89.6423,1,0,[0,0],"","",true,false],
	["Land_Barricade_01_4m_F",[29.7637,146.603,0],129.123,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-20.5889,150.677,0.0176773],214.176,1,0,[0,0],"","",true,false],
	["Land_Pallets_stack_F",[88.9971,127.835,0.0284405],29.8508,1,0,[4.42249,-1.42611],"","",true,false],
	["Land_Pallet_vertical_F",[88.1514,130.847,-0.567997],26.9097,1,0,[-84.3819,-82.806],"","",true,false],
	["Land_Razorwire_F",[123.012,106.077,0.00883484],33.2869,1,0,[-0.634793,0.131614],"","",true,false],
	["Land_Barricade_01_4m_F",[-58.2871,157.09,0],212.915,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-191.789,81.7686,0.149519],287.774,1,0,[6.69429,0.551329],"","",true,false],
	["Land_BarGate_01_open_F",[-189.425,87.9492,-0.0618858],43.5949,1,0,[-6.9613,1.58621],"","",true,false],
	["Land_Razorwire_F",[-200.453,91.085,1.56127],336.68,1,0,[5.54974,13.7992],"","",true,false],
	["Land_Razorwire_F",[-227.161,189.188,0.0605469],132.585,1,0,[-12.1841,0.666042],"","",true,false]
];
[_dict, "AS_factory_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_1", "objects", _objects] call DICT_fnc_set;

_center = [9008.41, 11211.7];
_objects = [
	["Land_spp_Panel_Broken_F",[6.04688,-17.249,0.299583],193.407,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[13.791,-19.2021,0.328041],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Transformer_F",[-8.27344,-33.1094,0.0162888],192.889,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[21.6523,-21.1328,0.626495],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[2.47363,-33.6465,0.316986],193.48,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[-17.7246,36.5732,-0.0775681],290.514,1,0,[1.92861,-3.84004],"","",true,false],
	["Land_spp_Panel_F",[10.2021,-35.499,0.468521],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_Broken_F",[29.4717,-22.9521,0.565727],193.597,1,0,[-7.45901,-2.13028],"","",true,false],
	["Land_BagFence_01_end_green_F",[-17.4795,38.3086,-0.02108],277.933,1,0,[0.91863,-3.26224],"","",true,false],
	["Land_Barricade_01_4m_F",[43.959,9.95508,0],167.591,1,0,[-3.99149,2.4473],"","",true,false],
	["Land_spp_Panel_Broken_F",[17.9209,-37.4248,0.401466],193.407,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[37.1768,-24.8281,0.414413],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[25.7949,-39.2686,0.262634],193.48,1,0,[0,0],"","",true,false],
	["Land_Barricade_01_10m_F",[-35.2686,-39.0156,0],106.709,1,0,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[-2.25098,-49.8027,0.173386],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[5.41797,-51.5664,0.236374],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[44.959,-26.6553,0.292442],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[33.5342,-41.0586,0.156647],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[13.0967,-53.3486,0.250305],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_Broken_F",[20.9141,-55.1836,0.0553055],193.407,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[41.1338,-42.7852,0.0839844],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[52.7695,-28.541,0.314629],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[28.7373,-56.8887,0.0891495],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[48.8271,-44.5801,0.0366974],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_Broken_F",[60.4922,-30.4717,0.190529],193.407,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[36.4229,-58.5352,0.142433],193.48,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-59.2744,48.0313,0.00301361],283.57,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-60.5439,47.1631,-0.00415039],15.1217,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[56.6016,-46.3408,-0.0145569],193.48,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-57.7061,54.083,-0.0011673],283.57,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-58.6504,53.1689,-0.00292969],195.296,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[44.2051,-60.3945,0.0922012],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[68.3115,-32.3242,0.0434113],193.48,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-30.9248,74.2578,0.145561],186.042,1,0,[-10.1649,1.25246],"","",true,false],
	["Land_BagFence_01_long_green_F",[-55.8877,60.6719,-0.00784302],284.226,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-57.2617,59.7539,-0.00177765],195.296,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_end_green_F",[-55.4248,62.4844,-0.00520325],284.744,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_Broken_F",[64.3604,-48.1621,0.00990295],193.407,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_Broken_F",[51.9883,-62.3164,0.0651016],193.407,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[76.0684,-34.0938,-0.000259399],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[72.0947,-49.8252,0.0743637],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[59.751,-64.1328,0.076889],193.48,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[67.4688,-65.8662,0.116585],193.48,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-94.7959,-47.1875,0.653488],17.4441,1,0,[1.68422,5.32619],"","",true,false],
	["Land_Razorwire_F",[-114.485,-1.75781,1.43736],105.362,1,0,[-13.5479,11.8788],"","",true,false]
];
[_dict, "AS_powerplant_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_3", "objects", _objects] call DICT_fnc_set;

_center = [8887.51, 11878.4];
_objects = [
	["Land_BagFence_01_end_green_F",[0.649414,-1.07813,-0.00195313],325.495,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_long_green_F",[-0.93457,-2.14453,-0.00183105],146.786,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-1.49902,-2.47363,0.845688],324.625,1,0,[0,0],"","",true,false],
	["Land_PalletTrolley_01_yellow_F",[-10.5391,17.542,0.0251007],289.246,1,0,[1.28495,-2.29979],"","",true,false],
	["Land_Razorwire_F",[39.25,15.6494,0.13533],68.3669,1,0,[2.71975,1.05726],"","",true,false],
	["Land_Razorwire_F",[-74.1953,16.0889,0.943283],39.8025,1,0,[-3.38535,8.07131],"","",true,false]
];
[_dict, "AS_resource_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_3", "objects", _objects] call DICT_fnc_set;

_center = [8760.08, 13777.5];
_objects = [
	["Land_BagFence_01_short_green_F",[-5.13867,-18.8145,1.07945],288.947,1,0,[0.685283,-0.702255],"","",true,false],
	["Land_BagFence_01_short_green_F",[-2.75586,-19.7383,1.58399],111.761,1,0,[-0.718936,0.667762],"","",true,false],
	["CargoNet_01_barrels_F",[-20.126,1.02148,0.0241127],248.185,1,0,[-0.000158546,-4.52849e-005],"","",true,false],
	["Land_BagFence_01_round_green_F",[-4.41016,-20.5713,-0.474569],16.7774,1,0,[0.727689,0.658212],"","",true,false],
	["Land_MetalBarrel_F",[-21.4844,4.04102,0.024127],207.897,1,0.0059904,[0.000190978,-0.003801],"","",true,false],
	["CargoNet_01_barrels_F",[-21.8564,2.00391,0.0241127],326.051,1,0,[1.98821e-005,-0.000100258],"","",true,false],
	["CargoNet_01_barrels_F",[-21.9365,-1.21387,0.0241127],26.5261,1,0,[-4.30929e-005,4.03187e-006],"","",true,false],
	["CargoNet_01_barrels_F",[-23.8291,0.672852,0.0241127],141.663,1,0,[-2.93727e-006,-8.11526e-005],"","",true,false],
	["CargoNet_01_barrels_F",[-23.6133,3.43066,0.0241137],46.8711,1,0,[-1.82668e-005,-1.71601e-005],"","",true,false],
	["Land_BagFence_01_short_green_F",[6.21094,-24.2646,0.515181],288.954,1,0,[0.0591627,0.0203185],"","",true,false],
	["CargoNet_01_barrels_F",[-25.8828,1.48633,0.0241127],214.353,1,0,[-3.71225e-005,-8.16218e-005],"","",true,false],
	["Land_BagFence_01_short_green_F",[8.5918,-25.1816,-0.0165215],111.761,1,0,[-0.718936,0.667762],"","",true,false],
	["Land_BagFence_01_round_green_F",[6.92578,-26.0195,1.25371],16.7659,1,0,[-0.307055,2.02626],"","",true,false],
	["CargoNet_01_barrels_F",[-27.9424,2.63672,0.0241127],110.328,1,0,[-0.000129414,-0.00011627],"","",true,false],
	["Land_MetalBarrel_empty_F",[-38.5127,9.34668,0],212.161,1,0,[0,0],"","",true,false],
	["Land_MetalBarrel_empty_F",[-39.167,10.1895,0],211.257,1,0,[0,0],"","",true,false],
	["Ornate_random_F",[40.2002,30.3271,-0.816279],7.5474,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-22.1846,56.1084,0.421291],25.7743,1,0,[-10.3278,3.34781],"","",true,false],
	["Land_Razorwire_F",[-26.918,57.7607,-0.0394411],194.184,1,0,[0.184551,-0.110084],"","",true,false],
	["Land_Razorwire_F",[-82.4316,31.2021,-1.87459],206.433,1,0,[0,0],"","",true,false],
	["Land_Barricade_01_4m_F",[-94.2119,94.4385,0],114.689,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_factory_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_2", "objects", _objects] call DICT_fnc_set;

_center = [6699.56, 12361.5];
_objects = [
	["Land_spp_Panel_F",[5.37744,-3.81641,-0.206051],142.61,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_end_green_F",[-11.8784,-9.76953,-0.00329208],44.4274,1,0,[-0.0195767,0.0199719],"","",true,false],
	["Land_BagFence_01_end_green_F",[-12.3589,-9.2168,0.00102806],225.111,1,0,[0.0198136,-0.0197369],"","",true,false],
	["Land_BagFence_01_end_green_F",[-13.1826,-8.49316,-0.00301552],44.4274,1,0,[-0.0195767,0.0199719],"","",true,false],
	["Land_BagFence_01_long_green_F",[-9.68555,-12.3896,-0.00258827],226.523,1,0,[0.020294,-0.0192425],"","",true,false],
	["Land_BagFence_01_short_green_F",[-14.0464,-7.5625,-0.00115776],46.244,1,0,[-0.0201999,0.0193413],"","",true,false],
	["Land_BagFence_01_short_green_F",[-7.73877,-14.3564,-0.00130463],46.244,1,0,[-0.0201999,0.0193413],"","",true,false],
	["Land_spp_Panel_F",[12.002,1.16699,0.791523],142.61,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-15.6494,-7.38184,0.00682259],315.896,1,0,[0.0194637,0.020082],"","",true,false],
	["Land_BagFence_01_short_green_F",[-5.49561,-16.71,-0.00973892],46.244,1,0,[-0.0201999,0.0193413],"","",true,false],
	["Land_BagFence_01_end_green_F",[-4.63184,-17.6406,-0.00561333],44.4274,1,0,[-0.0195767,0.0199719],"","",true,false],
	["Land_BagFence_01_end_green_F",[-16.6226,-8.27832,0.000640869],318.399,1,0,[0.0185679,0.020913],"","",true,false],
	["Land_spp_Transformer_F",[-2.43555,-18.3516,-0.00896835],226.211,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-5.24561,-18.6963,-0.00471687],134.835,1,0,[-0.0198322,-0.0197181],"","",true,false],
	["Land_SolarPanel_3_F",[-17.2124,-12.9512,-0.138241],45.8339,1,0,[0,0],"","",true,false],
	["Land_SolarPanel_3_F",[-12.0381,-18.3477,-0.139959],45.8339,1,0,[0,0],"","",true,false],
	["Land_WaterTower_01_F",[-20.1875,-5.81152,0.00346756],47.7035,1,0,[0,0],"","",true,false],
	["Land_spp_Panel_F",[6.22021,-20.0752,-0.350639],142.61,1,0,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[12.9404,-15.1768,-0.345657],142.61,1,0.025215,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[19.3066,-10.2549,-0.358685],142.61,1,0,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[15.1211,-30.75,-0.846249],142.61,1,0,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[21.8359,-25.5986,-0.599428],142.61,1,0,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[28.9185,-20.7988,0.245132],142.61,1,0,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[35.9351,-15.4395,-0.400446],142.61,1,0,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[42.251,-9.88086,-1.0227],142.61,1,0,[0,-0],"","",true,false],
	["Land_spp_Panel_F",[48.8584,-5.2168,0.537176],142.61,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_powerplant_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_4", "objects", _objects] call DICT_fnc_set;

_center = [5475.81, 11934.3];
_objects = [
	["Land_Wreck_Ural_F",[-7.12891,9.92578,0.00151062],128.276,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-7.07959,37.0947,0.0266247],127.826,1,0,[0.669786,0.133671],"","",true,false],
	["Land_Pallets_stack_F",[35.2515,-14.3828,-0.0175052],176.629,1,0,[-0.00495457,0.00355544],"","",true,false],
	["Land_Pallets_stack_F",[35.3076,-14.2998,0.024045],84.0465,1,0,[0.00149468,0.00233127],"","",true,false],
	["Land_Pallets_stack_F",[35.3525,-14.2539,-0.0169988],85.3058,1,0,[0.00455624,0.00570633],"","",true,false],
	["Land_Wreck_Ural_F",[-18.1274,-45.415,0.00151062],178.982,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_corner_green_F",[-31.8882,-39.9092,-0.000999928],183.411,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_long_green_F",[-31.9146,-42.8896,-0.000999928],273.623,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_end_green_F",[-36.1816,-39.4785,-0.000999928],1.74823,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-31.9351,-43.5107,0.835999],272.039,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_long_green_F",[-38.04,-39.4258,-0.000999928],182.151,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-39.6431,-40.3369,-0.000999928],92.5372,1,0,[0,-0],"","",true,false],
	["RoadBarrier_F",[-42.5479,-40.3076,0.0200367],359.995,1,0.0100877,[-0.342637,0.000320846],"","",true,false],
	["Land_WallSign_01_chalkboard_F",[-36.5767,-47.4863,1.07344],182.983,1,0,[0,0],"","",true,false],
	["Land_Barricade_01_10m_F",[23.1421,72.667,0],326.301,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[62.0542,68.7744,-0.126881],36.5542,1,0,[0.604834,-1.07296],"","",true,false]
];
[_dict, "AS_factory_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_3", "objects", _objects] call DICT_fnc_set;

_center = [5430.76, 11196.4];
_objects = [
	["Land_Razorwire_F",[-18.4854,16.0625,-0.00912714],211.885,1,0,[0.209285,-0.0487573],"","",true,false],
	["Land_BagFence_01_long_green_F",[37.2529,32.5518,-0.000999928],141.152,1,0,[0,-0],"","",true,false],
	["Land_Barricade_01_4m_F",[44.4609,21.9629,0],236.949,1,0,[0,0],"","",true,false],
	["Land_Pallets_stack_F",[41.0361,28.0664,0.0240064],52.9742,1,0,[-7.20503e-005,-6.89713e-006],"","",true,false],
	["Land_Pallet_vertical_F",[41.7036,28.6152,0.0240879],55.2499,1,0,[-0.0383139,0.00140687],"","",true,false],
	["Land_BagFence_01_round_green_F",[39.5757,32.6816,-0.00130129],233.568,1,0,[0,0],"","",true,false],
	["Land_Pallets_stack_F",[48.8799,16.7021,0.0240126],52.9742,1,0,[-9.91147e-005,-1.79124e-005],"","",true,false],
	["Land_Pallet_vertical_F",[49.5474,17.251,0.0240936],55.2499,1,0,[-0.0381831,0.0013992],"","",true,false],
	["Land_MetalBarrel_F",[-56.9585,-1.91211,0.0240135],359.969,1,0.00604338,[-3.54959e-005,-0.00398197],"","",true,false],
	["Land_Razorwire_F",[-37.3833,41.0088,-2.86102e-006],230.243,1,0,[0,0],"","",true,false],
	["Land_MetalBarrel_F",[-60.0776,-5.41797,0.024014],359.969,1,0.00604345,[-2.35472e-005,-0.00396563],"","",true,false],
	["Land_MetalBarrel_F",[-60.0938,-6.72852,0.0240145],91.296,1,0.00617416,[0.000128388,-0.0041041],"","",true,false],
	["Land_MetalBarrel_F",[-60.7378,-6.32715,0.0240111],359.989,1,0,[-0.00164035,-0.00337453],"","",true,false],
	["Land_MetalBarrel_F",[-61.1816,-5.35938,0.0240135],252.436,1,0.00603938,[0.000135266,-0.00383652],"","",true,false],
	["Land_MetalBarrel_F",[-61.4497,-6.42383,0.0240083],0.0158768,1,0,[-0.00293566,-0.000206673],"","",true,false],
	["CargoNet_01_barrels_F",[-63.5317,-6.50684,0.0239997],166.751,1,0,[1.79019e-005,-1.70786e-005],"","",true,false],
	["CargoNet_01_barrels_F",[-65.2358,-4.37305,0.0239997],55.3474,1,0,[-2.4148e-005,-0.000117529],"","",true,false],
	["Land_PalletTrolley_01_yellow_F",[-65.6646,-9.93164,0.0240011],268.49,1,0,[-0.00033683,3.58311e-005],"","",true,false],
	["CargoNet_01_barrels_F",[-66.5068,-2.35449,0.0240002],328.919,1,0,[-0.000142207,8.76736e-005],"","",true,false],
	["CargoNet_01_barrels_F",[-67.1973,-6.04102,0.0239997],143.516,1,0,[-0.000131363,-2.46653e-005],"","",true,false],
	["CargoNet_01_barrels_F",[-67.6045,-9.75684,0.0240002],317.828,1,0,[-2.13237e-005,5.7855e-005],"","",true,false],
	["CargoNet_01_barrels_F",[-68.8843,-3.80078,0.0240006],320.392,1,0,[-0.000146382,-9.12567e-005],"","",true,false],
	["CargoNet_01_barrels_F",[-69.2422,-7.58691,0.0239997],317.829,1,0,[-0.000137201,-2.55364e-005],"","",true,false],
	["CargoNet_01_barrels_F",[-70.8198,-5.45215,0.0239997],317.831,1,0,[-4.11067e-005,6.95162e-005],"","",true,false],
	["Land_Razorwire_F",[-88.2295,-111.679,0.00509596],199.314,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-96.7163,-110.488,0.947488],155.517,1,0,[-6.67521,8.43952],"","",true,false],
	["Land_Razorwire_F",[-104.68,-114.116,0.387118],152.666,1,0,[1.33275,2.5771],"","",true,false],
	["Land_Razorwire_F",[-111.294,-118.429,1.04483],125.571,1,0,[0.208134,7.06298],"","",true,false]
];
[_dict, "AS_resource_6", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_6", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_6", "objects", _objects] call DICT_fnc_set;

_center = [10095.3, 11772.4];
_objects = [
	["Land_BagBunker_01_small_green_F",[8.94336,-10.4238,0],275.768,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_wall_6_green_F",[13.7988,6.03613,-0.0174255],97.4155,1,0,[0.433818,-3.32946],"","",true,false],
	["Land_Razorwire_F",[13.5029,-14.8535,0.0248108],253.343,1,0,[0.57058,0.307788],"","",true,false],
	["Land_HBarrier_01_line_1_green_F",[13.7852,13.5176,0],138.727,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[15.4092,13.8867,0],228.806,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_line_3_green_F",[5.65332,-36.1787,0],185.997,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[6.99609,-38.168,0],182.909,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_line_5_green_F",[-11.9697,44.7012,0],231.628,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-9.36914,44.4102,0],228.806,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_line_1_green_F",[-14.0215,47.4131,0],52.6718,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_line_5_green_F",[-69.7969,-16.373,0],181.917,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-68.4609,-18.0996,-0.00271606],180.503,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_line_5_green_F",[-59.334,60.7129,0],184.106,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-57.3008,62.8018,-0.000946045],184.686,1,0,[1.06597,0.0873942],"","",true,false],
	["Land_Razorwire_F",[-114.043,-13.71,0.0697937],190.412,1,0,[-0.494097,0.996696],"","",true,false],
	["Land_HBarrier_01_line_5_green_F",[-114.379,54.4063,0],169.724,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-116.294,56.4238,0.0279236],351.711,1,0,[-8.40591,1.23329],"","",true,false],
	["Land_Razorwire_F",[-146.009,42.0059,0.162903],325.554,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpostAA_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_3", "objects", _objects] call DICT_fnc_set;

_center = [10961.5, 11458.8];
_objects = [
	["Land_HBarrier_01_big_tower_green_F",[8.66895,8.76563,-0.000427246],58.2,1,0,[0.321988,0.519306],"","",true,false],
	["Land_Razorwire_F",[5.78711,-11.667,-0.0238342],341.065,1,0,[0.239546,-0.244181],"","",true,false],
	["Land_Razorwire_F",[-40.4307,-21.8447,-0.0328979],355.219,1,0,[-0.304126,0.025437],"","",true,false],
	["Land_Razorwire_F",[-45.8379,29.3408,0.222809],129.602,1,0,[-2.53069,3.05798],"","",true,false],
	["Land_HBarrier_01_wall_6_green_F",[-55.9219,15.1709,0],309.352,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_wall_6_green_F",[-57.9912,1.90039,0],267.076,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_wall_6_green_F",[-56.9434,-19.626,0],267.076,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_line_5_green_F",[-58.7197,9.35254,0],87.0312,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-1.23633,67.7451,0],215.211,1,0,[0,0],"","",true,false],
	["Land_BagBunker_01_large_green_F",[59.7285,44.2285,0.00814819],91.8875,1,0,[-0.788925,0.738024],"","",true,false],
	["Land_Razorwire_F",[84.0117,-10.7539,-0.00183105],1.41692,1,0,[0,0],"","",true,false],
	["Land_IRMaskingCover_01_F",[98.1445,29.999,0.00823975],181.246,1,0,[0.746817,0.780618],"","",true,false],
	["Land_HBarrier_01_line_1_green_F",[36.6328,100.464,0],124.281,1,0,[0,-0],"","",true,false],
	["Land_HBarrier_01_line_1_green_F",[37.2227,101.856,0],207.191,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_line_1_green_F",[37.7773,103.542,0],0,1,0,[0,0],"","",true,false],
	["Land_IRMaskingCover_01_F",[97.4736,56.1846,-0.00250244],0,1,0,[0,-0.763614],"","",true,false],
	["Land_Razorwire_F",[52.0137,121.187,-0.0388184],182.547,1,0,[7.61413,-0.276346],"","",true,false],
	["Land_HBarrier_01_wall_corner_green_F",[75.0068,117.868,0.000366211],3.45834,1,0,[-1.82936,-0.110591],"","",true,false],
	["Land_IRMaskingCover_01_F",[138.757,28.8096,0],1.93613,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[139.83,-13.5693,-0.00418091],3.32811,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[107.419,102.371,-0.0241089],182.536,1,0,[-5.47804,-0.243393],"","",true,false],
	["Land_IRMaskingCover_01_F",[141.145,52.6924,-0.0038147],184.611,1,0,[0.122825,-1.52258],"","",true,false],
	["Land_Razorwire_F",[160.396,-16.6494,-0.0434875],30.8517,1,0,[-2.64735,-1.22563],"","",true,false],
	["Land_MedicalTent_01_greenhex_closed_F",[168.292,37.8447,0.00012207],2.94242,1,0,[-0.0392,0.762598],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[159.436,102.712,0],32.4373,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[185.235,-33.0254,0],3.32811,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[167.098,100.522,0],0,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[192.987,-33.4609,0],1.41525,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[175.482,100.429,0],0,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_tower_green_F",[210.303,-20.6445,0],275.995,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[216.467,-0.995117,-0.0010376],275.322,1,0,[-0.152573,-0.0142132],"","",true,false],
	["Land_Razorwire_F",[219.595,38.9063,0],276.471,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[209.254,82.4053,-0.303497],231.039,1,0,[-3.06778,-2.82025],"","",true,false],
	["Land_Razorwire_F",[221.494,61.7617,0],276.471,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_3", "objects", _objects] call DICT_fnc_set;

_center = [11855.3, 13095];
_objects = [
	["Land_HBarrier_01_tower_green_F",[-55.043,52.0205,0],286.722,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_wall_corner_green_F",[5.80957,-87.6377,0.000501156],104.437,1,0,[0.685645,-2.66143],"","",true,false],
	["Land_BagBunker_01_large_green_F",[-107.741,-15.7012,0],14.2228,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_wall_6_green_F",[-174.409,-6.16992,0],200.975,1,0,[0,0],"","",true,false],
	["Land_BagBunker_01_large_green_F",[-156.458,80.3379,0],287.276,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_wall_6_green_F",[-188.844,-0.991211,0],199.375,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_long_green_F",[-204.49,14.2891,-0.00145626],110.314,1,0,[-0.0454431,-0.0168227],"","",true,false],
	["Land_BagFence_01_short_green_F",[-205.405,8.58887,-0.00173426],200.357,1,0,[0.0168564,-0.0454307],"","",true,false],
	["Land_BagFence_01_long_green_F",[-205.843,10.5615,-0.00145626],110.314,1,0,[-0.0454431,-0.0168227],"","",true,false],
	["Land_HBarrier_01_line_5_green_F",[-207.981,3.23242,0],20.215,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-209.317,6.53906,0],46.2894,1,0,[0,0],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[-216.234,-15.7725,0.000189781],18.5782,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-219.089,12.7754,6.67572e-006],356.579,1,0,[0,0],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[-227.463,-12.3066,0.150827],18.5782,1,0,[0,0],"","",true,false],
	["PlasticBarrier_03_orange_F",[-234.647,29.8887,-0.000998974],19.6268,1,0,[-0.0125295,0.0373616],"","",true,false],
	["PlasticBarrier_03_orange_F",[-234.081,37.5625,-0.000998974],19.6256,1,0,[-0.0135706,0.0372463],"","",true,false],
	["PlasticBarrier_03_orange_F",[-238.554,24.3574,-0.000999451],19.6261,1,0,[-0.0125724,0.037405],"","",true,false],
	["Land_HBarrier_01_tower_green_F",[-223.511,99.4307,0],17.1824,1,0,[0,0],"","",true,false],
	["Land_BagBunker_01_large_green_F",[250.988,-38.6201,0],17.6226,1,0,[0,0],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[-282.418,5.54199,0.0484095],16.8758,1,0,[0,0],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[-293.744,8.65332,0],16.8758,1,0,[0,0],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[-321.223,17.6738,4.48227e-005],16.8758,1,0,[0,0],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[-332.579,20.7822,0.000211716],16.8758,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-333.621,23.8096,4.86374e-005],333.441,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_tower_green_F",[331.889,-61.8184,0],195.817,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[366.199,-75.1855,0.0500937],15.5894,1,0,[4.40633,1.23163],"","",true,false],
	["Land_BagFence_01_round_green_F",[366.859,-72.3359,-0.00130129],184.684,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[368.129,-74.1816,0.0048542],283.169,1,0,[0,0],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[319.822,-221.213,0.00069046],51.2388,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[-365.154,138.771,0.010294],8.20921,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[356.383,-160.476,-0.000999928],14.5345,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[-364.318,141.606,-0.00130129],199.068,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[-366.309,140.69,-0.00130129],106.695,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_long_green_F",[358.726,-161.131,-0.0312572],16.2871,1,0,[0.214168,-0.732972],"","",true,false],
	["Land_PortableLight_double_F",[360.145,-160.594,-0.000284195],347.334,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_long_green_F",[361.517,-159.455,0.0112085],288.475,1,0,[-0.434735,0.338087],"","",true,false],
	["Land_BagFence_01_corner_green_F",[360.653,-161.388,-0.00463057],104.964,1,0,[1.01418,-0.835874],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[327.427,-230.171,0.000576019],51.2388,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[373.499,-164.66,-0.0039463],37.0877,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[376.567,-162.638,0.000359535],197.783,1,0,[0.09321,-0.290608],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[379.127,-186.187,0],13.8172,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[387.35,-188.419,0],15.7688,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[395.13,-188.01,0],333.664,1,0,[0,0],"","",true,false]
];
[_dict, "AS_airfield_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield_3", "objects", _objects] call DICT_fnc_set;

_center = [13400.8, 12056.2];
_objects = [
	["Land_IRMaskingCover_02_F",[-88.1006,49.6084,0],21.9976,1,0,[0,0],"","",true,false],
	["Land_IRMaskingCover_01_F",[-99.084,-62.9238,0],293.844,1,0,[0,0],"","",true,false],
	["Land_IRMaskingCover_01_F",[-115.114,-55.4375,0],293.844,1,0,[0,0],"","",true,false],
	["Land_MedicalTent_01_brownhex_closed_F",[-93.0713,-107.607,5.00679e-006],116.396,1,0,[-0.136106,-0.0675524],"","",true,false],
	["Land_HBarrier_01_big_tower_green_F",[-143.276,61.2617,0],113.174,1,0,[0,-0],"","",true,false],
	["Land_HBarrier_01_wall_corner_green_F",[-150.646,47.1904,0],295.763,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[-142.396,69.3115,0],115.399,1,0,[0,-0],"","",true,false],
	["Land_HBarrier_01_wall_4_green_F",[-152.853,42.1953,0],294.715,1,0,[0,0],"","",true,false],
	["RoadBarrier_F",[-153.723,50.6709,0.0200009],295.001,1,0.0121599,[-0.322388,0.000102241],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[-151.547,62.9063,0],108.723,1,0,[0,-0],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[-155.764,51.7168,0],113.854,1,0,[0,-0],"","",true,false],
	["Land_Barricade_01_4m_F",[213.513,-304.422,0],22.3729,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[236.356,-312.203,-2.38419e-006],13.8548,1,0,[0,0],"","",true,false],
	["Land_Barricade_01_10m_F",[279.622,-321.459,0],10.4558,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[302.958,-329.466,-2.38419e-006],12.6821,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[336.276,-337.687,-2.38419e-006],14.9342,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[400.279,-332.868,-2.38419e-006],333.211,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[429.436,-317.451,-0.000526905],332.932,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[479.078,-291.999,-2.38419e-006],351.134,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[548.45,-174.77,0],200.795,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[558.583,-139.595,0.0104618],290.008,1,0,[-4.19684,-0.0674608],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[552.894,-174.142,0],197.394,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[568.524,-114.812,0.108497],289.976,1,0,[-3.02708,1.17447],"","",true,false],
	["Land_BagFence_01_long_green_F",[557.876,-192.425,-0.00166035],111.84,1,0,[-0.0580646,-0.0232716],"","",true,false],
	["Land_SignM_WarningMilAreaSmall_english_F",[563.38,-178.274,0],197.394,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[558.208,-194.369,-2.14577e-006],19.87,1,0,[-0.0212615,0.0588304],"","",true,false],
	["Land_BagFence_01_long_green_F",[562.9,-187.605,-0.00262856],199.231,1,0,[0.0206044,-0.0590637],"","",true,false],
	["Land_HBarrier_01_big_4_green_F",[565.361,-181.76,0],200.795,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[542.621,-265.226,-0.000257492],290.053,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[609.686,-66.2129,0],0,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[612.055,-66.6416,-0.267408],153.382,1,0,[-1.23198,-2.45721],"","",true,false],
	["Land_CzechHedgehog_01_F",[615.468,-66.7246,0],152.387,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[617.618,-61.7275,0],244.1,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[616.799,-63.8672,0.00518227],327.432,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[671.768,-29.9912,-2.38419e-006],326.671,1,0,[0,0],"","",true,false]
];
[_dict, "AS_seaport_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_seaport_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_seaport_2", "objects", _objects] call DICT_fnc_set;

_center = [11902.2, 10302.8];
_objects = [
	["Land_Pallet_F",[5.06348,12.2871,2.95229],131.39,1,0,[0,-0],"","",true,false],
	["Land_Pallet_F",[4.04297,13.1816,2.93758],131.39,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_long_green_F",[6.42383,12.7334,-0.143997],312.85,1,0,[0,0],"","",true,false],
	["Land_Pallet_F",[2.94141,14.1689,2.89693],131.39,1,0,[0,-0],"","",true,false],
	["Land_Pallet_F",[6.20996,13.3447,2.92764],131.39,1,0,[0,-0],"","",true,false],
	["Land_Pallet_F",[5.09375,14.3125,2.91066],131.39,1,0,[0,-0],"","",true,false],
	["Land_Pallet_F",[3.97852,15.293,2.89467],131.39,1,0,[0,-0],"","",true,false],
	["Land_Pallet_F",[7.23633,14.4697,2.9055],131.39,1,0,[0,-0],"","",true,false],
	["Land_Pallet_F",[6.13184,15.4463,2.89204],131.39,1,0,[0,-0],"","",true,false],
	["Land_Pallet_F",[5.01563,16.4268,2.87038],131.39,1,0,[0,-0],"","",true,false],
	["Land_Pallet_F",[5.00488,16.4209,0],131.39,1,0,[0,-0],"","",true,false],
	["Land_PierLadder_F",[4.65137,17.167,0.537033],132.151,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_long_green_F",[9.33887,15.9326,0.0286407],312.85,1,0,[0.0205032,0.0190194],"","",true,false],
	["Land_BagFence_01_short_green_F",[10.9629,17.7139,0.00819397],314.569,1,0,[0.0199236,0.0196258],"","",true,false],
	["Land_BagFence_01_short_green_F",[12.4258,19.2207,-0.00187683],133.133,1,0,[-0.020409,-0.0191205],"","",true,false],
	["Land_BagFence_01_long_green_F",[14.0996,21.0127,0.000869751],312.85,1,0,[0.0205032,0.0190194],"","",true,false],
	["Land_BagFence_01_long_green_F",[17.5029,25.0547,-0.000488281],312.85,1,0,[0.0205032,0.0190194],"","",true,false],
	["Land_Barricade_01_10m_F",[19.4326,34.9619,0],41.8092,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-111.236,-7.04199,0.0128021],16.8916,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-111.545,-18.2969,-0.66832],267.077,1,0,[2.31733,-5.75934],"","",true,false],
	["Land_CzechHedgehog_01_F",[-110.697,-24.2197,0.0128021],250.55,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-112.107,-30.5869,0.384827],125.128,1,0,[-5.15942,3.08262],"","",true,false],
	["Land_Razorwire_F",[90.3818,-77.2539,4.27374],109.335,1,0,[10.686,38.1976],"","",true,false],
	["Land_CzechHedgehog_01_F",[87.2402,-85.1836,0],85.5551,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-117.673,-38.958,0.000671387],85.5551,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-121.671,-53.2021,0],110.292,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[90.4971,-97.5635,-0.0193176],85.5551,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-118.498,-62.6846,-0.121918],253.171,1,0,[-2.86936,-1.04674],"","",true,false],
	["Land_Razorwire_F",[97.3545,-103.887,1.27252],218.635,1,0,[6.73753,9.31264],"","",true,false],
	["Land_Razorwire_F",[69.8223,-166.817,0.993744],134.871,1,0,[4.33616,7.72732],"","",true,false],
	["Land_CzechHedgehog_01_F",[64.3955,-172.476,0],351.584,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[63.0615,-174.494,-0.0676575],301.957,1,0,[-5.55664,-2.03588],"","",true,false],
	["Land_CzechHedgehog_01_F",[55.8232,-185.354,0],148.487,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[52.1211,-193.546,0.0329895],291.248,1,0,[-4.39136,-0.0715831],"","",true,false],
	["Land_CzechHedgehog_01_F",[50.6943,-200.35,0],224.659,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-162.499,-190.365,0.441193],222.684,1,0,[-9.42404,3.32165],"","",true,false],
	["Land_CzechHedgehog_01_F",[-158.051,-194.371,0],272.494,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-169.884,-184.07,-0.372818],75.9118,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-152.809,-202.398,-0.210846],239.041,1,0,[-7.96309,-1.4279],"","",true,false],
	["Land_BagFence_01_round_green_F",[-147.892,-205.626,0.00247192],44.4479,1,0,[5.80209,-1.78908],"","",true,false],
	["Land_CzechHedgehog_01_F",[-150.758,-206.365,0],89.4631,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-124.94,-223.259,0],333.121,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-131.125,-219.849,-0.0848389],208.297,1,0,[-9.12878,-1.27064],"","",true,false],
	["Land_Razorwire_F",[-117.21,-229.287,-0.365295],225.392,1,0,[-9.65673,-2.18596],"","",true,false],
	["Land_CzechHedgehog_01_F",[-139.46,-216.768,0],333.121,1,0,[0,0],"","",true,false]
];
[_dict, "AS_resource_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_1", "objects", _objects] call DICT_fnc_set;

_center = [13761.9, 10953.3];
_objects = [
	["Land_TentA_F",[2.94922,2.45996,0.100418],25.8023,1,0,[11.8762,-6.98507],"","",true,false],
	["Land_TentA_F",[-5.19727,5.88379,0.0438843],301.456,1,0,[-13.0799,-17.9234],"","",true,false],
	["Land_TentA_F",[-1.82617,9.94238,0.0272217],341.416,1,0,[5.28022,-16.3898],"","",true,false],
	["Land_TentA_F",[9.6709,-5.96289,0.0160065],41.8467,1,0,[13.6598,-2.26399],"","",true,false],
	["Land_PortableLight_double_F",[-12.3574,-0.886719,0.160538],87.9031,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-4.22461,-13.7061,0.183228],41.8138,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-11.9219,10.6533,-2.04991],327.646,1,0,[4.33284,-18.4615],"","",true,false],
	["Land_TentA_F",[6.6709,-14.7275,0.0273438],175.747,1,0,[-9.73353,15.7656],"","",true,false],
	["Land_TentA_F",[12.7939,-10.2734,0.012619],78.2205,1,0,[9.66359,8.66796],"","",true,false],
	["Land_TentA_F",[11.4404,-14.5186,0.14856],153.146,1,0,[-4.39555,18.0749],"","",true,false],
	["Land_Razorwire_F",[-19.6475,1.36426,-1.59712],275.838,1,0,[-25.9577,-21.5819],"","",true,false],
	["Land_Razorwire_F",[-15.6064,-12.335,-1.11392],256.737,1,0,[-28.2743,-12.0213],"","",true,false],
	["Land_Razorwire_F",[-7.05664,-20.9141,-2.21912],0,1,0,[14.0722,-22.6788],"","",true,false],
	["Land_Razorwire_F",[8.13867,-24.4326,1.54066],191.249,1,0,[-17.8104,13.2014],"","",true,false],
	["Land_PortableLight_double_F",[13.2998,-21.5469,0.0868988],354.344,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[19.8594,-19.6377,1.4054],148.446,1,0,[-2.60376,10.5274],"","",true,false]
];
[_dict, "AS_outpost_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_3", "objects", _objects] call DICT_fnc_set;

_center = [5361.96, 10052.8];
_objects = [
	["Land_Razorwire_F",[5.83105,-56.1016,-0.227456],37.0887,1,0,[-1.82753,-1.38179],"","",true,false],
	["Land_Razorwire_F",[18.7695,-56.1758,-0.0492487],180.093,1,0,[4.27012,0.00691574],"","",true,false],
	["Land_Razorwire_F",[-43.0098,-54.4893,-2.38419e-006],181.511,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[63.272,-57.3184,0.003618],161.403,1,0,[2.99261,-0.20084],"","",true,false],
	["Land_BagFence_01_long_green_F",[126.042,-8.48535,-0.00554895],159.834,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-119.097,-48.0986,-0.00125766],37.0667,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[125.607,-25.2256,0.0923114],267.992,1,0,[-4.40355,0.613392],"","",true,false],
	["Land_BagFence_01_long_green_F",[129.078,-6.49512,-0.0320873],313.967,1,0,[-1.42928,-1.37866],"","",true,false],
	["Land_PortableLight_double_F",[136.062,4.38086,-0.00356126],320.645,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_long_green_F",[136.604,2.93555,0.0664666],136.699,1,0,[3.03789,2.7739],"","",true,false],
	["Land_PortableLight_double_F",[-136.863,-8.39355,-7.67708e-005],87.923,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_short_green_F",[-137.714,-8.35547,-0.0010066],269.801,1,0,[0.0279663,-9.69614e-005],"","",true,false],
	["Land_BagFence_01_short_green_F",[-137.843,-10.25,-0.00100446],90.702,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_long_green_F",[-139.442,10.2207,-0.000999928],123.456,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_long_green_F",[-139.934,4.8623,-0.0642941],87.6629,1,0,[-0.0424875,-2.41293],"","",true,false],
	["Land_BagFence_01_round_green_F",[-140.577,7.69922,-0.00130129],83.0101,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[-79.8086,156.403,0.0014081],270.82,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[-81.2534,158.197,-0.0857573],187.535,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[-89.3608,156.574,0.000358582],98.615,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_round_green_F",[-87.5405,157.985,-0.00381899],181.9,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[114.235,214.819,-0.869776],98.615,1,0,[0,-0],"","",true,false],
	["Land_BagFence_01_round_green_F",[116.056,216.23,-0.0215945],181.9,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[135.795,210.623,-0.0774581],269.705,1,0,[0,0],"","",true,false],
	["Land_BagFence_01_round_green_F",[134.315,212.388,-0.908773],186.421,1,0,[0,0],"","",true,false]
];
[_dict, "AS_seaport_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_seaport_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_seaport_1", "objects", _objects] call DICT_fnc_set;

_center = [4338.16, 8489.29];
_objects = [
	["Land_Barricade_01_10m_F",[-32.5742,-25.9395,0],51.2536,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-32.7573,-33.0127,0.0589385],52.4612,1,0,[-4.60458,0.270147],"","",true,false],
	["Land_Barricade_01_10m_F",[-84.1724,33.7363,0],61.8562,1,0,[0,0],"","",true,false],
	["Land_Barricade_01_4m_F",[-93.1606,43.4395,0],45.5527,1,0,[0,0],"","",true,false],
	["Land_Barricade_01_10m_F",[-99.4648,46.4385,0],13.4221,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-77.79,-82.3193,0.0509405],157.912,1,0,[7.00941,0.2937],"","",true,false],
	["Land_Razorwire_F",[189.395,162.735,0.0999436],11.2447,1,0,[-0.238424,0.419978],"","",true,false],
	["Land_CzechHedgehog_01_F",[198.918,160.72,0],72.127,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[211.903,155.147,0],72.127,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[216.633,152.715,-0.041863],29.6911,1,0,[-0.322973,-0.359074],"","",true,false],
	["Land_CzechHedgehog_01_F",[224.711,145.629,0],205.671,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[231.055,138.277,-0.0672073],225.182,1,0,[-3.02133,-0.656544],"","",true,false],
	["Land_CzechHedgehog_01_F",[235.541,132.091,0],205.671,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[240.85,123.982,0.0651832],238.716,1,0,[0.867433,0.545546],"","",true,false]
];
[_dict, "AS_factory_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_4", "objects", _objects] call DICT_fnc_set;

_center = [7487.32, 9658.32];
_objects = [
	["Land_Razorwire_F",[-13.9092,3.35059,-0.0214233],317.31,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[16.6992,-6.99414,-0.386246],226.332,1,0,[4.17721,-3.35739],"","",true,false],
	["Land_Cargo_Tower_V4_F",[-6.04053,22.2871,0],313.432,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[22.5962,12.5234,-0.427887],262.862,1,0,[4.11297,-4.05079],"","",true,false],
	["Land_PortableLight_double_F",[19.0762,19.9814,-0.00109863],239.451,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-27.9526,5.91602,1.85269],294.255,1,0,[-1.6209,13.2712],"","",true,false],
	["Land_Razorwire_F",[-14.1245,25.873,-0.929184],127.803,1,0,[10.7261,-9.28857],"","",true,false],
	["Land_PortableLight_double_F",[-10.2627,27.0527,0.0224609],166.61,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[28.5869,-5.5459,-0.55455],97.7868,1,0,[-8.11393,-4.65356],"","",true,false],
	["Land_PortableLight_double_F",[23.5767,-19.7178,0.0326691],266.781,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[0.0390625,30.7344,-0.0517273],180.116,1,0,[11.0175,-0.755591],"","",true,false],
	["Land_Razorwire_F",[20.1382,26.7422,0.768234],216.63,1,0,[4.95287,6.35533],"","",true,false]
];
[_dict, "AS_outpostAA_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_1", "objects", _objects] call DICT_fnc_set;

_center = [12865.2, 8591.69];
_objects = [
	["Land_PortableLight_double_F",[-8.22852,4.45605,0.0271759],62.8972,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-7.87695,9.62109,-1.94818],315.993,1,0,[9.66671,-21.3918],"","",true,false],
	["Land_Cargo_Tower_V4_F",[2.72266,2.17871,0.776443],4.02708,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-7.72852,-12.9902,0.80632],239.829,1,0,[-8.38158,7.34137],"","",true,false],
	["Land_Razorwire_F",[-4.29395,-24.7607,0.593475],33.4289,1,0,[28.3022,2.3477],"","",true,false],
	["Land_Razorwire_F",[27.5791,18.9766,3.2343],26.9288,1,0,[-15.2509,25.5415],"","",true,false],
	["Land_PortableLight_double_F",[35.4863,9.69141,-0.0221252],218.664,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[39.7715,8.89355,-0.15329],81.9662,1,0,[-16.1359,-2.28806],"","",true,false],
	["Land_Razorwire_F",[40.1436,-10.8213,-0.404755],88.1168,1,0,[-24.2495,-2.51291],"","",true,false]
];
[_dict, "AS_outpost_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_2", "objects", _objects] call DICT_fnc_set;

_center = [14128.2, 9949.6];
_objects = [
	["Land_Cargo_Tower_V4_F",[-3.53711,1.38086,0.779312],7.67498,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[15.3486,11.3916,0.816147],245.081,1,0,[19.9253,6.49633],"","",true,false],
	["Land_PortableLight_double_F",[23.5654,-3.94238,0.0387421],263.465,1,0,[0,0],"","",true,false],
	["Land_HBarrier_01_big_tower_green_F",[-14.8555,20.333,-0.00187683],240.637,1,0,[1.72268,0.257629],"","",true,false],
	["Land_PortableLight_double_F",[1.91309,25.7646,0.0677567],230.417,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[3.50781,-28.1553,0.0469513],255.499,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[22.2324,21.0508,0.355812],229.82,1,0,[27.3887,1.92848],"","",true,false],
	["Land_Razorwire_F",[6.06152,-33.3857,-1.01817],282.722,1,0,[8.98084,-10.22],"","",true,false],
	["Land_Razorwire_F",[4.40527,33.9971,0.801399],223.178,1,0,[17.5487,4.5726],"","",true,false],
	["Land_Razorwire_F",[-4.54688,49.5967,-1.18322],220.128,1,0,[17.9964,-10.58],"","",true,false]
];
[_dict, "AS_outpost_6", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_6", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_6", "objects", _objects] call DICT_fnc_set;

_center = [12197.6, 8189.24];
_objects = [
	["Land_CzechHedgehog_01_F",[22.8652,45.9648,0],283.904,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[28.0479,43.8086,-0.336315],31.255,1,0,[5.17022,-3.82449],",",true,false],
	["Land_PortableLight_double_F",[12.1748,51.8584,-0.00488281],210.249,1,0,[0,0],",",true,false],
	["Land_BagFence_01_long_green_F",[13.4199,52.5693,0.0458412],25.9618,1,0,[4.24762,1.73023],",",true,false],
	["Land_CzechHedgehog_01_F",[10.5576,54.4951,0],100.958,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[4.32715,60.0879,1.37565],43.926,1,0,[6.39282,11.0364],",",true,false],
	["Land_Razorwire_F",[-61.4385,-38.2388,-1.16319],294.992,1,0,[14.1278,-8.88311],",",true,false],
	["Land_spp_Panel_F",[34.8154,-59.3882,0.66642],148.746,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_Broken_F",[25.2256,-65.1504,0.259102],148.586,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-63.958,-45.8828,0],265.223,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[-62.0811,-59.1646,-0.00733566],75.5734,1,0,[0,0],",",true,false],
	["Land_spp_Panel_F",[32.6172,-77.6128,0.714966],148.746,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[42.6162,-72.0059,0.789322],148.746,1,0,[0,-0],",",true,false],
	["Land_BagFence_01_long_green_F",[-63.4707,-59.2446,0.110367],255.98,1,0,[9.10869,3.21472],",",true,false],
	["Land_spp_Panel_F",[53.7197,-65.8848,0.526234],148.746,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-62.4736,-62.5503,0],234.322,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-58.9365,-71.2793,-0.520775],246.712,1,0,[7.86885,-4.39781],",",true,false],
	["Land_Razorwire_F",[-86.4805,41.7236,1.84285],299.668,1,0,[15.8106,14.8772],",",true,false],
	["Land_CzechHedgehog_01_F",[-83.6982,49.4072,0],256.794,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-81.6143,54.7109,1.03131],298.296,1,0,[9.76589,9.05046],",",true,false],
	["Land_spp_Panel_Broken_F",[50.0273,-84.1016,0.747646],148.586,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[40.0918,-90.1401,0.477142],148.746,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-77.5225,63.1016,-0.0293274],326.646,1,0,[0,0],",",true,false],
	["Land_spp_Panel_F",[60.6406,-78.1108,0.436356],148.746,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-71.249,72.4736,0.0286636],16.8045,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-68.0684,77.4902,-1.36956],299.602,1,0,[8.91077,-12.1095],",",true,false],
	["Land_spp_Panel_Broken_F",[56.6465,-94.4414,0.888405],148.586,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_Broken_F",[46.4912,-100.661,0.461613],148.586,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_Broken_F",[67.5,-87.9858,0.571735],148.586,1,0,[0,-0],",",true,false],
	["Land_spp_Transformer_F",[67.5664,-101.076,-0.0106812],57.7897,1,0,[0,0],",",true,false],
	["Land_spp_Mirror_ruins_F",[67.9951,-106.287,0.0479012],95.8398,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[84.2236,-137.968,-0.0326195],342.379,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[94.3037,-131.541,-1.32173],145.959,1,0,[-5.23118,-11.4322],",",true,false],
	["Land_PortableLight_double_F",[67.5732,-151.924,0.02631],304.406,1,0,[0,0],",",true,false],
	["Land_BagFence_01_long_green_F",[68.8672,-153.272,0.11665],135.008,1,0,[-3.34293,4.63812],",",true,false],
	["Land_CzechHedgehog_01_F",[65.832,-156.729,0],145.036,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[62.5742,-163.822,0.774021],115.092,1,0,[-5.11492,5.84488],",",true,false],
	["Land_CzechHedgehog_01_F",[53.8809,-176.941,0.0666962],283.904,1,0,[0,0],",",true,false]
];
[_dict, "AS_powerplant_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_5", "objects", _objects] call DICT_fnc_set;

_center = [12481.2, 7841.83];
_objects = [
	["Land_Cargo_Tower_V4_F",[-4.54883,-5.53857,0],179.251,1,0,[0,-0],",",true,false],
	["Land_IRMaskingCover_02_F",[21.4727,-20.2104,0.0138531],357.293,1,0,[4.30924,-2.50369],",",true,false],
	["Land_Razorwire_F",[0.749023,36.8511,-0.443535],316.02,1,0,[-3.59475,-4.16304],",",true,false],
	["Land_Razorwire_F",[-44.9443,21.1895,0.971838],284.086,1,0,[13.7268,9.10519],",",true,false],
	["Land_Razorwire_F",[-39.8027,-38.1938,0.916729],54.5728,1,0,[-23.0111,8.25272],",",true,false],
	["Land_Razorwire_F",[-9.85254,-57.0903,-1.06579],174.33,1,0,[4.56826,-4.91223],",",true,false],
	["Land_Razorwire_F",[9.1123,69.9414,-0.81352],0,1,0,[5.18066,-7.77611],",",true,false],
	["Land_PortableLight_double_F",[20.5293,70.168,-0.00267982],160.231,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[17.6729,71.5088,-2.28882e-005],318.442,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[27.8926,76.1602,0.0326347],14.7289,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[32.75,82.7295,-1.1752],300.721,1,0,[-3.32653,-9.35947],",",true,false],
	["Land_Razorwire_F",[33.5371,-101.646,-0.156199],0,1,0,[-0.611018,0.611053],",",true,false],
	["Land_Razorwire_F",[62.8809,-87.5737,-0.478714],319.065,1,0,[3.40289,-3.76179],",",true,false],
	["Land_CzechHedgehog_01_F",[54.873,-94.5635,0],14.7289,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[46.2891,-98.9688,0.0119419],299.021,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[45.1689,-101.087,0],318.442,1,0,[0,0],",",true,false]
];
[_dict, "AS_outpost_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_5", "objects", _objects] call DICT_fnc_set;

_center = [12646.6, 6663.15];
_objects = [
	["Land_BagFence_01_round_green_F",[-0.100586,0.368164,0.000759125],189.765,1,0,[0,0],",",true,false],
	["Land_BagFence_01_round_green_F",[-0.0175781,-1.25391,-0.0174599],338.501,1,0,[0,0],",",true,false],
	["Land_spp_Panel_F",[-34.2158,-39.6523,0.189808],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Transformer_F",[-14.7637,-53.501,0.0110302],304.314,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[48.293,-29.9785,1.64632],84.8923,1,0,[0.505352,12.4854],",",true,false],
	["Land_CzechHedgehog_01_F",[29.6377,-52.6563,0],56.5718,1,0,[0,0],",",true,false],
	["Land_spp_Panel_F",[-32.6709,-52.416,-0.433681],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-48.168,-41.7295,0.0261784],170.091,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[47.9531,-42.0903,0],245.932,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[36.7148,-52.1221,1.15278],330.361,1,0,[17.0029,9.08877],",",true,false],
	["Land_spp_Panel_F",[-46.7354,-54.2544,-0.089529],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-30.7051,-64.29,0.0325127],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-44.917,-66.4058,0.106583],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_Broken_F",[-59.9521,-56.0654,-0.126471],171.356,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-75.7256,-45.9458,-0.0378609],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-58.1006,-68.3989,0.352514],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-73.918,-57.5649,-0.459003],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-72.0469,-70.5361,0.463172],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-93.085,-48.8804,0.14674],170.091,1,0,[0,-0],",",true,false],
	["Land_spp_Panel_F",[-90.7178,-60.5229,0.120438],170.091,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-104.751,-42.54,0.0151501],91.8775,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-106.708,-39.5552,0],245.932,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-109.938,-30.3945,0.278806],70.3234,1,0,[6.03461,2.37609],",",true,false],
	["Land_Razorwire_F",[-108.569,-45.3647,1.26859],106.4,1,0,[3.1465,9.4411],",",true,false],
	["Land_Razorwire_F",[-5.45703,128.839,-1.09812],27.3235,1,0,[9.08036,-9.3192],",",true,false],
	["Land_Razorwire_F",[-29.6934,124.334,-0.0950165],332.766,1,0,[1.7655,-0.908875],",",true,false],
	["Land_PortableLight_double_F",[-20.0605,127.725,0.000743866],164.92,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-22.0234,128.588,-3.43323e-005],0,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-10.9453,130.836,0.0372887],10.0771,1,0,[0,0],",",true,false]
];
[_dict, "AS_powerplant_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_1", "objects", _objects] call DICT_fnc_set;

_center = [11751, 6918.85];
_objects = [
	["Land_Razorwire_F",[-13.2334,-9.87207,0.486723],24.0531,1,0,[1.66743,3.75504],",",true,false],
	["Land_BagFence_01_long_green_F",[-16.2217,-4.67578,0.0937901],31.0327,1,0,[1.51373,3.40683],",",true,false],
	["Land_PortableLight_double_F",[-16.5781,-2.99658,0.013628],7.3459,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-13.5986,-13.5645,0],316.114,1,0,[0,0],",",true,false],
	["Land_BagFence_01_end_green_F",[-22.0459,13.4053,-0.00109673],325.222,1,0,[0.0159519,0.0229708],",",true,false],
	["Land_BagFence_01_long_green_F",[-23.5107,12.3452,-0.00269508],143.443,1,0,[-0.0166574,-0.0224645],",",true,false],
	["Land_BagFence_01_end_green_F",[-25.374,11.0596,-0.000473022],325.222,1,0,[0.0159519,0.0229708],",",true,false],
	["Land_Razorwire_F",[-30.4893,0.51709,0.247643],33.3545,1,0,[0.943033,1.90113],",",true,false],
	["Land_CzechHedgehog_01_F",[-30.0596,-4.58984,0],245.932,1,0,[0,0],",",true,false],
	["Land_BagFence_01_end_green_F",[-28.7725,10.0161,0.000900269],52.1953,1,0,[-0.0220964,0.0171426],",",true,false],
	["Land_PalletTrolley_01_yellow_F",[-11.7236,28.8096,0.028698],274.795,1,0,[-2.46295,-3.29794],",",true,false],
	["Land_BagFence_01_long_green_F",[-29.8916,11.4888,0.000534058],233.814,1,0,[0.0225717,-0.0165118],",",true,false],
	["Land_Pallets_F",[-10.3389,31.1602,0],289.246,1,0,[0,0],",",true,false],
	["Land_Pallets_stack_F",[-14.0791,32.7729,0.0263958],149.771,1,0,[-1.10189,4.17074],",",true,false],
	["Land_Razorwire_F",[49.8193,26.8169,-0.699787],215.155,1,0,[-10.5039,-6.12051],",",true,false],
	["Land_Razorwire_F",[27.5801,54.6558,-0.661282],250.513,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[67.415,13.0801,-0.331221],228.957,1,0,[-13.8562,-2.48264],",",true,false],
	["Land_Razorwire_F",[58.6777,-50.6699,0.0461597],120.182,1,0,[-0.967484,0.144129],",",true,false],
	["Land_Razorwire_F",[10.6045,76.8535,0.567842],220.8,1,0,[0,0],",",true,false],
	["Land_Pallets_stack_F",[36.8262,-79.5522,0.0252638],82.2869,1,0,[-1.63994,2.68751],",",true,false],
	["Land_PortableLight_double_F",[36.7783,-80.5596,-0.332254],251.136,1,1,[77.5185,-92.8716],",",true,false],
	["Land_Razorwire_F",[-2.93945,92.3438,-0.030344],234.726,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-66.7334,76.0273,-0.172482],128.61,1,0,[-3.90935,-1.95283],",",true,false],
	["Land_Razorwire_F",[-20.8027,116.45,1.38314],192.516,1,0,[-30.6429,14.4047],",",true,false]
];
[_dict, "AS_resource_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_5", "objects", _objects] call DICT_fnc_set;

_center = [9476.36, 7556.88];
_objects = [
	["Land_BagFence_01_long_green_F",[0.452148,-1.80078,0.038784],179.951,1,0,[-0.3049,1.06964],",",true,false],
	["Land_BagFence_01_long_green_F",[1.84961,-0.0859375,-0.0479698],274.336,1,0,[-2.16949,-1.69633],",",true,false],
	["Land_PortableLight_double_F",[2.38086,-8.87549,0.00553513],352.569,1,0,[0,0],",",true,false],
	["Land_BagFence_01_long_green_F",[2.69238,13.3101,0.0745811],93.3189,1,0,[2.59625,2.75031],",",true,false],
	["Land_BagFence_01_long_green_F",[1.4834,15.0547,0.0686302],183.826,1,0,[-3.07737,2.55216],",",true,false],
	["Land_PortableLight_double_F",[4.7793,23.4873,-0.00431061],185.835,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-22.4756,32.1035,0.280567],157.068,1,0,[-4.35368,1.84484],",",true,false],
	["Land_Razorwire_F",[-59.8486,29.0454,0.0319977],358.529,1,0,[6.08258,-0.309618],",",true,false],
	["Land_Razorwire_F",[-74.9199,28.1826,0.00646973],358.537,1,0,[1.83608,0.105159],",",true,false],
	["Land_BagFence_01_long_green_F",[-24.9678,-76.2075,0.0979538],35.2975,1,0,[2.01883,3.4891],",",true,false],
	["Land_Razorwire_F",[-23.1191,-78.6279,0.014904],359.652,1,0,[3.66183,-0.0222525],",",true,false],
	["Land_BagFence_01_long_green_F",[-37.0703,-75.7417,0.0527954],141.877,1,0,[-3.96976,1.3678],",",true,false],
	["Land_Razorwire_F",[-41.2725,-78.9751,0.205429],359.653,1,0,[2.45325,1.66697],",",true,false],
	["Land_PortableLight_double_F",[-34.5889,-81.2432,0.0177193],352.155,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-85.2041,33.2607,-0.119377],32.5223,1,0,[1.21896,-0.491146],",",true,false],
	["Land_Razorwire_F",[-91.9502,-11.834,-0.00287247],80.8633,1,0,[0.150023,-0.0241284],",",true,false],
	["Land_CzechHedgehog_01_F",[-88.8877,35.8867,4.95911e-005],251.438,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-93.8701,42.4126,0.556004],52.5683,1,0,[1.72426,5.01641],",",true,false]
];
[_dict, "AS_resource_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_2", "objects", _objects] call DICT_fnc_set;

_center = [8831.39, 6615.41];
_objects = [
	["Land_Pallets_stack_F",[-1.75391,-0.0854492,0.0256758],89.3363,1,0,[0.001238,0.18002],",",true,false],
	["Land_Pallets_stack_F",[-1.70215,-1.83203,0.0240035],79.6055,1,0,[-0.0277241,-0.150519],",",true,false],
	["Land_PalletTrolley_01_yellow_F",[-1.6123,2.00488,0.0240254],72.0271,1,0,[0.0950397,0.289425],",",true,false],
	["Land_Pallet_vertical_F",[-2.71875,-0.0556641,0.0256371],263.449,1,0,[-0.026421,-0.182367],",",true,false],
	["Land_Pallets_stack_F",[-3.52637,-0.57373,0.0546083],82.4626,1,0,[-0.446506,1.8261],",",true,false],
	["Land_Pallets_stack_F",[-3.35449,-2.10059,0.0240073],261.721,1,0,[0.0219713,0.151248],",",true,false],
	["Land_Pallets_stack_F",[-3.34863,-1.71289,-0.00462055],91.9486,1,0,[-0.71647,0.112177],",",true,false],
	["Land_Pallets_stack_F",[-2.60938,-4.02979,0.0240178],207.3,1,0,[0.135033,0.0696532],",",true,false],
	["Land_GarbagePallet_F",[-10.5713,12.8628,-0.0116587],180.739,1,0,[-1.53133,0.285563],",",true,false],
	["Land_Razorwire_F",[-25.4141,15.0229,0.480494],62.8578,1,0,[-0.442677,3.8268],",",true,false],
	["Land_Razorwire_F",[-16.8135,-25.8809,0.00321102],216.622,1,0,[-4.03234,-0.712776],",",true,false],
	["Land_BagFence_01_long_green_F",[-39.9844,35.8262,0.0221648],247.991,1,0,[-1.64243,0.827902],",",true,false],
	["Land_Razorwire_F",[-43.0352,45.2446,0.0377889],73.3928,1,0,[2.20829,0.457072],",",true,false],
	["Land_PortableLight_double_F",[-60.4824,29.9888,-0.00120258],69.8394,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-47.7383,51.667,0],0,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[69.0713,52.0981,-0.138352],73.3458,1,0,[1.28853,-1.02321],",",true,false],
	["Land_Razorwire_F",[89.6006,1.1958,0.358805],128.213,1,0,[-2.92731,3.71627],",",true,false],
	["Land_BagFence_01_long_green_F",[67.0625,59.1929,-0.0120478],247.999,1,0,[0.735588,-0.626368],",",true,false],
	["Land_CzechHedgehog_01_F",[93.5654,7.64795,0],0,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[56.4814,76.4229,-0.113292],73.3894,1,0,[-1.52074,-0.821811],",",true,false],
	["Land_CzechHedgehog_01_F",[51.8867,85.373,0],0,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[101.532,19.4058,-0.095201],119.724,1,0,[0.322547,-0.871383],",",true,false],
	["Land_Razorwire_F",[-72.8887,74.6636,1.6357],114.773,1,0,[-11.417,13.7421],",",true,false],
	["Land_Razorwire_F",[-41.8184,96.4668,0.664572],140.342,1,0,[-10.7812,4.78299],",",true,false],
	["Land_Razorwire_F",[-1.16992,105.081,0.0734129],175.043,1,0,[-25.8119,0.530488],",",true,false],
	["Land_Razorwire_F",[44.4072,94.7324,-1.48928],247.716,1,0,[-0.230442,-13.5191],",",true,false],
	["Land_CzechHedgehog_01_F",[40.125,104.988,0],251.697,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[81.5869,78.8955,0.0018425],259.597,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[35.4482,113.801,1.31483],48.4523,1,0,[-1.94099,9.98864],",",true,false]
];
[_dict, "AS_resource_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_4", "objects", _objects] call DICT_fnc_set;

_center = [7976.69, 7487.76];
_objects = [
	["Land_MetalBarrel_F",[5.03857,3.83887,0.024436],0.0332902,1,0.00606371,[-1.82972,-0.155476],",",true,false],
	["Land_MetalBarrel_F",[6.3877,1.63037,0.0244265],0.0333716,1,0.00606385,[-1.82971,-0.155438],",",true,false],
	["Land_MetalBarrel_F",[7.08398,2.12842,0.0244741],359.989,1,0.00531249,[-1.83513,0.217166],",",true,false],
	["Land_MetalBarrel_F",[5.85742,4.59033,0.0247326],0.0433252,1,0.00657712,[-1.76284,-0.168945],",",true,false],
	["Land_MetalBarrel_F",[7.09619,2.85938,0.0244722],359.982,1,0.00504477,[-1.83566,0.274936],",",true,false],
	["Land_MetalBarrel_F",[7.1543,3.6792,0.0244851],359.998,1,0.00399572,[-1.83504,0.28518],",",true,false],
	["Land_MetalBarrel_F",[7.8916,2.15625,0.0244784],359.967,1,0.00601728,[-1.83713,0.297592],",",true,false],
	["Land_MetalBarrel_F",[7.1084,4.50586,0.0453253],297.339,1,0.0301839,[1.2938,-2.76017],",",true,false],
	["Land_MetalBarrel_F",[7.94238,2.84229,0.0244861],359.967,1,0.00601606,[-1.83713,0.297576],",",true,false],
	["Land_MetalBarrel_F",[7.96094,3.66748,0.0244908],359.967,1,0.00613091,[-1.83715,0.297556],",",true,false],
	["Land_MetalBarrel_F",[7.10449,5.36426,0.0243421],23.7838,1,0.00473267,[-1.50449,-0.3684],",",true,false],
	["Land_MetalBarrel_F",[7.95361,4.53711,0.0246105],170.556,1,0.00655826,[1.72451,-0.603377],",",true,false],
	["Land_MetalBarrel_F",[7.98193,5.31299,0.0243106],38.8228,1,0.00598594,[-1.37831,-0.723494],",",true,false],
	["CargoNet_01_barrels_F",[7.45215,6.94287,0.0246186],359.988,1,0,[-1.52695,0.271021],",",true,false],
	["CargoNet_01_barrels_F",[10.1924,2.12451,0.0245461],0.0107136,1,0,[-1.83178,0.304988],",",true,false],
	["CargoNet_01_barrels_F",[10.3979,4.34277,0.0257015],359.998,1,0,[-1.74101,0.304569],",",true,false],
	["CargoNet_01_barrels_F",[10.0972,6.72168,0.0245333],359.999,1,0,[-1.38998,0.155551],",",true,false],
	["Land_BagFence_01_long_green_F",[-6.78125,10.5488,0.0193887],279.743,1,0,[-0.430083,0.701211],",",true,false],
	["CargoNet_01_barrels_F",[10.0479,9.15771,0.0262485],41.8372,1,0,[-0.872799,-0.618751],",",true,false],
	["Land_PortableLight_double_F",[19.2808,-17.0435,0.00477982],288.475,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-6.60254,28.6279,0],305.254,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[33.7925,1.08203,0.001333],241.28,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[33.1265,8.03564,-0.0360537],261.191,1,0,[1.18418,-0.338603],",",true,false],
	["Land_Razorwire_F",[36.333,-9.25342,0.00708628],255.536,1,0,[2.88471,-0.429554],",",true,false],
	["Land_Razorwire_F",[29.9219,28.9717,0.0755105],243.288,1,0,[-1.16052,0.412511],",",true,false],
	["Land_Razorwire_F",[32.812,-31.104,0.356558],311.747,1,0,[5.98908,2.90457],",",true,false],
	["Land_PortableLight_double_F",[-12.2871,48.2412,0.00508928],157.425,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-24.6147,-47.312,-0.00214577],337.741,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-30.2261,-48.1602,0.178941],182.747,1,0,[0.84237,1.56986],",",true,false],
	["Land_DPP_01_mainFactory_F",[56.4272,35.1929,0.11009],246.655,1,0,[0,0],",",true,false]
];
[_dict, "AS_powerplant_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_2", "objects", _objects] call DICT_fnc_set;

_center = [7381.53, 8459.55];
_objects = [
	["Land_BagFence_01_long_green_F",[0.0078125,12.335,-0.000999928],40.8944,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[15.3477,-23.1846,-2.86102e-006],127.012,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-11.7407,-26.0742,0],272.077,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[9.04102,-31.0156,0],306.519,1,0,[0,0],",",true,false],
	["Land_BagFence_01_short_green_F",[-12.0098,-32.2158,-0.00125694],124.567,1,0,[-0.0230294,-0.0158672],",",true,false],
	["Land_BagFence_01_long_green_F",[-13.6597,-33.8604,-0.00159264],142.736,1,0,[-0.0169334,-0.0222572],",",true,false],
	["Land_CzechHedgehog_01_F",[-4.62256,-42.25,0],305.254,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-10.0283,-45.3516,-2.86102e-006],158.348,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[28.3198,42.6035,0],20.3585,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[19.1279,-51.291,0.0250659],330.233,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[7.35986,-58.4277,0.0163484],321.197,1,0,[0,0],",",true,false],
	["Land_BagFence_01_long_green_F",[67.0186,21.9072,-0.00390339],129.734,1,0,[-0.0197191,-0.213982],",",true,false],
	["Land_BagFence_01_corner_green_F",[70.9175,12.8516,0.842566],220.04,1,0,[0,0],",",true,false],
	["Land_BagFence_01_long_green_F",[68.9321,24.2002,-0.00606441],129.734,1,0,[-0.0197191,-0.213982],",",true,false],
	["Land_BagFence_01_long_green_F",[72.3599,15.0596,0.845581],311.91,1,0,[0,0],",",true,false],
	["Land_Shoot_House_Wall_F",[73.2324,13.0146,0],133.423,1,0,[0,-0],",",true,false],
	["Land_Pallet_vertical_F",[73.3389,14.8154,-0.177442],312.65,1,0,[50.0831,2.88246],",",true,false],
	["Land_BagFence_01_long_green_F",[70.8921,26.4775,-0.00138044],131.748,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[72.8926,27.8008,0.000146866],114.974,1,0,[0,-0],",",true,false],
	["Land_BagFence_01_long_green_F",[79.3857,22.957,0.846882],308.894,1,0,[0,0],",",true,false],
	["Land_Pallet_vertical_F",[80.2456,22.8027,-0.0783815],310.314,1,0,[34.6845,0.000502526],",",true,false],
	["Land_PortableLight_double_F",[77.1504,32.8535,-0.000295639],144.743,1,0,[0,-0],",",true,false],
	["Land_Shoot_House_Wall_F",[81.3193,22.0322,0],133.423,1,0,[0,-0],",",true,false],
	["Land_BagFence_01_long_green_F",[78.0566,35.0557,-0.000999928],310.932,1,0,[0,0],",",true,false],
	["Land_Shoot_House_Wall_F",[83.5586,24.5273,0],133.423,1,0,[0,-0],",",true,false],
	["Land_BagFence_01_long_green_F",[79.9829,37.3584,-0.000999928],308.919,1,0,[0,0],",",true,false],
	["Land_BagFence_01_long_green_F",[84.3628,28.6172,0.84586],311.039,1,0,[0,0],",",true,false],
	["Land_Shoot_House_Wall_F",[85.5454,26.8115,0],133.423,1,0,[0,-0],",",true,false],
	["Land_Pallet_vertical_F",[85.2866,28.3682,-0.136724],312.424,1,0,[43.2709,-0.000117257],",",true,false],
	["Land_BagFence_01_long_green_F",[81.9712,39.6768,-0.000999928],312.386,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-45.2505,83.7188,0.0338211],133.875,1,0,[-0.211524,0.219999],",",true,false],
	["Land_BagFence_01_long_green_F",[88.6177,33.2861,0.846026],311.039,1,0,[0,0],",",true,false],
	["Land_Shoot_House_Wall_F",[89.4302,31.5156,-0.537398],132.373,1,0,[-0.327872,-0.0934322],",",true,false],
	["Land_Pallet_vertical_F",[89.543,33.0352,-0.138953],312.509,1,0,[43.561,-0.00266745],",",true,false],
	["Land_PortableLight_double_F",[41.4717,97.3066,0],306.974,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[112.413,29.6387,-0.328073],134.012,1,0,[-6.52932,-4.20345],",",true,false],
	["Land_Razorwire_F",[44.7021,180.997,-2.86102e-006],311.425,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[153.029,137.638,-2.86102e-006],234.479,1,0,[0,0],",",true,false]
];
[_dict, "AS_powerplant_6", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_6", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_6", "objects", _objects] call DICT_fnc_set;

_center = [7641.21, 8831.65];
_objects = [
	["Land_BagFence_01_long_green_F",[5.21484,-0.591797,-0.0164776],172.031,1,0,[4.55113,-0.483197],",",true,false],
	["Land_BagFence_01_long_green_F",[7.61963,-1.58203,0.115155],244.995,1,0,[1.79763,4.21141],",",true,false],
	["Land_BagFence_01_long_green_F",[8.95459,-4.34375,0.144217],244.951,1,0,[1.41964,5.55899],",",true,false],
	["Land_BagFence_01_long_green_F",[10.2402,-7.03418,0.149759],244.903,1,0,[0.81397,5.33956],",",true,false],
	["Land_IRMaskingCover_02_F",[-11.5791,7.57422,0.0149288],334.069,1,0,[0.88441,6.68001],",",true,false],
	["Land_BagFence_01_long_green_F",[11.5063,-9.71094,0.154558],244.906,1,0,[0.878239,5.47691],",",true,false],
	["Land_Razorwire_F",[-0.447266,18.8711,0.180514],63.9327,1,0,[-0.286563,1.50048],",",true,false],
	["Land_BagFence_01_long_green_F",[12.7637,-12.4375,0.119901],244.932,1,0,[0.850667,3.98124],",",true,false],
	["Land_BagFence_01_long_green_F",[8.05029,-16.583,0.0208216],155.347,1,0,[2.78236,0.572674],",",true,false],
	["Land_BagFence_01_short_green_F",[10.2026,-15.585,0.00214005],333.247,1,0,[-1.98158,-0.198874],",",true,false],
	["Land_BagFence_01_long_green_F",[12.3472,-14.6514,0.0082407],334.569,1,0,[-4.23752,0.322748],",",true,false],
	["Land_Razorwire_F",[17.3442,-4.27832,-0.715038],37.5266,1,0,[-3.27929,-5.988],",",true,false],
	["Land_BagFence_01_long_green_F",[-5.74414,-18.6982,0.0919142],241.58,1,0,[0.854071,3.18275],",",true,false],
	["Land_BagFence_01_long_green_F",[-2.37207,-19.625,-0.00276661],338.143,1,0,[-2.41023,0.143632],",",true,false],
	["Land_BagFence_01_corner_green_F",[-4.43066,-20.2139,0.00918674],152.898,1,0,[2.38705,-0.363492],",",true,false],
	["Land_CzechHedgehog_01_F",[24.6689,-10.5059,0],305.254,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[-12.2603,25.9697,-0.00143051],189.034,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-18.0942,26.498,0.00599861],104.808,1,0,[0,-0],",",true,false],
	["Land_Cargo_Tower_V4_F",[-32.0078,10.5508,0],271.747,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[34.271,-24.1729,-0.00132942],77.3184,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-35.4824,26.7002,0.246969],351.289,1,0,[4.97115,1.25251],",",true,false],
	["Land_PortableLight_double_F",[43.8066,-6.16406,0.0011282],271.966,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[34.4976,-30.6514,-1.97582],101.288,1,0,[3.8433,-16.3764],",",true,false],
	["Land_PortableLight_double_F",[-44.8022,25.9297,0.00330734],117.242,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-63.9995,15.7646,-0.317482],185.148,1,0,[0.61928,-3.46836],",",true,false],
	["Land_Razorwire_F",[-86.8857,-33.6104,0.135937],101.491,1,0,[-0.992146,1.0454],",",true,false],
	["Land_CzechHedgehog_01_F",[-95.5371,-53.1533,0],305.254,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-94.3418,-68.6982,0],305.254,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-88.6396,-81.2383,0.0567169],246.59,1,0,[-2.2194,1.79324],",",true,false],
	["Land_Razorwire_F",[-61.2368,-105.951,-1.44792],24.89,1,0,[-6.88576,-12.1295],",",true,false],
	["Land_CzechHedgehog_01_F",[-82.8306,-90.9053,0],305.254,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-69.6655,-103.676,0],305.254,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[-112.808,-62.7568,0.0130215],104.944,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-92.4976,-107.052,0.00232506],19.4448,1,0,[0,0],",",true,false]
];
[_dict, "AS_outpost_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_4", "objects", _objects] call DICT_fnc_set;

_center = [6743.4, 7260.87];
_objects = [
	["Land_IRMaskingCover_02_F",[-7.37549,10.061,-0.00253677],42.8826,1,0,[-1.17539,0.367885],",",true,false],
	["Land_IRMaskingCover_01_F",[-1.28564,-18.9985,0.00320101],312.526,1,0,[1.58523,-3.31036],",",true,false],
	["Land_IRMaskingCover_01_F",[20.749,5.1875,0.00545788],312.544,1,0,[0.356458,0.741329],",",true,false],
	["Land_IRMaskingCover_01_F",[17.7104,-37.8647,0.00510883],312.518,1,0,[1.52978,-2.11989],",",true,false],
	["Land_CzechHedgehog_01_F",[38.0269,-23.397,9.53674e-007],92.274,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[38.812,-25.2949,-0.000673294],83.9815,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[43.0923,-17.3438,3.62396e-005],0,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[44.8726,-18.4971,0.000184536],160.232,1,0,[0,-0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[39.8652,-30.8516,0.00118256],310.24,1,0,[-0.170325,-0.744625],",",true,false],
	["Land_Razorwire_F",[40.855,-29.6689,0.311344],133.335,1,0,[0,-0],",",true,false],
	["Land_BagBunker_01_large_green_F",[-51.0132,-14.439,-0.0283046],41.7974,1,0,[2.97717,1.02237],",",true,false],
	["Land_Razorwire_F",[51.8535,-16.0137,-0.144498],130.796,1,0,[0,-0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[50.7051,-17.106,0.000777245],310.226,1,0,[1.02276,-0.73559],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[41.8247,-36.9253,0.00141716],39.2487,1,0,[0.225332,-0.999608],",",true,false],
	["Land_BagBunker_01_large_green_F",[-36.0747,43.748,-0.0429125],130.699,1,0,[4.63806,-1.64442],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[56.9082,-18.2036,0.00693703],220.475,1,0,[2.42717,-3.54713],",",true,false],
	["Land_Cargo_Tower_V4_F",[52.4336,-29.9463,0],40.2278,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[48.6763,-42.4712,-0.0004673],37.9552,1,0,[-0.469669,0.60211],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[63.4712,-24.0332,0.00342703],220.708,1,0,[2.55423,-2.03292],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[55.0806,-43.5332,-0.00265884],310.311,1,0,[1.44092,3.02323],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[60.647,-36.7832,-0.000345707],310.213,1,0,[2.73515,0.313432],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[66.105,-30.2583,-0.00249958],310.383,1,0,[2.28641,4.14491],",",true,false],
	["Land_Razorwire_F",[-32.271,-71.6152,0.0654685],43.852,1,0,[0.66088,0.634915],",",true,false],
	["Land_CzechHedgehog_01_F",[-26.1641,-77.5903,0.00864744],216.993,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-21.8882,-81.6812,-0.0297525],43.7077,1,0,[0.532042,-0.336711],",",true,false],
	["Land_CzechHedgehog_01_F",[-14.6777,-87.853,-8.7738e-005],193.922,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-9.94824,-90.583,-0.182677],35.7306,1,0,[5.0202,-0.717061],",",true,false],
	["Land_HBarrier_01_big_tower_green_F",[-100.001,15.9604,0.0424013],130.977,1,0,[-6.90236,-6.20311],",",true,false],
	["Land_PortableLight_double_F",[-105.207,14.9312,-0.00661707],127.283,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-106.006,49.7075,-0.0192146],117.451,1,0,[-4.22314,-0.476069],",",true,false],
	["Land_PortableLight_double_F",[-106.903,60.2222,0.000182152],211.512,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-118.743,45.8574,-0.505702],228.721,1,0,[0.312811,-4.73659],",",true,false],
	["Land_Razorwire_F",[-132.922,-2.62695,0.102688],41.5366,1,0,[10.4858,0.932438],",",true,false],
	["Land_CzechHedgehog_01_F",[-124.128,51.0947,-1.71661e-005],63.8554,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-129.884,40.9692,-0.00469208],305.254,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-138.217,1.9043,0.0413575],200.284,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-131.712,48.5674,0.192971],335.091,1,0,[1.17755,1.81087],",",true,false],
	["Land_Razorwire_F",[-144.131,12.1636,0.414379],56.6959,1,0,[5.103,3.03413],",",true,false],
	["Land_CzechHedgehog_01_F",[-146.383,41.5059,0],305.254,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-152.385,46.6841,0.33575],357.248,1,0,[-3.07701,2.7504],",",true,false],
	["Land_PortableLight_double_F",[-167.3,51.252,0.00227547],107.401,1,0,[0,-0],",",true,false]
];
[_dict, "AS_base_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_1", "objects", _objects] call DICT_fnc_set;

_center = [7018.61, 7382.13];
_objects = [
	["Land_BagFence_01_round_green_F",[-28.3081,15.0854,0.0108087],345.638,1,0,[0,0],",",true,false],
	["Land_IRMaskingCover_01_F",[29.7861,14.4619,0],348.025,1,0,[0,0],",",true,false],
	["Land_BagFence_01_round_green_F",[-30.2041,16.2446,-0.00130129],72.7808,1,0,[0,0],",",true,false],
	["Land_BagFence_01_round_green_F",[-29.0718,18.1948,0.013212],165.907,1,0,[0,-0],",",true,false],
	["Land_IRMaskingCover_01_F",[37.8989,-19.4717,0],348.025,1,0,[0,0],",",true,false],
	["Land_BagBunker_01_large_green_F",[-3.42822,-46.1611,0],46.3481,1,0,[0,0],",",true,false],
	["Land_IRMaskingCover_01_F",[22.1753,48.6548,0],348.025,1,0,[0,0],",",true,false],
	["Land_IRMaskingCover_01_F",[64.1538,0.0151367,0],258.176,1,0,[0,0],",",true,false],
	["Land_BagBunker_01_large_green_F",[-26.145,61.71,0],122.885,1,0,[0,-0],",",true,false],
	["Land_IRMaskingCover_01_F",[57.353,40.6167,0],258.176,1,0,[0,0],",",true,false],
	["Land_BagBunker_01_large_green_F",[81.356,24.3491,0],259.246,1,0,[0,0],",",true,false],
	["Land_BagFence_01_round_green_F",[-29.7437,107.472,0.0116403],315.913,1,0,[0.105718,0.109142],",",true,false],
	["Land_BagFence_01_round_green_F",[-31.9956,107.601,0.000492334],49.0391,1,0,[-0.114745,0.0996088],",",true,false],
	["Land_BagFence_01_round_green_F",[-31.8081,109.815,0.0048089],136.182,1,0,[-0.105204,-0.109638],",",true,false],
	["Land_BagFence_01_round_green_F",[-41.4067,-111.825,-0.00130129],235.62,1,0,[0,0],",",true,false],
	["Land_BagFence_01_round_green_F",[-43.5605,-111.277,-0.00130129],148.476,1,0,[0,-0],",",true,false],
	["Land_BagFence_01_round_green_F",[-44.0571,-113.478,-0.00130129],55.3499,1,0,[0,0],",",true,false],
	["Land_SatelliteAntenna_01_F",[-122.735,40.9536,-0.0370369],254.865,1,0,[-3.68998,-0.10284],",",true,false],
	["Land_PortableLight_double_F",[18.7856,133.196,-0.00353479],71.3163,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[16.9219,134.427,0],161.937,1,0,[0,-0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[24.7344,135.431,0.00217319],167.389,1,0,[3.87076,-0.867261],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[46.1133,-130.713,0],351.304,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[54.7168,-129.688,0],351.304,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[32.9922,136.867,0],172.986,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[38.7305,-137.193,0],2.38611,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[43.5513,-136.623,0],81.7199,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[60.5933,-132.307,0],81.7199,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[37.7764,140.701,0],79.3338,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[39.9556,-140.572,0],127.949,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[15.3213,148.173,0],125.562,1,0,[0,-0],",",true,false],
	["Land_Cargo_Tower_V4_F",[52.2861,-138.814,0],261.269,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[12.2539,149.433,0],0,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[36.147,149.248,0],79.3338,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[61.8628,-140.897,0],81.7199,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[17.6733,152.756,0],79.3338,1,0,[0,0],",",true,false],
	["Land_Cargo_Tower_V4_F",[26.4917,150.93,0],258.883,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[32.7402,-151.14,0],2.38611,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[19.9868,158.767,0],348.918,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[34.521,157.777,0],79.3338,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[41.3569,-156.423,0],164.323,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[43.7383,-155.628,0],350.032,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[49.8887,-154.143,0],169.804,1,0,[0,-0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[63.1353,-149.504,0],81.7199,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[28.54,160.15,0],348.918,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_big_4_green_F",[58.1958,-153.136,0],175.372,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-186.033,84.6855,-4.76837e-007],143.573,1,0,[0,-0],",",true,false],
	["Land_BagFence_01_round_green_F",[38.418,276.198,-0.00130129],96.3895,1,0,[0,-0],",",true,false],
	["Land_BagFence_01_round_green_F",[41.5015,275.705,-0.00130129],276.659,1,0,[0,0],",",true,false],
	["Land_BagFence_01_round_green_F",[40.2373,277.532,-0.00130129],189.516,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-249.673,142.917,0.0102992],108.428,1,0,[-0.627719,-0.0489971],",",true,false],
	["Land_PortableLight_double_F",[-256.618,130.352,-0.0022912],30.5578,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-247.636,149.247,3.8147e-006],305.254,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-242.661,162.279,1.52588e-005],305.254,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-239.338,170.392,-0.145036],116.464,1,0,[-3.20965,-0.746094],",",true,false],
	["Land_PortableLight_double_F",[-236.034,179.299,0.00161886],208.123,1,0,[0,0],",",true,false]
];
[_dict, "AS_airfield_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield_2", "objects", _objects] call DICT_fnc_set;

_center = [11291.5, 5367.28];
_objects = [
	["Land_CzechHedgehog_01_F",[-4.73633,-0.852539,0],77.5186,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-4.6084,5.59326,0],237.515,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[3.04688,6.63916,0],248.764,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-10.6973,-5.00488,0],139.57,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-1.42773,11.8672,0],312.233,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[-12.9639,6.92285,0],351.153,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-15.9561,-10.5508,0.64371],185.687,1,0,[0,0],",",true,false],
	["Land_BagBunker_01_large_green_F",[-10.6338,16.438,-0.3],348.076,1,0,[0,0],",",true,false],
	["Land_Cargo_Tower_V4_F",[-60.96,18.2349,0],168.037,1,0,[0,-0],",",true,false],
	["Land_BagFence_01_short_green_F",[85.8262,-68.4883,0.0452108],350.425,1,0,[1.4225,-0.0639178],",",true,false],
	["Land_PortableLight_double_F",[86.1953,-69.5,-0.0058012],172.212,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[86.3105,-75.3945,0],305.254,1,0,[0,0],",",true,false],
	["Land_BagFence_01_short_green_F",[97.6689,-65.7856,0.0189533],174.284,1,0,[-1.42358,-0.0319868],",",true,false],
	["Land_PortableLight_double_F",[98.002,-66.646,-0.0028038],163.803,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[86.2324,-82.728,0.807709],92.3479,1,0,[1.42666,6.45358],",",true,false],
	["Land_CzechHedgehog_01_F",[99.249,-76.9712,0],305.254,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[100.695,-81.8716,0.627748],75.9466,1,0,[-3.08021,4.69878],",",true,false],
	["Land_Razorwire_F",[29.8896,-192.185,1.91963],298.403,1,0,[-13.2735,15.4101],",",true,false],
	["Land_CzechHedgehog_01_F",[-70.4326,-185.568,0],305.254,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[25.0771,-196.975,0],123.249,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[32.4619,-196.546,-0.00624228],255.872,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[-84.4727,-187.975,0.00159264],66.8452,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[21.7793,-209.794,0],123.249,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[31.5166,-208.72,0.00528765],255.499,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-68.8838,-199.7,0],305.254,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-60.8164,-203.333,-0.337145],23.2437,1,0,[-4.18237,-2.63211],",",true,false],
	["Land_PortableLight_double_F",[-80.8926,-199.702,0.00256491],85.4606,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[15.0166,-219.251,0.148095],312.162,1,0,[-10.8242,0.386153],",",true,false],
	["Land_Razorwire_F",[-35.4092,-218.014,-0.191896],198.846,1,0,[10.7776,-1.68145],",",true,false],
	["Land_CzechHedgehog_01_F",[-29.5654,-219.37,0],200.35,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[10.1299,-223.208,0],122.542,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-22.9297,-223.813,-1.01956],35.0106,1,0,[-5.53814,-7.99536],",",true,false],
	["Land_CzechHedgehog_01_F",[2.65625,-226.667,0],159.801,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-6.96484,-229.752,1.43847],347.833,1,0,[-15.0208,14.631],",",true,false],
	["Land_CzechHedgehog_01_F",[-13.0596,-229.109,0],173.281,1,0,[0,-0],",",true,false]
];
[_dict, "AS_base_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_4", "objects", _objects] call DICT_fnc_set;

_center = [11009, 4198.38];
_objects = [
	["Land_Cargo_Tower_V4_F",[-13.1094,-3.9585,0.458557],158.202,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[20.8711,-12.416,-0.04422],131.76,1,0,[-29.1748,-7.01876],",",true,false],
	["Land_Razorwire_F",[3.42383,-25.8379,0.454544],139.066,1,0,[-23.0183,5.49581],",",true,false],
	["Land_PortableLight_double_F",[-30.9121,-2.50244,0.0351715],102.584,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-33.709,7.7793,-0.598846],57.1201,1,0,[26.3999,-7.78523],",",true,false],
	["Land_Razorwire_F",[-38.4951,-9.34424,-0.408356],304.085,1,0,[-11.9282,-4.49108],",",true,false],
	["Land_Razorwire_F",[-20.2178,33.9893,0.261887],322.2,1,0,[-20.9578,2.36924],",",true,false],
	["Land_Razorwire_F",[39.3955,24.7974,1.03749],55.966,1,0,[-18.4639,8.79452],",",true,false],
	["Land_Razorwire_F",[16.9355,44.5029,-0.381516],7.60187,1,0,[-15.0106,-2.68736],",",true,false],
	["Land_Razorwire_F",[2.4668,50.0508,0.876114],339.594,1,0,[-33.7974,9.43845],",",true,false],
	["Land_PortableLight_double_F",[39.7676,32.9648,0.100983],255.346,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[49.8408,17.9619,0.0523071],201.333,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-41.6299,-37.8286,0.799316],88.9357,1,0,[3.37848,7.68425],",",true,false],
	["Land_Razorwire_F",[-31.1963,-51.0894,0.234344],0.144465,1,0,[21.9361,-1.42381],",",true,false],
	["Land_Razorwire_F",[58.2725,18.397,-1.51796],174.173,1,0,[-5.90491,-11.268],",",true,false],
	["Land_CzechHedgehog_01_F",[-46.7793,-39.6235,0],172.865,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-34.5303,-56.1313,0],172.865,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-45.0068,-47.9639,0.0646515],40.8443,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[-39.5332,-54.6738,0.0727539],53.3305,1,0,[0,0],",",true,false]
];
[_dict, "AS_outpostAA_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_2", "objects", _objects] call DICT_fnc_set;

_center = [12445, 3939.46];
_objects = [
	["Land_CzechHedgehog_01_F",[4.6582,2.68066,-0.00466156],172.865,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-6.13379,-2.41113,0.0100288],306.87,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-1.13379,-7.50903,-0.0691376],172.865,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-4.36035,-10.1555,-0.904972],139.395,1,0,[1.83928,-7.20584],",",true,false],
	["Land_PalletTrolley_01_yellow_F",[-1.49609,55.385,0.0268898],220.764,1,0,[4.08485,-0.301719],",",true,false],
	["Land_Pallets_stack_F",[-0.280273,57.2031,0.0255394],14.3088,1,0,[-0.852207,0.448242],",",true,false],
	["Land_Pallets_stack_F",[-3.69629,57.5215,0.0277519],230.483,1,0,[5.24984,-0.580399],",",true,false],
	["Land_Pallets_stack_F",[-0.238281,59.1462,0.0297012],0.00564344,1,0,[-0.611053,0.183319],",",true,false],
	["Land_Pallets_stack_F",[-2.3916,59.304,0.0257416],359.976,1,0,[-0.720419,0.633948],",",true,false],
	["Land_Pallets_stack_F",[-0.0517578,59.9009,1.53847],25.2583,1,0,[-54.6093,115.453],",",true,false],
	["Land_Pallets_stack_F",[-4.08594,59.8013,0.218323],77.5403,1,0,[12.6294,-4.2101],",",true,false],
	["Land_Pallets_stack_F",[-0.310547,60.8743,0.0251274],359.996,1,0,[-0.094657,0.00210401],",",true,false],
	["Land_Pallets_stack_F",[-2.14453,60.8499,0.0267372],2.95747,1,0,[-0.619129,0.114416],",",true,false],
	["Land_Pallets_stack_F",[-3.8916,61.3711,0.0405884],174.653,1,0,[1.69628,-0.000453259],",",true,false],
	["Land_Pallets_stack_F",[-1.46191,63.5281,0.457382],124.23,1,0,[-5.08261,-97.3475],",",true,false],
	["Land_Razorwire_F",[-51.8711,-61.3738,-0.847824],0.152976,1,0,[-32.5824,-18.8024],",",true,false],
	["Land_Razorwire_F",[-69.9814,37.8899,-0.313656],140.996,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-65.0547,47.6855,0.573528],110.29,1,0,[-11.5886,4.6056],",",true,false],
	["Land_CzechHedgehog_01_F",[-68.207,-48.8848,0],172.865,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-58.3965,-60.4451,0],172.865,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-62.4863,-58.0337,0.00611115],65.5048,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-82.9795,-41.8076,-0.00523376],46.377,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[83.1133,43.3047,0],172.865,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[88.5752,32.7954,-0.0653191],72.3695,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[17.1641,94.9995,2.17794],77.661,1,0,[4.86928,16.5947],",",true,false],
	["Land_Razorwire_F",[-93.9775,20.1748,0.731449],140.176,1,0,[-10.7492,7.19639],",",true,false],
	["Land_Razorwire_F",[94.8721,25.6497,-0.622612],223.647,1,0,[-0.337556,-5.38574],",",true,false],
	["Land_PortableLight_double_F",[92.4287,36.5947,0.0365143],230.05,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[99.377,21.7505,-0.0926476],62.4046,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[103.874,14.2668,-0.266075],242.672,1,0,[12.8947,-2.30531],",",true,false],
	["Land_Razorwire_F",[-118.882,-0.607422,0.283672],100.617,1,0,[-9.90555,1.85462],",",true,false]
];
[_dict, "AS_resource_7", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_7", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_7", "objects", _objects] call DICT_fnc_set;

_center = [12217.6, 2978.05];
_objects = [
	["Land_Cargo_Tower_V4_F",[22.459,9.3479,0],171.56,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[39.7324,2.65112,0],231.144,1,0,[0,0],",",true,false],
	["Land_BagBunker_01_large_green_F",[16.9961,39.259,0.00864983],172.426,1,0,[-0.717699,2.71413],",",true,false],
	["Land_CzechHedgehog_01_F",[39.252,16,0],214.198,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[44.3496,10.802,0.00266504],0,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-54.7617,34.9387,-0.114731],119.851,1,0,[-2.80309,-0.0244625],",",true,false],
	["Land_CzechHedgehog_01_F",[-53.0449,42.5369,-0.0260029],60.8216,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-62.3594,27.7251,0],350.243,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-67.3252,-11.4031,0.160928],242.046,1,0,[3.17746,1.42516],",",true,false],
	["Land_PortableLight_double_F",[-65.7432,27.2185,0.0110879],186.42,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-71.4717,-2.67383,0],350.243,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-49.3799,50.9897,0.224655],288.058,1,0,[3.58294,1.81181],",",true,false],
	["Land_CzechHedgehog_01_F",[-42.8047,-59.438,-0.000839233],190.002,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-35.666,-63.8364,0.132114],34.7686,1,0,[-0.0594021,0.888644],",",true,false],
	["Land_HBarrier_01_big_tower_green_F",[-18.3096,-71.363,0.00714874],30.2049,1,0,[-1.82288,2.82558],",",true,false],
	["Land_CzechHedgehog_01_F",[-26.4961,-70.8389,-0.010371],350.243,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-43.9395,63.0586,0.00602055],46.7899,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-36.001,73.9053,-0.435037],133.186,1,0,[-1.12912,-4.82034],",",true,false],
	["Land_PortableLight_double_F",[-81.9795,-3.24365,-0.00172472],16.684,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-82.5254,1.22803,0],350.243,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-77.9209,28.7417,0],350.243,1,0,[0,0],",",true,false],
	["Land_HBarrier_01_tower_green_F",[-82.0742,14.1934,0.0183921],8.56674,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-13.9561,-84.9507,-0.00333261],274.793,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-29.4199,81.1104,0.0470996],90.7032,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-87.835,8.33838,1.27848],56.5997,1,0,[-14.5475,12.5288],",",true,false],
	["Land_Razorwire_F",[73.6641,-48.9685,0.486953],119.092,1,0,[1.32174,4.22485],",",true,false],
	["Land_Razorwire_F",[-84.9346,22.2263,-1.25715],133.67,1,0,[-1.27068,-10.8],",",true,false],
	["Land_CzechHedgehog_01_F",[79.293,-40.533,0.0028131],54.7623,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[85.8525,-31.1035,-0.0459146],118.947,1,0,[1.24579,-0.358435],",",true,false],
	["Land_CzechHedgehog_01_F",[67.8867,-61.6851,0],54.7623,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-90.7432,14.4124,0],350.243,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[89.2773,-22.8926,0.00414491],51.7002,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[-12.8555,91.7095,0.0186844],67.2733,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-9.53613,-92.3926,0.0369937],54.4386,1,0,[-0.248271,0.177492],",",true,false],
	["Land_Razorwire_F",[-3.62891,97.9419,-0.0607476],153.525,1,0,[-0.204534,-0.751486],",",true,false],
	["Land_CzechHedgehog_01_F",[4.79883,100.882,0],95.0601,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[16.2764,100.486,-0.479224],181.306,1,0,[-0.673086,-3.9828],",",true,false],
	["Land_CzechHedgehog_01_F",[-3.8252,-102.365,-0.00251961],350.243,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[90.4785,54.1184,0.0577207],280.364,1,0,[-1.79037,0.449308],",",true,false],
	["Land_CzechHedgehog_01_F",[95.5879,68.9534,0.0108111],54.7623,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[98.0078,80.2654,0.334133],269.987,1,0,[-9.39306,1.98765],",",true,false],
	["Land_CzechHedgehog_01_F",[92.7334,96.0017,0.0755451],327.836,1,0,[0,0],",",true,false]
];
[_dict, "AS_base_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_5", "objects", _objects] call DICT_fnc_set;

_center = [11718, 3045.51];
_objects = [
	["Land_Razorwire_F",[49.2588,-41.6628,-0.256674],307.785,1,0,[1.59103,-2.05188],",",true,false],
	["Land_BagBunker_01_large_green_F",[54.9941,-43.9502,0],126.681,1,0,[0,-0],",",true,false],
	["Land_Cargo_Tower_V4_F",[71.9912,-63.696,0],35.8157,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[58.0986,-102.002,0],310.022,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[54.5146,-109.435,-0.480367],133.152,1,0,[-0.477327,-4.62613],",",true,false],
	["Land_BagBunker_01_large_green_F",[48.957,115.054,0.0237188],216.488,1,0,[-2.24155,-1.84899],",",true,false],
	["Land_IRMaskingCover_01_F",[91.2852,-86.0996,-0.000998974],304.694,1,0,[-0.0384492,-0.211421],",",true,false],
	["Land_CzechHedgehog_01_F",[47.0518,-117.823,0],350.243,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[51.0293,120.6,-2.38419e-006],36.7818,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[52.4883,-122.301,-0.00104237],310.358,1,0,[0,0],",",true,false],
	["Land_CzechHedgehog_01_F",[40.1943,-128.875,0],350.243,1,0,[0,0],",",true,false],
	["Land_PortableLight_double_F",[46.2764,-132.956,-0.00205231],293.65,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[40.2832,-134.027,-0.232103],100.431,1,0,[0.715266,-2.19752],",",true,false],
	["Land_BagBunker_01_large_green_F",[-118.631,80.417,0.00690651],126.718,1,0,[-0.446299,3.66477],",",true,false],
	["Land_HBarrier_01_big_tower_green_F",[94.1025,-109.892,0.0132289],36.8545,1,0,[-3.20468,-3.35857],",",true,false],
	["Land_Razorwire_F",[-135.495,59.6602,0.277259],132.456,1,0,[0.660117,2.67294],",",true,false],
	["Land_Razorwire_F",[-124.346,83.2422,-0.430395],307.847,1,0,[0.61212,-3.77568],",",true,false],
	["Land_CzechHedgehog_01_F",[-145.181,51.9155,-0.00393677],40.686,1,0,[0,0],",",true,false],
	["Land_Razorwire_F",[-151.937,47.2678,-0.547931],148.069,1,0,[3.68887,-4.46323],",",true,false],
	["Land_HBarrier_01_tower_green_F",[-161.517,19.4998,0.00144386],34.9006,1,0,[0,0],",",true,false],
	["Land_IRMaskingCover_01_F",[124.578,-109.281,0.000881195],304.694,1,0,[-0.0487752,0.337414],",",true,false],
	["Land_CzechHedgehog_01_F",[-160.62,43.2681,0],168.155,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-169.433,31.6155,0],168.155,1,0,[0,-0],",",true,false],
	["Land_Razorwire_F",[-172.018,25.0042,0.760752],111.135,1,0,[-0.166615,8.0721],",",true,false],
	["Land_Razorwire_F",[-173.881,9.16699,1.39678],97.4691,1,0,[-0.196,10.9345],",",true,false],
	["Land_PortableLight_double_F",[-168.366,47.1042,0],118.621,1,0,[0,-0],",",true,false],
	["Land_CzechHedgehog_01_F",[-174.343,16.7651,0],127.934,1,0,[0,-0],",",true,false],
	["Land_PortableLight_double_F",[-174.96,37.2944,0],137.739,1,0,[0,-0],",",true,false],
	["Land_IRMaskingCover_01_F",[142.681,-121.809,0.000295639],304.664,1,0,[-0.569088,1.09233],",",true,false],
	["Land_HBarrier_01_big_tower_green_F",[167.261,-164.197,0.0372391],36.7081,1,0,[-7.04668,4.63228],",",true,false],
	["Land_HBarrier_01_big_tower_green_F",[223.113,-195.711,0.00857019],357.6,1,0,[-3.0502,0.127964],",",true,false]
];
[_dict, "AS_airfield_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield_1", "objects", _objects] call DICT_fnc_set;
