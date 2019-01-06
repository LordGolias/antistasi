private ["_center", "_objects"];
private _dict = [AS_compositions, "locations"] call DICT_fnc_get;


_center = [3910.76, 12295.1];
_objects = [
	["Land_Razorwire_F",[-20.3972,-40.4414,1.92698],129.813,1,0,[-1.73988,14.3528],"","",true,false],
	["Land_CzechHedgehog_01_F",[-26.0457,-45.0654,-0.331951],67.4283,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-3.7981,51.6426,0],92.942,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[9.53979,53.3232,0],92.942,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-8.65161,57.1592,-1.46383],53.2786,1,0,[3.51171,-12.8851],"","",true,false],
	["Land_Razorwire_F",[14.6516,54.3379,-1.07872],345.254,1,0,[-12.3517,-10.0478],"","",true,false],
	["Land_Razorwire_F",[-34.7683,-47.8896,-0.615395],345.203,1,0,[5.42756,-5.39918],"","",true,false],
	["Land_PortableLight_double_F",[7.90186,57.168,0.0311546],178.651,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[31.063,49.5107,0.993698],220.84,1,0,[3.09144,7.81956],"","",true,false],
	["Land_CzechHedgehog_01_F",[23.1365,55.125,0],71.4108,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-38.4375,-49.6299,0.0104637],310.913,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-40.6301,-50.1143,0],92.942,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-51.9624,-54.752,0.00991821],283.541,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-51.3672,-57.2178,0],313.005,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-60.5449,-59.8135,-0.710331],347.7,1,0,[-1.46901,-3.50684],"","",true,false]
];
[_dict, "AS_outpost_14", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_14", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_14", "objects", _objects] call DICT_fnc_set;

_center = [4174.43, 12889.1];
_objects = [
	["Land_BagBunker_Small_F",[0.0932617,0.0527344,-0.00084877],167.329,1,0,[0.239826,3.15336],"","",true,false],
	["Land_CzechHedgehog_01_F",[-1.5498,-20.5049,0],197.503,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-3.24072,-20.916,0.000303268],169.779,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[1.86621,23.7295,-0.367256],359.753,1,0,[-11.8443,-5.08622],"","",true,false],
	["Land_CzechHedgehog_01_F",[-3.40234,23.8906,0],92.942,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[4.80176,-24.0322,0],92.942,1,0,[0,-0],"","",true,false],
	["Land_HBarrier_Big_F",[-7.47803,-25.1963,0.00227737],313.124,1,0,[-1.77601,0.220176],"","",true,false],
	["Land_PortableLight_double_F",[-5.32275,25.4629,0.0332203],165.931,1,0,[0,-0],"","",true,false],
	["Land_HBarrier_Big_F",[-1.23682,-26.3457,0.000587463],224.221,1,0,[0.669866,1.61135],"","",true,false],
	["Land_CzechHedgehog_01_F",[-18.8906,21.5352,-0.0149956],140.947,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-26.1694,15.9893,0.00156784],318.855,1,0,[-1.47952,-0.533051],"","",true,false],
	["Land_PortableLight_double_F",[-18.0103,23.9746,-0.00319862],179.87,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[24.3374,-25.25,0.135372],223.81,1,0,[-4.02435,1.1119],"","",true,false],
	["Land_Cargo_Tower_V1_F",[-6.2124,-31.3516,0],313.957,1,0,[0,0],"","",true,false],
	["Snake_random_F",[17.1177,39.9863,0.00831032],236.857,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-25.3164,43.3594,0.00837994],63.3221,1,0,[0,0],"","",true,false],
	["Snake_random_F",[31.8882,-49.0596,0.00836372],183.291,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[49.8809,-45.0635,0.373852],196.172,1,0,[-7.68242,4.15263],"","",true,false],
	["Land_Razorwire_F",[-3.45898,-64.9277,-0.217125],93.5423,1,0,[0.718679,-1.71538],"","",true,false],
	["Rabbit_F",[-50.832,50.7588,0],240.979,1,0,[0.171132,-0.793799],"","",true,false]
];
[_dict, "AS_outpost_15", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_15", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_15", "objects", _objects] call DICT_fnc_set;

_center = [4459.12, 12515.2];
_objects = [
	["Land_CzechHedgehog_01_F",[-5.99072,6.52441,0],96.9145,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[4.6543,7.60645,0.0225449],243.636,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-1.14648,8.92871,0.190731],339.558,1,0,[-7.47469,1.48582],"","",true,false],
	["Land_CzechHedgehog_01_F",[-12.9063,-2.81445,0],305.667,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-8.90967,-10.8477,-0.00739288],25.8075,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-21.4043,-6.5957,0.109344],336.452,1,0,[-13.5634,0.981066],"","",true,false],
	["Land_CzechHedgehog_01_F",[-29.2119,-6.91309,-0.017662],242.383,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-39.3921,-5.80566,-0.0502319],7.97311,1,0,[-22.3058,-0.709488],"","",true,false],
	["Snake_random_F",[-44.7627,-16.7549,0.00825119],337.08,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-43.3691,25.2012,0.00814819],201.473,1,0,[0,0],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[-54.8569,95.0547,0.000839233],132.339,1,0,[-1.15427,-1.56838],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[-50.084,105.875,0.0143471],117.941,1,0,[0.634319,2.06505],"","",true,false],
	["Land_HaulTruck_01_abandoned_F",[-46.1997,117.643,0.198143],268.058,1,0,[0.0748629,-6.8492],"","",true,false],
	["Land_Sea_Wall_F",[-87.2734,107.792,-0.327263],234.929,1,0,[20.1282,-17.1943],"","",true,false],
	["Land_Sea_Wall_F",[-81.4067,115.061,1.16864],209.873,1,0,[0,0],"","",true,false],
	["Land_Sea_Wall_F",[-76.2524,126.558,-0.0832558],0,1,0,[20.0689,14.0274],"","",true,false],
	["Land_PortableLight_double_F",[79.7876,164.063,-0.00373459],25.8075,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[83.8438,169.92,-0.330338],143.632,1,0,[-2.81651,-2.66634],"","",true,false],
	["Land_CzechHedgehog_01_F",[86.9321,172.292,0],305.667,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[94.6973,180.777,0],92.942,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[101.055,177.964,0.0129051],243.636,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[95.6807,184.516,-0.225712],290.389,1,0,[7.64282,-2.84509],"","",true,false]
];
[_dict, "AS_resource_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_4", "objects", _objects] call DICT_fnc_set;

_center = [3258.82, 12482];
_objects = [
	["Land_BagFence_Long_F",[2.96069,-6.14648,0.829808],345.596,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[2.2312,-6.47559,0.00128651],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_Long_F",[-3.75366,-7.84375,0.853122],345.596,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-0.726563,-7.16797,0.00128555],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_Long_F",[5.05396,-5.77832,0.00128651],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_Short_F",[-4.86011,-8.88184,0.765412],75.8222,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-3.58984,-7.89844,0.036355],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_Long_F",[7.95142,-5.04004,-0.00994396],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_End_F",[-4.63477,-9.24121,-0.0244551],77.476,1,0,[0.139331,-5.8175],"","",true,false],
	["Land_BagFence_Long_F",[11.7766,-4.01563,0.863557],345.596,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[10.8828,-4.34375,0.0117216],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_Long_F",[13.7844,-3.61133,0.00944996],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_Long_F",[16.7361,-2.86328,0.0012598],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_Long_F",[17.6379,-2.54785,0.884964],345.596,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[19.5928,-2.15625,0.00367451],345.525,1,0,[-5.81884,0.059536],"","",true,false],
	["Land_BagFence_End_F",[21.9199,-1.55078,0.00905895],342.079,1,0,[-5.80485,0.41035],"","",true,false],
	["Land_CzechHedgehog_01_F",[-19.6987,11.2432,0],242.383,1,0,[0,0],"","",true,false],
	["Land_BagFence_Corner_F",[22.6633,-1.33691,-0.0209913],345.978,1,0,[-5.81913,0.0133752],"","",true,false],
	["Land_Razorwire_F",[-24.5771,2.47559,1.48548],307.743,1,0,[-11.3295,13.6492],"","",true,false],
	["Land_BagFence_End_F",[23.0693,-2.91797,-0.053298],72.7169,1,0,[-0.345474,-5.80902],"","",true,false],
	["Land_BagFence_Corner_F",[24.2302,-1.17871,0.000391006],346.047,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-25.2744,25.0225,-0.00274181],257.25,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-26.3108,-36.2676,0.00841188],101.052,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-47.3757,2.12109,0],305.667,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-50.2434,1.7793,-0.000728607],80.1203,1,0,[0,0],"","",true,false],
	["Land_Wreck_Ural_F",[-23.605,-45.4629,0.344907],341.456,1,0,[-4.10852,5.25177],"","",true,false],
	["Snake_random_F",[-54.6128,-23.3984,0.00871658],134.24,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-62.6082,4.98242,0.00844741],35.0379,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-13.4263,-73.1553,-1.18887],198.439,1,0,[11.5025,-10.2249],"","",true,false],
	["Rabbit_F",[59.5833,50.7852,0.0118027],124.193,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[81.4912,15.8867,-0.00889778],336.206,1,0,[0,0],"","",true,false]
];
[_dict, "AS_factory_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_4", "objects", _objects] call DICT_fnc_set;

_center = [3195.62, 12915.5];
_objects = [
	["Land_Cargo_Tower_V1_F",[-6.61353,-26.0322,0],96.5035,1,0,[0,-0],"","",true,false],
	["Salema_F",[45.7859,3.75977,-1.67141],95.0415,1,0,[0,-0],"","",true,false],
	["Salema_F",[50.4734,3.75977,-1.22757],322.692,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[55.3284,43.3701,-0.00512505],269.175,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[56.7922,41.7402,-0.000513077],357.961,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[55.3105,51.8975,0.00353622],89.4159,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[64.2407,41.7588,-0.000511169],0.194305,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[69.7832,42.1387,0.000209808],357.961,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[55.2388,60.9893,-0.0174828],88.4896,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[71.0479,43.8857,-0.00214005],269.175,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[56.8818,62.4385,0.00617981],359.704,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[72.3533,45.6699,-0.00108337],178.658,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[78.429,46.1436,-0.000610352],0.194305,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[66.5479,62.3955,0.000764847],179.843,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[76.769,54.9805,0.215626],180.744,1,0,[0.330174,8.07243],"","",true,false],
	["Land_BagFence_Long_F",[76.6987,57.5547,0.215506],179.517,1,0,[-0.919262,8.0567],"","",true,false],
	["Land_BagFence_Long_F",[84.4209,46.0605,-0.00151062],178.819,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[78.48,56.377,0.000713348],87.7075,1,0,[8.73382,-0.227182],"","",true,false],
	["Land_BagFence_Long_F",[78.408,56.3301,0.750746],87.7151,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[78.354,56.2822,1.49417],87.715,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[86.0413,47.5352,0.00829887],267.605,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[75.9001,62.5654,-0.000511169],359.472,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[85.8467,54.7598,-0.00226402],267.605,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[84.4363,62.8037,-0.00148392],178.669,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[85.8804,61.1563,-0.000894547],89.8833,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[140.964,65.873,-0.00493002],129.365,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[146.917,60.1162,-0.63157],213.35,1,0,[-4.54894,-5.28701],"","",true,false],
	["Land_CzechHedgehog_01_F",[150.925,57.9688,0],305.667,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[167.073,46.5068,0],305.667,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[162.759,65.585,-0.0103307],242.383,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[173.208,40.7041,-0.012526],221.792,1,0,[-0.113288,-0.101262],"","",true,false],
	["Land_CzechHedgehog_01_F",[170.007,61.0645,0],242.383,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[176.713,40.0566,0.000304461],298.582,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[171.234,69.3115,-0.0106783],242.383,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[174.124,71.6523,0.00714111],200.571,1,0,[0,0],"","",true,false]
];
[_dict, "AS_seaport_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_seaport_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_seaport_2", "objects", _objects] call DICT_fnc_set;

_center = [3175.83, 13149];
_objects = [
	["Land_Cargo_Tower_V3_F",[10.3464,0.984375,0],2.70178,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[1.96362,-30.1855,-0.011055],265.585,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[16.0891,-24.7373,0.0756378],358.219,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[10.7285,-30.2549,-0.0327606],283.926,1,0,[6.80011,-0.19351],"","",true,false],
	["Land_BagFence_Long_F",[29.6555,-15.3467,-0.0573196],312.414,1,0,[3.19708,-1.65141],"","",true,false],
	["Land_BagFence_Long_F",[28.3276,-17.9346,0.860355],283.997,1,0,[-3.7073,-4.91779],"","",true,false],
	["Land_BagFence_Long_F",[28.325,-20.875,-0.225521],257.741,1,0,[-2.61759,-9.92548],"","",true,false],
	["Land_BagFence_Long_F",[29.4436,-23.7432,-0.462383],63.6943,1,0,[5.25986,6.08817],"","",true,false],
	["Land_BagFence_Long_F",[20.0842,-40.3115,0.0539436],167.395,1,0,[-3.24518,2.63402],"","",true,false],
	["Land_PortableLight_double_F",[12.0322,-44.6846,0.0593338],270,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-27.0962,42.3125,0.00854874],37.1548,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[92.05,-58.3262,0.0661364],311.024,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[92.1436,-60.374,0],305.667,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[98.8652,-60.6836,0],34.9908,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_13", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_13", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_13", "objects", _objects] call DICT_fnc_set;

_center = [5941.97, 12490.6];
_objects = [
	["Land_Bulldozer_01_wreck_F",[-23.5967,-11.2852,0.0134277],237.834,1,0,[1.77366,-7.65781],"","",true,false],
	["Land_Sea_Wall_F",[-27.3438,2.82129,-0.0218658],134.706,1,0,[-7.64336,-0.408863],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[-15.4243,-27.5293,0.0101395],56.1599,1,0,[-7.59041,5.19693],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[-31.6357,-19.1904,0.0308838],313.407,1,0,[9.00929,7.91097],"","",true,false],
	["Land_Sea_Wall_F",[-1.35547,-36.8633,0.0108337],158.519,1,0,[-3.5388,2.05182],"","",true,false],
	["Land_Razorwire_F",[-40.4185,-22.5156,-0.306877],76.0675,1,0,[-20.8704,-5.19227],"","",true,false],
	["Land_Razorwire_F",[-36.4961,-32.1943,1.73938],53.7949,1,0,[-12.3537,14.457],"","",true,false],
	["Land_Razorwire_F",[-28.7646,-40.4375,2.39481],19.8778,1,0,[-5.16194,18.5788],"","",true,false],
	["Land_Tyres_F",[-33.5874,-75.6045,-0.192902],22.6505,1,0,[2.66274,12.2688],"","",true,false],
	["Land_Tyres_F",[-32.3086,-77.166,0.0497589],263.052,1,0,[9.43169,-8.41007],"","",true,false],
	["Land_JunkPile_F",[-27.2241,-79.2695,-0.0216751],0,1,0,[6.54132,7.26578],"","",true,false],
	["Land_Sea_Wall_F",[-72.2041,-59.8467,-2.57666],63.4211,1,0,[3.20192,13.3543],"","",true,false],
	["Land_Razorwire_F",[-3.43359,93.4678,-0.142059],317.36,1,0,[-0.81034,-1.33036],"","",true,false],
	["Land_Razorwire_F",[20.1025,98.0313,0.826218],39.3734,1,0,[-5.4597,6.64331],"","",true,false],
	["Land_CzechHedgehog_01_F",[3.86963,100.207,0],305.667,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[16.5669,101.976,0],34.9908,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[6.40869,108.846,0.00346375],224.895,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[20.3149,-203.866,0.547081],310.197,1,0,[15.7591,4.35271],"","",true,false],
	["Land_CzechHedgehog_01_F",[14.7271,-209.821,0.0240021],88.9696,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[4.51855,-214.517,1.15977],327.786,1,0,[16.5268,10.1094],"","",true,false],
	["Land_CzechHedgehog_01_F",[0.110352,-218.404,0.054657],92.724,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-9.5835,-226.793,0.0262527],182.047,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-18.7119,-229.808,1.45062],336.025,1,0,[7.93612,13.7427],"","",true,false],
	["Land_CzechHedgehog_01_F",[-23.3408,-233.695,-0.0243683],172.148,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-2.59082,-237.083,0.0632401],285.837,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-30.2568,-239.323,1.06857],317.479,1,0,[10.6392,8.73043],"","",true,false]
];
[_dict, "AS_resource_6", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_6", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_6", "objects", _objects] call DICT_fnc_set;

_center = [4187.74, 15060.9];
_objects = [
	["Land_BagFence_Long_F",[0.425781,-5.4502,-0.0280418],2.57261,1,0,[-0.00177524,0.0395106],"","",true,false],
	["Land_BagFence_Long_F",[-2.54736,-5.3623,0.00278473],2.12518,1,0,[-0.00146664,0.0395232],"","",true,false],
	["Land_BagFence_Long_F",[3.35889,-5.53516,-0.00327492],1.8535,1,0,[-0.00127922,0.0395297],"","",true,false],
	["Land_BagFence_Long_F",[-5.57715,-5.27539,0.0277824],3.33239,1,0,[-0.002299,0.0394836],"","",true,false],
	["Land_BagFence_Long_F",[6.33301,-5.6084,0.10368],2.30092,1,0,[-0.00158787,0.0395185],"","",true,false],
	["Land_BagFence_Long_F",[-8.54883,-5.14844,6.10352e-005],2.88497,1,0,[-0.00199061,0.0395003],"","",true,false],
	["Land_BagFence_Long_F",[11.0923,-5.79297,0.00747108],181.571,1,0,[0.00108416,-0.0395356],"","",true,false],
	["Land_BagFence_Long_F",[12.4727,-1.14355,-0.00346184],271.263,1,0,[0.0395408,0.000871806],"","",true,false],
	["Land_BagFence_Long_F",[-11.5381,-5.03027,0.000921249],3.33239,1,0,[-0.002299,0.0394836],"","",true,false],
	["Land_BagFence_Short_F",[12.6484,1.21289,-0.00128365],274.031,1,0,[0.0394526,0.0027802],"","",true,false],
	["Land_BagFence_Long_F",[12.3999,-4.07031,-0.0024147],271.881,1,0,[0.0395291,0.00129799],"","",true,false],
	["Land_BagFence_Long_F",[-14.5098,-4.90332,-0.00917053],2.88497,1,0,[-0.00199061,0.0395003],"","",true,false],
	["Land_BagFence_Long_F",[-16.042,0.441406,-0.00146294],90.476,1,0,[-0.0395491,-0.000328566],"","",true,false],
	["Land_BagFence_Long_F",[-15.9585,3.26758,-0.00087738],90.476,1,0,[-0.0395491,-0.000328566],"","",true,false],
	["Land_BagFence_Long_F",[-16.209,-3.56543,-0.0071373],272.575,1,0,[0.0395105,0.00177695],"","",true,false],
	["Land_BagFence_Long_F",[-5.28467,26.9746,0.272556],0.994353,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-14.6997,24.0996,-0.000896454],92.6736,1,0,[-0.0395074,-0.00184487],"","",true,false],
	["Land_BagFence_Long_F",[-9.25977,27.1514,0.00905991],0.994353,1,0,[-0.000686353,0.0395445],"","",true,false],
	["Land_BagFence_Short_F",[-12.5439,27.2393,-0.00101089],182.173,1,0,[0.00149956,-0.039522],"","",true,false],
	["Land_BagFence_Short_F",[-14.6113,26.4951,-0.00725365],270.186,1,0,[0.0395502,0.000128431],"","",true,false],
	["Land_CzechHedgehog_01_F",[32.0771,20.2324,0.0346565],34.9908,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[23.124,31.0049,0.0296917],34.9908,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[39.377,11.458,0.00733566],34.9908,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-42.4321,-5.05566,0],34.9908,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[34.6597,33.8418,0],34.9908,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-50.7583,-1.50684,-0.00471497],196.714,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-40.687,-30.3525,0.300627],227.692,1,0,[-4.54292,2.48904],"","",true,false],
	["Land_CzechHedgehog_01_F",[-46.1279,-23.5674,0],305.667,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-48.0684,-23.7227,0.0501213],15.2286,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[101.397,-46.0996,0.369253],180.988,1,0,[-4.09544,3.06679],"","",true,false]
];
[_dict, "AS_powerplant_9", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_9", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_9", "objects", _objects] call DICT_fnc_set;

_center = [4573.98, 15430];
_objects = [
	["Land_BagFence_End_F",[-1.13574,-1.84473,-0.00668335],28.4728,1,0,[0.381663,-8.03078],"","",true,false],
	["Land_BagFence_Long_F",[-3.24609,-0.779297,-0.204193],24.9097,1,0,[-0.121457,-8.03871],"","",true,false],
	["Land_BagFence_Short_F",[1.75537,-3.30664,-0.0951538],203.825,1,0,[-0.188858,-6.60954],"","",true,false],
	["Land_BagFence_Corner_F",[3.38965,-4.11035,-0.00814819],25.4717,1,0,[-0.00203945,6.61219],"","",true,false],
	["Land_BagFence_Corner_F",[-5.2002,0.0810547,-0.0983887],293.363,1,0,[-8.03261,0.339782],"","",true,false],
	["Land_BagFence_Long_F",[2.57568,-6.12207,-0.0027771],115.21,1,0,[-0.0438415,-0.0206398],"","",true,false],
	["Land_BagFence_Long_F",[-6.29102,-2.12012,-0.0128479],117.608,1,0,[-0.0429394,-0.0224563],"","",true,false],
	["Land_BagFence_Corner_F",[-8.31201,-5.98145,7.63956],119.029,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Corner_F",[-10.0132,-5.1543,-0.0744324],293.609,1,0,[0.0444011,0.0194069],"","",true,false],
	["Land_BagFence_Long_F",[-11.0659,-7.34863,9.15527e-005],116.499,1,0,[-0.0433664,-0.0216204],"","",true,false],
	["Land_BagFence_Long_F",[-1.69873,-14.6582,0.0233765],295.595,1,0,[0.0437018,0.020934],"","",true,false],
	["Land_BagFence_Long_F",[-12.8081,-10.8154,0.0195618],294.761,1,0,[0.0440021,0.0202952],"","",true,false],
	["Land_BagFence_Long_F",[-2.94287,-17.3848,-0.0431824],115.245,1,0,[-0.0438289,-0.0206666],"","",true,false],
	["Land_BagFence_Corner_F",[-13.7549,-12.8037,-0.000549316],207.375,1,0,[0.0222813,-0.0430305],"","",true,false],
	["Land_BagFence_Corner_F",[-11.9932,-13.7012,-0.0015564],25.8782,1,0,[-0.0211495,0.0435979],"","",true,false],
	["Land_BagFence_Long_F",[-12.895,-15.6963,-0.00161743],115.245,1,0,[-0.0438289,-0.0206666],"","",true,false],
	["Land_CzechHedgehog_01_F",[-0.405762,27.6309,0],305.667,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V3_F",[-26.5293,7.24707,0.550171],300.211,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-7.76465,-27.248,-0.000427246],296.481,1,0,[0.0433729,0.0216073],"","",true,false],
	["Land_BagFence_Long_F",[-16.5166,-23.4102,-0.0160828],296.481,1,0,[0.0433729,0.0216073],"","",true,false],
	["Land_BagFence_Corner_F",[-8.90381,-29.4395,-0.0274353],114.662,1,0,[-6.61162,0.0918408],"","",true,false],
	["Land_BagFence_Corner_F",[-17.3916,-25.3877,0.103027],205.552,1,0,[0.0307109,8.03953],"","",true,false],
	["Land_BagFence_Long_F",[-10.8857,-28.5156,-0.185059],205.431,1,0,[-0.00275982,-6.61225],"","",true,false],
	["Land_BagFence_Long_F",[-15.2031,-26.4375,-0.202789],28.071,1,0,[0.324957,-8.03318],"","",true,false],
	["Land_CzechHedgehog_01_F",[-12.3667,31.1084,0],305.667,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[23.6616,-32.6396,-0.506744],118.373,1,0,[-10.1676,-4.75735],"","",true,false],
	["Land_PortableLight_double_F",[-6.4917,41.1514,0.0345764],239.391,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-57.2544,2.53223,0.102234],305.469,1,0,[-10.2841,1.97253],"","",true,false],
	["Land_Razorwire_F",[-47.4238,32.8086,0.336426],305.048,1,0,[-14.3685,1.36856],"","",true,false],
	["Land_Razorwire_F",[-33.9331,-57.0791,2.83145],96.1397,1,0,[15.3327,23.0951],"","",true,false],
	["Land_CzechHedgehog_01_F",[-34.6733,-64.9678,0],58.9342,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-36.6128,-69.1289,0.804504],131.831,1,0,[6.77531,5.66397],"","",true,false],
	["Land_Razorwire_F",[-79.1553,-24.7432,-0.25177],280.594,1,0,[-20.6222,-3.56209],"","",true,false],
	["Land_Razorwire_F",[-70.7007,-64.7197,-0.145966],247.802,1,0,[-17.9064,-1.4389],"","",true,false],
	["Land_Razorwire_F",[-55.8906,-77.8789,0.383774],217.031,1,0,[-21.218,4.10921],"","",true,false]
];
[_dict, "AS_outpost_26", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_26", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_26", "objects", _objects] call DICT_fnc_set;

_center = [5243.9, 14180.3];
_objects = [
	["Land_BagBunker_Tower_F",[-8.7041,3.80859,0.00223732],270.504,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-10.5449,-16.4746,0],40.9286,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-1.99951,-23.5361,-0.0249939],28.0505,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V3_F",[27.2646,-43.4092,0.343655],85.1107,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[52.2578,-13.4668,0.39241],94.5773,1,0,[3.42997,3.10752],"","",true,false],
	["Land_Razorwire_F",[51.6787,-21.8154,1.2145],96.5207,1,0,[8.70691,9.52604],"","",true,false],
	["Land_PortableLight_double_F",[-35.1118,53.9063,0.00649071],80.0017,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[70.5264,12.6191,0.41465],233.096,1,0,[-8.81284,3.32293],"","",true,false],
	["Land_PortableLight_double_F",[-59.2568,41.8779,-0.000823975],337.112,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-60.4092,44.7178,0],305.667,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[76.7495,15.0605,0.930681],135.494,1,0,[3.50332,7.34257],"","",true,false],
	["Land_CzechHedgehog_01_F",[-61.5161,55.9912,0],305.667,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-72.1963,50.2324,0.0167313],2.98271,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[2.19238,111.485,-1.80762],346.553,1,0,[-11.5378,-17.1761],"","",true,false],
	["Land_Razorwire_F",[10.2002,113.511,-1.60567],355.631,1,0,[-5.11944,-15.6412],"","",true,false],
	["Land_Razorwire_F",[186.432,35.9395,0.198334],223.575,1,0,[-5.13606,1.64418],"","",true,false],
	["Land_HBarrierTower_F",[191.814,37.0664,0.00978088],351.233,1,0,[0.862742,-5.91205],"","",true,false],
	["Land_Razorwire_F",[197.371,43.1719,0.244492],104.693,1,0,[3.6861,1.28384],"","",true,false],
	["Land_Razorwire_F",[151.213,148.102,0.0139236],314.415,1,0,[-11.3069,-0.315409],"","",true,false],
	["Land_Razorwire_F",[157.485,150.379,-1.03917],45.2568,1,0,[-1.97974,-8.93478],"","",true,false],
	["Land_Razorwire_F",[258.479,123.157,2.62578],112.74,1,0,[-0.146236,20.5467],"","",true,false]
];
[_dict, "AS_base_12", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_12", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_12", "objects", _objects] call DICT_fnc_set;

_center = [5379.96, 14497.8];
_objects = [
	["Land_BagFence_Long_F",[-0.387207,1.21191,0.000347137],313.595,1,0,[0.0286437,0.0272723],"","",true,false],
	["Land_BagFence_Long_F",[1.77979,0.943359,-0.00053215],45.1311,1,0,[-0.0280303,0.0279023],"","",true,false],
	["Land_BagFence_Long_F",[3.85254,-1.09863,0.00431824],45.1311,1,0,[-0.0280303,0.0279023],"","",true,false],
	["Land_PortableLight_double_F",[2.94482,5.80859,0.00147057],93.7323,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[7.2998,-4.7207,-0.00158691],224.778,1,0,[0.0278578,-0.0280745],"","",true,false],
	["Land_BagFence_Short_F",[7.82617,-6.2041,-0.00240707],135.663,1,0,[-0.0276411,-0.0282879],"","",true,false],
	["Land_PortableLight_double_F",[21.5029,24.5303,0.0113335],160.819,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-21.5181,-31.0283,0.00807762],272.24,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-15.1089,-38.5938,0.00856781],51.943,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-43.1743,8.30664,0.00833702],197.166,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-15.5737,47.4902,-0.019392],290.812,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-38.6274,34.5342,-0.00314903],351.844,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-68.6724,40.9824,-0.00166702],231.039,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-25.8359,81.874,-0.395023],50.7898,1,0,[0.361546,-3.5441],"","",true,false],
	["Land_Razorwire_F",[-69.1895,52.2021,0.0897617],294.073,1,0,[-1.33549,0.741876],"","",true,false],
	["Land_Razorwire_F",[-67.064,60.0693,0.265709],260.851,1,0,[0.0385923,2.15931],"","",true,false],
	["Land_Razorwire_F",[-95.9263,-34.3086,0.317366],229.687,1,0,[-4.80854,2.58477],"","",true,false],
	["Land_CzechHedgehog_01_F",[-103.184,-26.123,0],160.347,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-109.176,-18.8838,-0.317846],42.5094,1,0,[-0.0981666,-2.26597],"","",true,false],
	["Land_CzechHedgehog_01_F",[72.0269,83.1455,0],305.667,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[79.7021,81.3906,0.192459],183.867,1,0,[-4.98441,1.42945],"","",true,false],
	["Land_CzechHedgehog_01_F",[-113.648,-14.415,0],305.667,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[62.4985,96.0664,0],305.667,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-117.333,7.88379,0.33769],280.928,1,0,[-1.30112,2.70333],"","",true,false],
	["Land_CzechHedgehog_01_F",[-117.581,2.38379,0],305.667,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[66.1885,98.584,-0.00253296],228.509,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[61.9468,100.797,-0.0710182],255.313,1,0,[-0.932614,-0.545223],"","",true,false],
	["Land_PortableLight_double_F",[-121.837,-14.1484,0.00396347],85.2572,1,0,[0,0],"","",true,false]
];
[_dict, "AS_factory_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_2", "objects", _objects] call DICT_fnc_set;

_center = [5450.45, 14978.3];
_objects = [
	["Land_MedicalTent_01_floor_dark_F",[1.77002,9.89355,0],37.2213,1,0,[0,0],"","",true,false],
	["CamoNet_BLUFOR_open_F",[1.74414,9.73633,0],305.021,1,0,[0,0],"","",true,false],
	["Land_MedicalTent_01_floor_dark_F",[-2.14795,-15.7217,0],308.945,1,0,[0,0],"","",true,false],
	["CamoNet_BLUFOR_open_F",[-1.99121,-15.7529,0],216.745,1,0,[0,0],"","",true,false],
	["Land_MedicalTent_01_floor_dark_F",[21.626,-7.57031,0],221.217,1,0,[0,0],"","",true,false],
	["CamoNet_BLUFOR_open_F",[21.6636,-7.41504,0],129.017,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-38.5908,-3.96289,0.00873375],163.219,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Tower_V1_F",[35.748,23.874,0],40.5723,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-23.6763,-38.5215,-0.0421619],312.392,1,0,[0.0234707,-0.456947],"","",true,false],
	["Land_Rampart_F",[43.3491,16.9932,0.389893],221.854,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-30.0752,-35.417,0.128717],39.1032,1,0,[0.457541,-0.00278699],"","",true,false],
	["Land_BagFence_Long_F",[-9.89014,52.1123,7.81563],130.848,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-37.9639,38.165,-3.8147e-006],309.666,1,0,[0.0152187,0.0126195],"","",true,false],
	["Rabbit_F",[-52.2021,18.0771,0.0436745],45.1489,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-14.0767,52.9541,5.94955],217.735,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-8.07031,54.5479,7.94283],309.353,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-9.61279,58.2861,0.64143],217.735,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[57.5581,-18.6875,0.598291],337.966,1,0,[6.20123,4.98477],"","",true,false],
	["Land_BagFence_Long_F",[-15.832,62.3164,0.00486374],40.3959,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-14.0669,-65.167,0.00843048],214.183,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[65.6826,-16.1631,0],305.667,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[67.9414,-16.0811,0.0186234],313.027,1,0,[0,0],"","",true,false],
	["Snake_random_F",[61.8525,-37.8271,0.00839233],125.933,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[73.9253,5.47559,0.20105],65.141,1,0,[-23.3797,1.54091],"","",true,false],
	["Land_CzechHedgehog_01_F",[77.0034,-2.72559,0],305.667,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[77.9355,-2.66211,0.0139332],308.552,1,0,[0,0],"","",true,false],
	["Land_HelipadSquare_F",[56.4277,56.9492,0],312.278,1,0,[0,0],"","",true,false],
	["Rabbit_F",[0.915039,99.79,0.00441742],300,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[77.7461,72.1494,-0.342194],39.4858,1,0,[10.2139,-0.876244],"","",true,false],
	["Land_Razorwire_F",[93.6675,58.4912,0.109722],222.595,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[84.6055,72.666,0],227.033,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[85.3291,74.3535,0.00503731],285.006,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[92.627,65.708,0],190.534,1,0,[0,0],"","",true,false],
	["Rabbit_F",[41.9736,114.055,-0.0176392],140.685,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[13.4482,126.847,0.0341873],225.163,1,0,[0,0],"","",true,false],
	["Rabbit_F",[93.3472,98.1035,-0.00182343],89.9228,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_16", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_16", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_16", "objects", _objects] call DICT_fnc_set;

_center = [8205.46, 10958];
_objects = [
	["Snake_random_F",[49.5,-6.96289,0],340.252,1,0,[-0.0682338,-0.868284],"","",true,false],
	["Land_PortableLight_double_F",[50.5137,-24.9307,0.0102482],180.461,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-1.04785,-57.1523,-0.00159836],2.31235,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-4.07422,-57.1602,-0.00022316],180.676,1,0,[0,0],"","",true,false],
	["Land_BagFence_End_F",[-5.34668,-57.2051,0.00200653],271.525,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[0.451172,-59.0127,-0.000974655],271.566,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[0.442383,-59.7764,-0.000442505],91.8125,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-5.43359,-59.5898,-0.00140381],91.8125,1,0,[0,-0],"","",true,false],
	["Land_BagFence_End_F",[0.352539,-61.46,-0.00374603],92.8941,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[2.48926,-62.2441,-0.00119209],181.813,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[61.6484,-15.0674,0.065649],265.748,1,0,[-0.0367755,0.538701],"","",true,false],
	["Land_BagFence_Long_F",[4.06348,-64.0283,-0.00139999],93.0469,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-30.27,-59.7236,0.0247955],163.489,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Corner_F",[4.0166,-68.2813,-0.00534821],88.2317,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[1.84473,-68.2061,-0.00101852],183.192,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[66.3604,-45.5283,-0.000169754],182.48,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[65.5527,-48.748,0],305.667,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[66.6016,-60.2441,0],305.667,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[62.5986,63.4902,-0.461817],284.953,1,0,[-1.22663,-3.40748],"","",true,false],
	["Land_PortableLight_double_F",[24.4092,-87.6807,0.0170231],179.253,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[67.9131,-63.5762,0.00494862],348.256,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[63.2861,81.3652,0.624165],39.9855,1,0,[2.65658,5.02026],"","",true,false]
];
[_dict, "AS_powerplant_8", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_8", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_8", "objects", _objects] call DICT_fnc_set;

_center = [8308.6, 10084.4];
_objects = [
	["Land_CzechHedgehog_01_F",[3.04102,0.993164,0],276.025,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-0.254883,-5.72559,0],297.289,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-7.42285,-5.81836,0],167.665,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[1.09375,-9.90137,0.00447845],229.312,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[10.4199,1.62598,-0.0197296],233.23,1,0,[2.10874,-0.622874],"","",true,false],
	["Land_PortableLight_double_F",[9.34277,-8.82422,0.0189209],53.0306,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-15.3652,10.1855,0.60257],325.281,1,0,[-3.82917,4.51609],"","",true,false],
	["Land_CzechHedgehog_01_F",[10.0059,22.418,0],305.667,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[25.292,16.7568,0],211.877,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Large_F",[-28.8047,-12.7041,0.0415573],58.4057,1,0,[-3.91888,0.620358],"","",true,false],
	["Land_PortableLight_double_F",[19.9736,27.3213,0.00939178],237.263,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[34.4561,-2.16016,0],230.062,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[28.9678,19.6309,0.0115967],232.79,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-30.2666,-21.5586,0],297.289,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-35.7324,-15.001,-0.462006],58.5327,1,0,[-7.84215,-4.03065],"","",true,false],
	["Land_CzechHedgehog_01_F",[-37.3037,-10.3486,0],28.3742,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-43.4268,12.918,0.00840759],287.699,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-15.2441,-45.5146,0.167549],297.289,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[37.9785,-29.4512,-0.26519],340.24,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[20.2246,-45.6816,-0.364944],293.606,1,0,[0,0],"","",true,false],
	["Snake_random_F",[14.1719,49.958,0.00790405],238.774,1,0,[0,0],"","",true,false],
	["Snake_random_F",[57.6807,-9.07813,0.00843048],315.568,1,0,[0,0],"","",true,false],
	["Rabbit_F",[66.5537,44.3418,0.010498],287.893,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_11", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_11", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_11", "objects", _objects] call DICT_fnc_set;

_center = [10016.6, 11241.7];
_objects = [
	["Land_CzechHedgehog_01_F",[11.0498,-2.20703,0],121.779,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[14.8936,1.18359,0],166.786,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Tower_V1_F",[6.47754,4.85742,0],314.597,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[15.3193,-1.26758,0.0232315],310.817,1,0,[0.191739,-0.339213],"","",true,false],
	["Land_CzechHedgehog_01_F",[17.7256,5.61523,0],151.597,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[6.62305,22.3555,-0.297297],143.241,1,0,[1.5617,-2.12029],"","",true,false],
	["Land_CzechHedgehog_01_F",[-18.8369,-16.9453,0],121.779,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-19.0527,-21.5391,0],270.58,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-4.77246,-30.7617,0],121.779,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-21.709,-24.0225,-0.191063],274.31,1,0,[-20.6764,-1.78132],"","",true,false],
	["Land_CzechHedgehog_01_F",[-18.9766,-25.749,0],334.037,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-4.24023,-34.0635,0.141546],293.604,1,0,[9.17099,2.87251],"","",true,false],
	["Land_CzechHedgehog_01_F",[23.6221,22.917,0],211.877,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[27.1582,20.6064,0.0146093],285.727,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[12.5371,34.1523,0],262.111,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[8.74609,42.2002,0.00460434],148.486,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[42.8623,-3.30566,0.00741482],65.9128,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-8.64258,51.1318,0.00823593],80.6838,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-56.4736,10.1152,0.00865459],332.813,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-16.1709,65.4082,0.00784492],164.577,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_outpost_25", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_25", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_25", "objects", _objects] call DICT_fnc_set;

_center = [10822.1, 10871.7];
_objects = [
	["Land_HBarrier_Big_F",[-2.83105,-2.80469,0.00938129],179.558,1,0,[-2.18368,3.98598],"","",true,false],
	["Land_HBarrier_Big_F",[-3.88965,9.39355,0.0186634],179.563,1,0,[0.065888,8.56787],"","",true,false],
	["Land_HBarrier_Big_F",[-11.3564,-3.15625,0.0220313],179.564,1,0,[2.21468,9.97259],"","",true,false],
	["Land_Cargo_Tower_V3_F",[-0.00976563,4.25391,0],1.00655,1,0,[0,0],"","",true,false],
	["Land_HBarrier_Big_F",[-12.4746,9.04395,0.0232539],179.564,1,0,[4.04607,10.4208],"","",true,false],
	["Land_Razorwire_F",[4.3418,-17.4385,-0.482887],325.114,1,0,[-1.37003,-3.69667],"","",true,false],
	["Land_Razorwire_F",[12.6123,11.6982,-0.10393],30.5049,1,0,[0.202395,-0.944674],"","",true,false],
	["Land_Razorwire_F",[-43.71,-2.77246,0.230231],91.4045,1,0,[5.60319,1.43657],"","",true,false],
	["Snake_random_F",[28.2461,34.5225,0.00884819],316.705,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-44.1699,23.0557,0.0286593],94.0706,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-41.3604,33.4141,0],94.0706,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-12.8682,53.4082,0.00802422],130.79,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[23.4609,48.6357,0.0086441],343.853,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-28.7627,-46.6348,1.22954],156.374,1,0.0498708,[4.03017,9.89194],"","",true,false],
	["Rabbit_F",[32.5938,45.9297,0.0203171],270.169,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-44.6777,-38.7549,-0.571764],88.862,1,0,[-0.700707,-4.40907],"","",true,false],
	["Rabbit_F",[60.8525,0.0429688,-0.00292587],0.33614,1,1,[-3.7975,-2.84661],"","",true,false],
	["Rabbit_F",[-31.9707,-54.0088,-0.00310993],357.134,1,1,[-7.09805,-9.49853],"","",true,false],
	["Land_CzechHedgehog_01_F",[-45.8203,45.209,0],211.877,1,0,[0,0],"","",true,false],
	["Rabbit_F",[65.5693,0.104492,-0.00295353],357.85,1,1,[3.05414,-10.1],"","",true,false],
	["Land_Razorwire_F",[-23.3701,-65.1279,-0.247916],322.271,1,0,[1.13037,-2.03342],"","",true,false],
	["Land_PortableLight_double_F",[-47.7578,50.1338,-0.00508738],168.002,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-58.1514,41.7354,0],262.111,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-62.5449,37.2988,0.727947],135.371,1,0,[-5.7974,5.93867],"","",true,false],
	["Land_CzechHedgehog_01_F",[-28.6729,-67.5273,-0.0189953],262.111,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-58.8193,47.5596,-0.00715113],167.14,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-37.1963,-66.9258,-0.303519],1.37729,1,0,[-3.29235,-2.75624],"","",true,false],
	["Land_CzechHedgehog_01_F",[-42.9648,-67.1201,0],262.111,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-43.9063,-73.917,-0.0010581],359.177,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-56.4893,-74.3037,-0.00205851],349.388,1,0,[0,0],"","",true,false],
	["Rabbit_F",[96.751,56.5088,0.0524864],44.6459,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_12", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_12", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_12", "objects", _objects] call DICT_fnc_set;

_center = [10291, 8630.39];
_objects = [
	["Land_HBarrierTower_F",[2.2627,-10.832,-0.00221252],354.964,1,0,[5.31229,2.14741],"","",true,false],
	["Land_Razorwire_F",[-9.4873,-7.7002,0.0177307],212.146,1,0,[-0.875501,0.532499],"","",true,false],
	["Land_Razorwire_F",[12.8555,-2.08008,-0.145393],311.075,1,0,[8.34238,-0.176085],"","",true,false],
	["Land_PortableLight_double_F",[7.67773,-13.832,0.0113525],347.274,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-27.21,2.40527,0.383736],22.5317,1,0,[4.45993,3.1799],"","",true,false],
	["Land_Razorwire_F",[25.5342,11.1465,1.25124],332.32,1,0,[-6.42228,10.2881],"","",true,false],
	["Land_Razorwire_F",[-44.0703,7.53223,-0.961174],17.5605,1,0,[-2.51152,-8.45462],"","",true,false],
	["Snake_random_F",[11.7305,48.9141,0.00846863],149.463,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-55.9414,36.3359,0.677788],96.6599,1,0,[3.82894,6.19202],"","",true,false],
	["Land_Razorwire_F",[75.1885,17.2217,-0.482506],167.078,1,0,[-1.99844,-3.92516],"","",true,false],
	["Land_Razorwire_F",[-55.4248,57.5879,-0.750648],105.861,1,0,[2.40566,-6.75],"","",true,false],
	["Land_Razorwire_F",[-49.0996,74.4219,-0.643639],119.194,1,0,[5.14718,-5.587],"","",true,false],
	["Land_Razorwire_F",[-33.3896,90.4346,0.291912],146.529,1,0,[3.74484,5.38072],"","",true,false],
	["Land_Razorwire_F",[109.899,21.8154,0.0220985],161.465,1,0,[-4.00553,-0.431208],"","",true,false],
	["Land_Razorwire_F",[125.409,27.1641,0.993027],161.534,1,0,[-4.34962,7.17174],"","",true,false],
	["Land_Cargo_Tower_V1_F",[114.466,90.8877,0.592575],29.9677,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[7.08203,153.533,-0.157288],105.439,1,0,[0.721964,-1.46464],"","",true,false],
	["Land_Razorwire_F",[150.924,38.1416,-0.13726],149.278,1,0,[-7.20316,-0.5213],"","",true,false],
	["Land_Razorwire_F",[164.769,48.0654,0.264439],138.048,1,0,[-5.95044,2.2686],"","",true,false],
	["Land_CzechHedgehog_01_F",[170.231,53.3262,-0.0243301],124.662,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[19.0449,183.063,-0.617336],93.5468,1,0,[15.5516,-5.95535],"","",true,false],
	["Land_Razorwire_F",[173.962,62.415,0.718815],95.8114,1,0,[-1.70967,5.41535],"","",true,false],
	["Land_CzechHedgehog_01_F",[175.572,71.1484,0],315.553,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[179.263,73.6445,0.0131989],283.213,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[176.448,89.6836,-0.0353241],189.937,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[170.886,100.669,0.125206],63.1654,1,0,[-0.916663,1.23383],"","",true,false],
	["Land_CzechHedgehog_01_F",[167.779,106.088,0],65.5787,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[164.67,114.477,-0.527603],73.327,1,0,[2.0621,-4.04032],"","",true,false],
	["Land_PortableLight_double_F",[181.324,87.3662,0.00595856],287.328,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[151.422,134.534,-0.24971],56.7363,1,0,[1.92199,-2.08232],"","",true,false],
	["Land_Razorwire_F",[124.432,160.192,0.866077],235.315,1,0,[0.718273,6.81008],"","",true,false],
	["Land_Razorwire_F",[28.3984,203.522,0.571495],128.209,1,0,[13.0466,4.80099],"","",true,false],
	["Land_Razorwire_F",[108.451,185.398,-0.255745],218.056,1,0,[12.2148,-1.96251],"","",true,false],
	["Land_HBarrierTower_F",[39.2959,214.665,-0.00178528],168.685,1,0,[6.01845,1.76522],"","",true,false],
	["Land_PortableLight_double_F",[34.1318,217.929,0.0655212],167.159,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[83.6885,204.824,0.338917],212.876,1,0,[10.4073,3.55758],"","",true,false],
	["Land_Razorwire_F",[54.7031,217.659,-0.527672],194.413,1,0,[12.8152,-6.1865],"","",true,false]
];
[_dict, "AS_outpostAA_17", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_17", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_17", "objects", _objects] call DICT_fnc_set;

_center = [12286.7, 8903.44];
_objects = [
	["Land_BagBunker_Large_F",[-17.4023,-7.17676,-0.0167694],53.5161,1,0,[1.71935,-1.27168],"","",true,false],
	["Land_CzechHedgehog_01_F",[21.6592,9.04785,-0.00832367],126.607,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[20.0557,12.499,0.184723],248.22,1,0,[1.54575,1.603],"","",true,false],
	["Land_Razorwire_F",[-26.4102,7.65039,0.0383606],98.3505,1,0,[6.34768,0.240896],"","",true,false],
	["Land_Razorwire_F",[-27.2695,-1.06055,0.064621],91.1018,1,0,[4.80066,0.092549],"","",true,false],
	["Land_Razorwire_F",[17.1172,20.5615,0.1604],259.667,1,0,[0.00759376,1.31846],"","",true,false],
	["Land_Razorwire_F",[-24.9277,16.0088,-0.031868],103.756,1,0,[6.07389,-0.473697],"","",true,false],
	["Land_Razorwire_F",[-22.1064,23.8193,-0.390991],114.546,1,0,[5.5212,-4.34901],"","",true,false],
	["Land_Razorwire_F",[15.041,28.626,0.944397],255.151,1,0,[2.38736,7.4646],"","",true,false],
	["Land_CzechHedgehog_01_F",[-20.1299,27.1074,0],189.937,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-21.1055,-25.2285,0.113678],81.7695,1,0,[3.06774,0.945045],"","",true,false],
	["Land_Razorwire_F",[-15.9248,32.3457,-0.0426483],130.063,1,0,[7.53576,-0.313569],"","",true,false],
	["Land_Razorwire_F",[40.7139,-5.58301,-0.0504456],243.042,1,0,[8.82235,-0.580277],"","",true,false],
	["Land_CzechHedgehog_01_F",[42.7744,-9.63184,-0.0496445],161.099,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[45.5508,-37.9482,-0.0213242],326.573,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[33.3008,-55.3896,1.06795],86.6342,1,0,[-1.7862,9.05893],"","",true,false],
	["Land_CzechHedgehog_01_F",[16.4785,-66.9629,0],189.937,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[29.2725,-66.1563,0],189.937,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[15.8984,-75.541,0.0406189],328.501,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[27.7607,-75.0674,0.0399704],359.095,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_10", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_10", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_10", "objects", _objects] call DICT_fnc_set;

_center = [11643.1, 11972.1];
_objects = [
	["Land_Cargo_Tower_V1_F",[3.64551,4.93457,0],306.982,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-12.2256,9.60449,0],37.0392,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-7.33789,15.3799,-0.0771866],129.212,1,0,[-0.661814,-0.638869],"","",true,false],
	["Land_Razorwire_F",[-15.8213,5.02637,-0.140234],129.226,1,0,[-1.38314,-1.32524],"","",true,false],
	["Land_CzechHedgehog_01_F",[14.1826,-11.5254,-0.00201416],20.6206,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[18.4219,-5.63184,-0.00132561],125.579,1,0,[1.40303,-0.123242],"","",true,false],
	["Land_CzechHedgehog_01_F",[-19.8223,-1.17773,-0.0103397],63.8817,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[12.1406,-15.2012,0.076889],125.593,1,0,[1.41978,0.641079],"","",true,false],
	["Land_CzechHedgehog_01_F",[-4.33203,19.4912,0],37.0392,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[20.4365,-2.51074,-0.0116711],293.027,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-21.3301,-9.07813,0.0210686],272.848,1,0,[1.21293,0.21378],"","",true,false],
	["Land_CzechHedgehog_01_F",[7.23438,-21.5566,0],106.99,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[24.8105,3.45313,-0.135103],123.193,1,0,[0.0740665,-1.22937],"","",true,false],
	["Land_Razorwire_F",[0.561523,25.2656,-0.0505619],129.209,1,0,[-0.259144,-0.40752],"","",true,false],
	["Land_CzechHedgehog_01_F",[-20.5566,-13.0039,-0.00933838],347.307,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[1.20117,-27.0859,-0.129766],318.476,1,0,[-1.2854,-1.10632],"","",true,false],
	["Snake_random_F",[18.7979,-20.4082,0.0083847],95.2159,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[3.67578,28.5029,0.00132561],37.0392,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-2.24414,-29.5576,0],19.0824,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[26.5615,17.9414,0.192974],52.6588,1,0,[-3.3145,1.57031],"","",true,false],
	["Land_Razorwire_F",[8.56543,34.2725,-0.101307],129.213,1,0,[-0.253975,-0.897023],"","",true,false],
	["Land_PortableLight_double_F",[-2.10645,40.4482,-0.00307655],248.115,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[14.0469,38.3584,-0.00533867],189.937,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[22.7373,38.8311,-0.000822067],327.894,1,0,[0,0],"","",true,false],
	["Snake_random_F",[46.6953,2.95703,0.00823593],353.651,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[6.12891,49.8701,0],189.937,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[8.64551,54.0752,-0.00118637],132.911,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[51.1406,21.4307,0.00839806],208.883,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-35.4482,-42.7275,-0.00252151],179.939,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-28.7529,76.834,-0.066],39.1702,1,0,[-0.818163,-0.567781],"","",true,false],
	["Land_Razorwire_F",[-78.4268,60.5322,-0.0141048],299.984,1,0,[1.30796,-0.127123],"","",true,false],
	["Land_Razorwire_F",[-95.1895,33.9023,0.0236626],299.995,1,0,[0.832165,0.391944],"","",true,false],
	["Land_Razorwire_F",[-110.975,8.39063,0.139322],300.01,1,0,[2.02198,1.07979],"","",true,false],
	["Land_Razorwire_F",[-57.2988,94.3389,0.0305977],299.989,1,0,[1.32575,0.147683],"","",true,false],
	["Land_Razorwire_F",[-112.929,-7.80566,0.0312614],271.151,1,0,[1.67524,0.262702],"","",true,false],
	["Land_Razorwire_F",[-109.721,-38.7842,0.403599],271.444,1,0,[5.48904,3.19224],"","",true,false],
	["Land_Razorwire_F",[-99.0801,-76.5586,-0.147268],256.891,1,0,[2.90956,-1.30531],"","",true,false],
	["Land_Razorwire_F",[-93.0781,-82.2871,-0.46599],209.521,1,0,[-0.449692,-3.8512],"","",true,false],
	["Land_HBarrierTower_F",[117.206,-99.3838,-0.00421333],264.35,1,0,[3.88729,-0.999066],"","",true,false],
	["Land_BagBunker_Large_F",[-185.701,-282.336,0.0336857],124.347,1,0,[-3.21312,-0.439996],"","",true,false],
	["Land_BagBunker_Large_F",[-351.653,-521.605,0.0125999],89.0986,1,0,[-1.10136,2.91814],"","",true,false]
];
[_dict, "AS_airfield_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield_4", "objects", _objects] call DICT_fnc_set;

_center = [10960.8, 12699];
_objects = [
	["Land_Razorwire_F",[23.542,19.8457,0.338232],43.5749,1,0,[-0.365426,2.70948],"","",true,false],
	["Land_Razorwire_F",[-1.87988,49.8564,0.0443573],79.2706,1,0,[0.146405,0.361101],"","",true,false],
	["Snake_random_F",[-47.4697,-16.3779,0],356.699,1,0,[1.18491,-0.680501],"","",true,false],
	["Land_Razorwire_F",[51.6406,-7.50879,0.300295],45.1213,1,0,[-1.30057,2.04924],"","",true,false],
	["Land_Razorwire_F",[-42.2324,-35.5889,-0.268612],297.784,1,0,[0.0466544,-2.21937],"","",true,false],
	["Land_CzechHedgehog_01_F",[-3.14941,54.3652,0],189.937,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-3.2998,56.2236,0.00179482],186.027,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-12.5693,60.085,-0.00195122],201.324,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-59.791,-71.0332,-0.272427],297.673,1,0,[-0.0252403,-2.25487],"","",true,false],
	["Land_Razorwire_F",[-35.2158,-107.632,-0.147917],208.789,1,0,[-1.55625,-1.29137],"","",true,false],
	["Land_Razorwire_F",[-69.8447,-90.0518,0.2316],148.771,1,0,[-1.18305,1.87888],"","",true,false],
	["Land_CzechHedgehog_01_F",[-77.5449,-94.7764,0],189.937,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-7.44824,-123,-0.141579],208.784,1,0,[-1.15515,-1.0701],"","",true,false],
	["Land_Razorwire_F",[107.749,-54.3018,-0.0651321],32.8461,1,0,[-2.50688,0.927575],"","",true,false],
	["Land_CzechHedgehog_01_F",[-88.499,-88.1006,0],133.738,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-92.5176,-84.0684,-0.283497],226.882,1,0,[-0.189443,-2.43745],"","",true,false],
	["Land_PortableLight_double_F",[-79.7178,-97.3252,0.0337143],45.0756,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-89.6494,-91.3252,0.00564575],13.9309,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[25.3936,-140.815,-0.0755157],208.777,1,0,[-0.0101825,-0.6154],"","",true,false],
	["Land_Razorwire_F",[121.684,-77.3721,0.0810337],115.095,1,0,[2.18933,1.44682],"","",true,false],
	["Land_Razorwire_F",[104.118,-113.385,-0.0597687],118.688,1,0,[2.09719,-0.332277],"","",true,false],
	["Land_Razorwire_F",[51.2021,-155.065,-0.00961685],208.783,1,0,[0.980478,0.277379],"","",true,false],
	["Land_Razorwire_F",[85.7217,-147.794,-0.22179],118.706,1,0,[0.722824,-1.95506],"","",true,false]
];
[_dict, "AS_powerplant_6", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_6", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_6", "objects", _objects] call DICT_fnc_set;

_center = [6184.62, 16209.4];
_objects = [
	["Land_CzechHedgehog_01_F",[1.67773,-2.43652,0],81.1312,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[0.854492,-12.6123,-3.8147e-006],266.596,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-11.145,-13.7334,-3.8147e-006],266.596,1,0,[0,0],"","",true,false],
	["Snake_random_F",[4.41748,-18.3389,0.00838852],268.732,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[2.65723,-20.8711,0],8.2262,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-11.1602,-19.9492,0],189.937,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-11.8311,-22.9424,0],83.701,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[1.41943,-32.0195,0.00194931],268.965,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-59.8579,-36.8633,0.00374985],274.462,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-56.1553,43.8857,0.00838852],222.668,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-51.6265,56.6865,0.00838852],254.982,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-95.1831,-22.999,-3.8147e-006],174.71,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-5.84375,99.7607,-0.141769],220.424,1,0,[-2.31473,-1.16871],"","",true,false],
	["Land_Razorwire_F",[-21.2593,99.6797,-0.172737],321.288,1,0,[-0.597847,-1.47861],"","",true,false],
	["Land_CzechHedgehog_01_F",[-11.2769,103.888,0],29.6985,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-15.6812,103.617,0],254.993,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[117.024,-18.0742,0.00104904],85.7578,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[118.856,-7.11328,-3.8147e-006],86.6568,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[118.928,-15.8701,0],319.842,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[78.7979,101.073,0.0712967],179.421,1,0,[-0.910407,0.620329],"","",true,false],
	["Land_Razorwire_F",[128.178,-6.44922,-3.8147e-006],86.6568,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[128.753,-15.376,0],329.479,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[129.49,-17.2227,0.00413895],272.204,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-118.389,73.4639,-0.0258904],181.743,1,0,[-8.26531,-0.253255],"","",true,false],
	["Land_Razorwire_F",[-163.987,-16.7861,-0.00340652],95.7256,1,0,[0.0736495,0.00738449],"","",true,false],
	["Land_PortableLight_double_F",[-166.202,-29.2744,0.000743866],284.94,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-178.809,-15.5273,0.0401039],93.7801,1,0,[0.131502,0.314544],"","",true,false],
	["Land_PortableLight_double_F",[-179.515,-27.6963,-0.000175476],97.1418,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[182.338,-8.0166,-0.0114059],348.656,1,0,[0.0600302,-0.0901868],"","",true,false],
	["Land_Razorwire_F",[-182.066,39.3164,0.0212746],185.823,1,0,[-0.578243,0.401852],"","",true,false],
	["Land_Razorwire_F",[-204.7,13.0635,0.019928],191.964,1,0,[0.459618,0.409369],"","",true,false],
	["Land_Razorwire_F",[187.657,92.6396,-0.639484],193.238,1,0,[-12.5593,-7.08758],"","",true,false],
	["Land_Razorwire_F",[-206.933,2.51074,0.0178986],191.964,1,0,[-0.0314985,0.148651],"","",true,false],
	["Land_PortableLight_double_F",[-212.413,14.7979,0.00166702],85.191,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-214.604,4.86816,-0.00113678],125.337,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[214.62,19.0557,-0.0177994],265.102,1,0,[-2.68811,-0.0757664],"","",true,false]
];
[_dict, "AS_factory_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_3", "objects", _objects] call DICT_fnc_set;

_center = [6803.94, 16089.1];
_objects = [
	["Land_BagBunker_Tower_F",[-6.3916,6.57715,-0.258224],56.2161,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-5.03662,-17.3438,-0.942661],230.819,1,0,[-12.8397,-8.70402],"","",true,false],
	["Land_CzechHedgehog_01_F",[-1.33838,-21.3066,0],189.937,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[3.59375,-30.5244,0.0250282],66.3509,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[25.3325,-27.25,0],215.14,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[40.6055,-44.6748,0.242485],29.1121,1,0,[-0.343806,2.3432],"","",true,false],
	["Land_CzechHedgehog_01_F",[40.5508,-47.8525,0],189.937,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-44.9126,44.2324,-0.773842],262.58,1,0,[-6.50502,-6.59273],"","",true,false],
	["Land_Razorwire_F",[62.6084,-25.5801,-0.307861],231.195,1,0,[-5.17596,-1.80565],"","",true,false],
	["Land_PortableLight_double_F",[49.1748,-49.1592,-0.00525665],308.906,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[56.1802,-42.9805,-0.00524521],331.676,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[64.915,-29.4297,0],319.886,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[63.3115,-36.6016,-0.396095],287.395,1,0,[1.46565,-3.1401],"","",true,false],
	["Land_CzechHedgehog_01_F",[62.1514,-40.4385,0],280.315,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-46.9341,59.0742,-0.855507],267.232,1,0,[-5.58588,-7.33703],"","",true,false],
	["Land_Razorwire_F",[3.29102,79.9932,1.45988],195.328,1,0,[-3.94164,11.3625],"","",true,false],
	["Land_Razorwire_F",[-10.8608,82.0059,2.53793],175.193,1,0,[-5.61848,19.6797],"","",true,false],
	["Land_Razorwire_F",[-45.9937,70.3486,-0.824966],304.835,1,0,[2.73678,-7.26891],"","",true,false],
	["Land_Razorwire_F",[18.501,81.3096,0.690819],162.645,1,0,[1.24862,5.51561],"","",true,false],
	["Land_Razorwire_F",[-22.6538,81.1563,0.474037],172.151,1,0,[-4.42159,2.54356],"","",true,false],
	["Land_CzechHedgehog_01_F",[-30.0679,80.1924,0],7.03745,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-40.8242,77.2813,0],189.937,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-31.9312,84.2891,0.0184326],164.239,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-41.5269,81.1416,-0.00626373],185.236,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_22", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_22", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_22", "objects", _objects] call DICT_fnc_set;

_center = [8386.65, 18244.8];
_objects = [
	["Land_CzechHedgehog_01_F",[8.10547,-0.677734,0],161.472,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[8.86133,2.83008,0.00898743],290.359,1,0,[-0.535961,0.126635],"","",true,false],
	["Land_Razorwire_F",[10.2588,-7.70117,0.235596],248.08,1,0,[-1.5003,1.59138],"","",true,false],
	["Land_CzechHedgehog_01_F",[6.2666,-12.1563,0],44.3504,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-2.4082,-15.168,0],224.756,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[2.38281,-15.2656,0],189.937,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[10.9707,-12.8398,0.00123596],264.907,1,0,[0,0],"","",true,false],
	["Land_Mil_WallBig_4m_F",[-1.85254,17.8164,-0.0611267],148.462,1,0,[0,-0],"","",true,false],
	["Land_BagBunker_Small_F",[-13.0869,-22.1367,-0.000396729],44.5327,1,0,[0.0486378,-0.702468],"","",true,false],
	["Land_PortableLight_double_F",[-11.6865,-24.9375,0.00167847],43.2671,1,0,[0,0],"","",true,false],
	["Land_Mil_WallBig_debris_F",[32.4404,8.79102,0.0366058],208.604,1,0,[2.80282,0.919554],"","",true,false],
	["Land_Razorwire_F",[35.8213,8.22656,0.22876],249.421,1,0,[1.52143,2.52784],"","",true,false],
	["Snake_random_F",[35.8389,34.7891,0.0088501],63.3307,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpostAA_27", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_27", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_27", "objects", _objects] call DICT_fnc_set;

_center = [5864.93, 20110.1];
_objects = [
	["Land_Razorwire_F",[-6.09717,0.666016,-0.342422],116.724,1,0,[3.52641,-2.75327],"","",true,false],
	["Land_BagFence_Long_F",[-11.146,-4.04102,0.10791],195.543,1,0,[4.53752,3.88715],"","",true,false],
	["Land_BagFence_Long_F",[-12.8989,-5.34766,-0.105988],107.27,1,0,[4.07172,-4.32381],"","",true,false],
	["Land_BagFence_Long_F",[-7.71973,-13.748,0.00663757],15.7372,1,0,[-0.0283854,0.100733],"","",true,false],
	["Land_BagFence_Long_F",[-13.1001,-11.3262,0.0795288],195.492,1,0,[0.11612,2.72576],"","",true,false],
	["Land_CzechHedgehog_01_F",[-10.6309,-14.7188,0],324.454,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[21.1626,3.78125,0.281189],189.454,1,0,[8.39056,2.26769],"","",true,false],
	["Land_PortableLight_double_F",[-10.897,-17.0449,-0.00491333],294.762,1,0,[0,0],"","",true,false],
	["Land_Pallet_vertical_F",[18.9102,-12.2285,-0.615768],329.032,1,0,[85.9978,-98.8847],"","",true,false],
	["Land_Pallet_vertical_F",[19.9282,-11.0469,-0.614944],328.26,1,0,[86.0189,-100.067],"","",true,false],
	["Land_BagFence_Long_F",[-22.228,-8.47656,-0.0905609],19.4575,1,0,[-4.70126,-3.85727],"","",true,false],
	["Land_BagFence_Long_F",[20.2695,-12.5547,0.0396729],306.77,1,0,[-3.70788,1.51647],"","",true,false],
	["Land_BagFence_Long_F",[20.334,-12.6035,0.764069],127.514,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-23.2314,4.25391,0.557022],259.284,1,0,[-0.0231409,4.8135],"","",true,false],
	["Land_Razorwire_F",[15.1343,-20.3633,-0.0245209],312.889,1,0,[-3.30435,-0.257598],"","",true,false],
	["Land_Razorwire_F",[27.5737,-1.00781,1.15556],227.828,1,0,[2.80929,9.12603],"","",true,false],
	["Land_CzechHedgehog_01_F",[-25.8647,-12.0547,0],30.7757,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-27.3154,-14.4004,0.00749207],80.7161,1,0,[0,0],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[-46.8369,13.5039,7.62939e-005],161.578,1,0,[0.337255,0.531698],"","",true,false],
	["Snake_random_F",[37.1914,39.1094,0.0085144],121.595,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-60.5854,-4.46875,-0.293839],5.31356,1,0,[0.212232,-2.28072],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[35.0903,49.3457,-1.52588e-005],110.396,1,0,[0.0248798,-0.723996],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[65.7036,5.50586,0.00325012],339.481,1,0,[-3.70643,0.980151],"","",true,false],
	["Land_Razorwire_F",[79.2139,-23.3789,0.106049],297.015,1,0,[-9.74601,0.72765],"","",true,false],
	["Land_Razorwire_F",[-91.9282,8.46094,0.353668],307.692,1,0,[-4.62295,2.98236],"","",true,false],
	["Land_Razorwire_F",[-16.9229,93.1191,0.42836],316.544,1,0,[-0.908058,3.70137],"","",true,false],
	["Land_Razorwire_F",[-1.63184,108.117,0.976974],245.838,1,0,[1.37964,6.05657],"","",true,false]
];
[_dict, "AS_resource_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_5", "objects", _objects] call DICT_fnc_set;

_center = [4434.89, 20692.1];
_objects = [
	["Land_BagFence_Long_F",[1.63086,2.13672,-0.017395],39.6496,1,0,[-3.25658,-0.615612],"","",true,false],
	["Land_BagFence_Long_F",[3.76123,0.134766,0.00872803],45.6166,1,0,[-2.21445,0.0305025],"","",true,false],
	["Land_BagFence_Long_F",[-0.657715,4.07031,0.0215759],222.683,1,0,[3.21955,0.787262],"","",true,false],
	["Land_Razorwire_F",[4.62549,1.36523,-0.0158691],218.879,1,0,[11.2294,-0.355132],"","",true,false],
	["Land_BagFence_Short_F",[-1.77686,5.85547,0.0472412],265.121,1,0,[1.84666,2.75373],"","",true,false],
	["Land_HBarrierTower_F",[4.46387,-4.89648,-0.00363159],242.546,1,0,[2.12744,0.615955],"","",true,false],
	["Land_Razorwire_F",[11.2876,-11.7422,-0.116913],258.732,1,0,[0.959752,-1.04791],"","",true,false],
	["Land_Razorwire_F",[9.87354,-20.6348,2.23615],287.337,1,0,[-1.64097,17.0525],"","",true,false],
	["Land_Razorwire_F",[-30.9648,6.28516,-0.662018],107.159,1,0,[0.500492,-5.50509],"","",true,false],
	["Land_Razorwire_F",[-30.0234,11.4844,0.385254],275.181,1,0,[-1.11344,1.27944],"","",true,false],
	["Snake_random_F",[11.2832,48.6113,0.00848389],145.707,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-17.1416,-67.4648,0.0453796],331.425,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V1_F",[-36.1855,-60.1504,0],118.212,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-19.5386,-71.9727,1.55698],114.389,1,0,[2.89595,11.0719],"","",true,false],
	["Land_Razorwire_F",[-46.0493,-61.0137,1.37573],113.392,1,0,[1.20117,10.5534],"","",true,false],
	["Land_CzechHedgehog_01_F",[-22.5571,-79.6172,0.039856],339.488,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-28.126,-78.252,-0.638763],201.664,1,0,[-7.29674,-5.72362],"","",true,false],
	["Land_CzechHedgehog_01_F",[-35.7109,-75.0996,0],38.7265,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-40.1904,-73.4238,0.603271],201.692,1,0,[-11.0656,4.59735],"","",true,false],
	["Land_CzechHedgehog_01_F",[-48.1362,-69.1309,0],38.7265,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-23.4917,-84.9902,0.670593],95.9408,1,0,[-1.05112,5.63289],"","",true,false],
	["Land_Razorwire_F",[-19.1172,-96.4121,-0.0430603],39.3143,1,0,[2.16582,-0.596015],"","",true,false],
	["Land_Razorwire_F",[-9.07617,-105.127,0.0071106],41.3261,1,0,[0.869057,0.0524336],"","",true,false],
	["Land_Razorwire_F",[-43.9316,-101.422,-0.310364],25.8444,1,0,[0.994249,-2.40295],"","",true,false],
	["Land_Razorwire_F",[-61.1172,-92.6992,-0.153534],26.49,1,0,[2.52486,-1.47282],"","",true,false],
	["Land_PortableLight_double_F",[3.12305,-111.094,0.000701904],261.563,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-2.74707,-112.117,0],324.454,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-29.4023,-109.643,-0.15155],39.849,1,0,[2.20097,-1.44593],"","",true,false],
	["Land_Razorwire_F",[-70.7773,-89.1309,0.0235596],200.689,1,0,[-7.99302,-0.31984],"","",true,false],
	["Land_CzechHedgehog_01_F",[-23.2119,-115.535,0],324.454,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-25.8599,-116.559,0.00875854],79.1497,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpostAA_23", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_23", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_23", "objects", _objects] call DICT_fnc_set;

_center = [7475.4, 21568.3];
_objects = [
	["Land_BagFence_Long_F",[1.70166,-0.09375,-0.107666],267.325,1,0,[2.0221,-4.29259],"","",true,false],
	["Land_BagFence_End_F",[-0.697754,-1.93359,0.0263824],174.464,1,0,[-4.38765,-1.80519],"","",true,false],
	["Land_BagFence_Long_F",[1.73584,-0.380859,0.0721283],84.1827,1,0,[0.971336,2.61623],"","",true,false],
	["Land_BagFence_Corner_F",[1.52002,1.76953,-0.00765991],354.769,1,0,[2.62602,-0.944501],"","",true,false],
	["Land_BagFence_End_F",[-1.19238,1.28516,-0.0443115],0,1,0,[0,0.0395504],"","",true,false],
	["Land_BagFence_Long_F",[15.4443,2.93164,0.072937],354.959,1,0,[-6.13059,2.3934],"","",true,false],
	["Land_Razorwire_F",[-18.5444,1.2207,0.440613],8.75369,1,0,[-3.94484,3.56816],"","",true,false],
	["Land_BagFence_Long_F",[18.1978,2.39063,-0.00541687],26.2143,1,0,[-7.82187,-0.270993],"","",true,false],
	["Land_PortableLight_double_F",[18.0303,-8.79297,0.0139923],207.739,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[20.4331,1.54297,0],324.454,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[23.4619,-2.58008,0],80.9657,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[24.7876,-5.15234,-0.0516815],239.416,1,0,[15.7767,-6.25906],"","",true,false],
	["Land_Razorwire_F",[-33.752,0.333984,1.12433],345.219,1,0,[-3.83547,8.72996],"","",true,false],
	["Land_CzechHedgehog_01_F",[26.062,-25.7813,0],80.9657,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[29.0117,-27.3379,-0.103683],299.543,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-40.3486,-1.36719,-0.0842896],145.144,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[5.3252,-42.0527,0.303314],7.16147,1,0,[-1.10029,2.01692],"","",true,false],
	["Land_CzechHedgehog_01_F",[12.709,-42.5469,-0.0400543],0.019972,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-17.9043,-42.1289,0.052597],355.001,1,0,[14.5533,-0.904759],"","",true,false],
	["Land_Razorwire_F",[17.1958,-42.1777,0.636749],355.896,1,0,[-5.65483,5.24422],"","",true,false],
	["Snake_random_F",[28.6641,-36.8066,0.00874329],130.709,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-48.6162,-4.82617,1.58241],335.153,1,0,[1.43798,12.7106],"","",true,false],
	["Snake_random_F",[31.3452,-36.2988,0.00827026],269.995,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-46.5083,12.8574,0.00883484],35.9457,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[25.0024,-41.7656,-0.0577087],341.182,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[27.2817,-41.7598,0.0374756],270.565,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-32.3018,-43.7168,0.659485],354.601,1,0,[28.3621,5.73475],"","",true,false],
	["Land_Razorwire_F",[-57.7876,-14.4434,1.30699],289.686,1,0,[0.860576,11.5096],"","",true,false],
	["Land_CzechHedgehog_01_F",[-59.9771,-21.0977,-0.187256],118.911,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-48.5957,-42.9375,0.334015],8.75281,1,0,[-0.220872,1.43427],"","",true,false],
	["Land_Razorwire_F",[-64.0591,-34.4199,0.263474],56.1217,1,0,[-3.67547,1.91829],"","",true,false]
];
[_dict, "AS_powerplant_10", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_10", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_10", "objects", _objects] call DICT_fnc_set;

_center = [9181.42, 21644.9];
_objects = [
	["Land_PortableLight_double_F",[-19.2441,-4.26758,-0.00635815],282.918,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[22.6055,23.168,0.0137291],146.44,1,0,[0.338315,-0.0420856],"","",true,false],
	["Land_Razorwire_F",[30.6328,29.002,0.144766],144.06,1,0,[0.453333,1.27521],"","",true,false],
	["Land_Razorwire_F",[-44.0146,2.93359,0.0596113],283.141,1,0,[-0.401428,0.377032],"","",true,false],
	["Land_Razorwire_F",[-44.8643,-2.53906,-0.133504],95.7467,1,0,[0.419082,-1.10931],"","",true,false],
	["Land_CzechHedgehog_01_F",[34.3643,31.0977,-0.00165272],185.782,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[38.5674,28.0293,-0.0774899],51.6407,1,0,[0.182026,-0.631284],"","",true,false],
	["Land_Razorwire_F",[-45.835,-11.5449,-0.116808],95.753,1,0,[0.0995364,-0.987881],"","",true,false],
	["Land_Razorwire_F",[43.5615,21.166,-0.145204],54.9409,1,0,[0.862267,-1.16503],"","",true,false],
	["Snake_random_F",[-49.3984,-8.37109,0],133.948,1,0,[1.1291,-0.29088],"","",true,false],
	["Land_PortableLight_double_F",[21.1768,45.9902,0.00201225],261.803,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[48.9736,13.8984,-0.206748],54.9349,1,0,[0.511303,-1.66507],"","",true,false],
	["Land_Razorwire_F",[54.04,6.83008,-0.22529],54.9241,1,0,[0.929979,-1.86574],"","",true,false],
	["Land_Razorwire_F",[2.49609,-57.4082,-0.299526],349.02,1,0,[-2.40987,-2.79994],"","",true,false],
	["Land_CzechHedgehog_01_F",[10.2178,-56.7617,0],216.799,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[16.6426,54.0977,-0.0721302],265.724,1,0,[0.727604,-0.513678],"","",true,false],
	["Land_CzechHedgehog_01_F",[-2.14648,-58.6348,0],216.799,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[58.9473,-0.0859375,-0.120888],54.9505,1,0,[0.0177192,-1.03875],"","",true,false],
	["Land_Razorwire_F",[12.9932,-60.5879,-0.162382],57.6695,1,0,[0.308183,-1.37018],"","",true,false],
	["Land_CzechHedgehog_01_F",[16.1582,62.3066,0],341.182,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[63.9014,-7.19336,-0.0836983],54.9512,1,0,[0.236986,-0.726179],"","",true,false],
	["Land_PortableLight_double_F",[15.4336,64.5078,-0.00160694],146.747,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[16.8105,-67.1895,0.00230408],216.799,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V1_F",[3.91504,-68.1523,0.00230408],329.439,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[69.0244,-14.2617,-0.0917587],54.9553,1,0,[-0.251152,-0.756883],"","",true,false],
	["Land_CzechHedgehog_01_F",[24.8564,68.9336,0],289.268,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[22.5537,70.1582,-0.000720024],137.118,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[16.04,-70.8125,-0.00148392],108.925,1,0,[0.652258,-0.0184343],"","",true,false],
	["Land_Razorwire_F",[74.0391,-21.3652,-0.169657],54.9612,1,0,[-0.733473,-1.44477],"","",true,false],
	["Land_CzechHedgehog_01_F",[13.2002,-78.3027,0.00230408],216.799,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[79.0146,-28.4414,-0.209356],54.9956,1,0,[-1.90283,-1.65093],"","",true,false],
	["Land_CzechHedgehog_01_F",[83.8301,-35.6758,0],216.799,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[88.8164,-42.3574,-0.180019],54.9677,1,0,[-1.01557,-1.71315],"","",true,false],
	["Land_Razorwire_F",[95.8857,-52.1621,0.0862446],230.488,1,0,[0.368788,0.686008],"","",true,false],
	["Land_Razorwire_F",[101.357,-58.877,0.048418],230.487,1,0,[0.125862,0.391432],"","",true,false],
	["Land_Razorwire_F",[107.001,-65.7012,0.0678692],230.484,1,0,[-0.433752,0.554722],"","",true,false],
	["Land_Razorwire_F",[112.539,-72.6016,0.00940704],230.487,1,0,[0.391418,-0.125853],"","",true,false],
	["Land_Razorwire_F",[119.78,-77.4883,-0.0598946],206.921,1,0,[-0.0991411,-0.47882],"","",true,false],
	["Land_CzechHedgehog_01_F",[123.915,-78.7695,0],135.015,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[131.447,-79.9922,-0.0810699],189.425,1,0,[-0.276823,-0.665341],"","",true,false],
	["Land_Razorwire_F",[141.317,-68.0293,0.0279503],2.84234,1,0,[0.0613693,0.308613],"","",true,false],
	["Land_Razorwire_F",[140.318,-80.2422,-0.134237],176.254,1,0,[-0.375029,-1.04711],"","",true,false],
	["Land_CzechHedgehog_01_F",[148.881,-68.5195,0],341.182,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[153.316,-62.9668,0.71545],299.433,1,0,[0.262334,5.13403],"","",true,false],
	["Land_CzechHedgehog_01_F",[145.508,-80.0547,0],85.6714,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[152.874,-68.7422,-0.000551224],227.781,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[143.963,-87.9883,-0.00742722],286.022,1,0,[0.335274,-0.061812],"","",true,false],
	["Land_PortableLight_double_F",[149.034,-79.7949,-0.000450134],355.904,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Large_F",[-150.163,-212.754,0.00901794],51.8038,1,0,[-0.871493,-1.35536],"","",true,false],
	["Land_BagFence_Long_F",[-161.52,-311.918,-0.00840378],319.671,1,0,[-0.869845,0.0373006],"","",true,false],
	["Land_BagFence_Long_F",[-163.79,-313.582,0.016674],326.698,1,0,[-1.02142,0.67105],"","",true,false],
	["Land_BagFence_Long_F",[-166.167,-315.166,0.0187397],326.704,1,0,[-0.237023,0.61275],"","",true,false],
	["Land_BagFence_Long_F",[-168.544,-316.734,0.0015583],326.702,1,0,[-0.57246,0.10203],"","",true,false],
	["Land_HBarrierTower_F",[-174.192,-317.553,0.00211906],39.1009,1,0,[-0.722222,-0.685694],"","",true,false],
	["Land_Razorwire_F",[-193.487,-307.83,0.195227],230.523,1,0,[1.91813,1.4873],"","",true,false],
	["Land_BagFence_Long_F",[-180.484,-317.189,-0.00545883],201.22,1,0,[1.09575,0.343313],"","",true,false],
	["Land_BagFence_Long_F",[-183.17,-316.539,-0.084259],185.727,1,0,[1.48289,-3.30328],"","",true,false],
	["Land_BagFence_Long_F",[-188.104,-314.209,0.00877571],241.565,1,0,[3.96426,0.108699],"","",true,false],
	["Land_Razorwire_F",[-190.594,-311.889,-0.101755],62.7497,1,0,[-1.38466,-1.52055],"","",true,false],
	["Land_BagFence_Long_F",[-185.989,-315.963,-0.0752506],196.986,1,0,[2.09942,-2.95108],"","",true,false],
	["Land_Razorwire_F",[-185.325,-317.576,0.357725],9.17225,1,0,[-1.67881,3.20847],"","",true,false]
];
[_dict, "AS_airfield_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield_5", "objects", _objects] call DICT_fnc_set;

_center = [9688.67, 22286.6];
_objects = [
	["Land_CzechHedgehog_01_F",[4.59863,-1.21289,0],30.2809,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[8.58496,-3.06445,0],72.8079,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V1_F",[-17.9365,0.503906,0],87.5193,1,0,[0,0],"","",true,false],
	["Land_HBarrier_3_F",[19.7012,13.6797,0.00744367],0,1,0,[0,0.381552],"","",true,false],
	["Land_Razorwire_F",[0.733398,29.0273,-0.169162],95.0475,1,0,[1.11046,-1.28218],"","",true,false],
	["Land_HBarrier_1_F",[30.1953,14.3867,0.000125408],87.6974,1,0,[-0.552496,-0.436578],"","",true,false],
	["Land_HBarrier_1_F",[2.13867,33.8223,0.000644684],12.1021,1,0,[-1.28002,-1.68097],"","",true,false],
	["Land_HBarrier_1_F",[30.1748,15.541,0.000123501],89.6591,1,0,[-0.537228,-0.455234],"","",true,false],
	["Land_HBarrier_1_F",[2.57715,35.1465,0.000721455],291.446,1,0,[-1.86634,0.990138],"","",true,false],
	["Land_HBarrier_3_F",[29.8516,22.2773,-0.00538635],251.331,1,0,[0.554357,-0.268156],"","",true,false],
	["Land_HBarrier_1_F",[28.8105,28.3496,0.000104904],54.5545,1,0,[-0.497783,0.354356],"","",true,false],
	["Land_HBarrier_1_F",[28.0527,29.3066,0.00100827],50.9655,1,0,[-2.51513,0.172081],"","",true,false],
	["Snake_random_F",[-26.7061,-32.5859,0.00821066],241.884,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[14.5996,41.9141,-0.138982],177.421,1,0,[-0.280312,-1.13424],"","",true,false],
	["Land_HBarrier_1_F",[19.5518,39.4531,0.00114274],22.1519,1,0,[-2.34908,1.51822],"","",true,false],
	["Land_HBarrier_1_F",[20.8105,39.2266,0.00115871],27.0825,1,0,[-2.47069,1.31071],"","",true,false],
	["Snake_random_F",[-38.8027,-22.5566,0.00835872],261.621,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-46.2012,-11.5332,0.101393],286.451,1,0,[-2.98984,0.151917],"","",true,false],
	["Land_Razorwire_F",[-40.291,-28.0098,-0.247641],21.4123,1,0,[-3.08829,-1.95119],"","",true,false],
	["Land_CzechHedgehog_01_F",[-47.415,-16.2031,0.000993729],327.428,1,0,[0,0],"","",true,false],
	["Snake_random_F",[15.1289,-50.3359,0.00848532],120.716,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-45.666,-26.6914,0],341.182,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-50.5225,-17.3105,0.00193548],63.8359,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-48.998,-27.1523,0.00440407],94.0022,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[-37.3262,-55.0547,0.0275497],106.3,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[62.0137,-22.2637,-0.911627],68.0432,1,0,[2.71623,-7.80153],"","",true,false],
	["Rabbit_F",[-57.1338,-37.2617,0.0182631],225.179,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[64.8877,-29.3984,0],74.8941,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[55.6123,-44.834,-0.63715],322.289,1,0,[-6.67039,-5.52667],"","",true,false],
	["Land_CzechHedgehog_01_F",[61.5811,-39.8672,0],341.182,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[69.2432,-31.5352,-0.00595474],300.209,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[65.9648,-40.918,-0.00649929],285.582,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_19", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_19", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_19", "objects", _objects] call DICT_fnc_set;

_center = [9856.83, 19348.9];
_objects = [
	["Land_HBarrierTower_F",[-1.0166,-10.5664,0.0345306],31.3492,1,0,[12.5291,6.5296],"","",true,false],
	["Land_CzechHedgehog_01_F",[-10.082,44.9844,0],327.428,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-10.585,46.916,0.0118256],111.396,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-46.8896,17.0938,0.0085907],314.831,1,0,[0,0],"","",true,false],
	["Snake_random_F",[36.751,-41.0684,0.00852966],352.425,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-9.5,56.6406,0],86.8172,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-11.0723,57.9023,0.0128937],92.7454,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-9.66992,64.3965,-0.305222],89.6964,1,0,[4.86821,-3.0787],"","",true,false],
	["Snake_random_F",[-34.0771,-52.8125,0.00920105],269.59,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-7.12207,77.3789,-0.461899],102.9,1,0,[5.78091,-2.35368],"","",true,false],
	["Land_PortableLight_double_F",[81.8145,-6.01953,0.00352478],26.1345,1,0,[0,0],"","",true,false],
	["Land_HBarrier_3_F",[85.1523,-12.5547,-0.0410919],273.966,1,0,[-4.19672,-2.35778],"","",true,false],
	["Land_HBarrier_3_F",[89.1582,-14.1016,0.107788],182.58,1,0,[0,0],"","",true,false],
	["Land_HBarrier_Big_F",[92.8047,17.9297,0.302261],112.462,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Tower_V3_F",[95.6602,-9.04492,0],177.072,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[69.3105,76.2754,0.00512695],89.1082,1,0,[0,0],"","",true,false],
	["Land_HBarrier_Big_F",[106.188,-13.6563,-0.500229],343.113,1,0,[0.145448,-0.0441547],"","",true,false],
	["Land_Razorwire_F",[111.646,27.1055,0.195679],353.037,1,0,[-2.51013,0.229475],"","",true,false],
	["Land_PortableLight_double_F",[124.61,7.71289,0],299.219,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[127.893,3.28125,-0.0892029],266.167,1,0,[9.36737,-0.633265],"","",true,false]
];
[_dict, "AS_base_9", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_9", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_9", "objects", _objects] call DICT_fnc_set;

_center = [14229.2, 21260.2];
_objects = [
	["Land_HBarrier_1_F",[-1.63965,3.78906,0.00296021],122.588,1,0,[-3.84224,2.88723],"","",true,false],
	["Land_HBarrier_1_F",[-0.923828,4.8418,0.00296021],122.588,1,0,[-3.84224,2.88723],"","",true,false],
	["Land_HBarrier_1_F",[0.0195313,5.77148,0.00183868],332.72,1,0,[4.76761,-0.56747],"","",true,false],
	["Land_HBarrier_1_F",[6.13379,0.199219,0.00037384],219.335,1,0,[1.97301,-1.4442],"","",true,false],
	["Land_HBarrier_1_F",[1.30371,6.07227,0.0018692],358.654,1,0,[4.53612,1.57908],"","",true,false],
	["Land_HBarrier_1_F",[7.20703,-0.78125,0.000831604],127.371,1,0,[-1.51093,-1.92242],"","",true,false],
	["Land_Razorwire_F",[-12.4902,6.14453,-0.839432],202.619,1,0,[3.35138,-7.41572],"","",true,false],
	["Land_Razorwire_F",[-24.8047,8.3457,0.428841],359.791,1,0,[1.0042,3.04975],"","",true,false],
	["Land_Razorwire_F",[-33.1836,4.30664,0.126984],326.969,1,0,[3.70819,1.5066],"","",true,false],
	["Land_CzechHedgehog_01_F",[-38.7451,3.0293,0],120.969,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-38.377,-11.1973,0.136719],239.535,1,0,[5.57819,0.608048],"","",true,false],
	["Land_HBarrier_1_F",[-37.5596,-18.0566,-0.291],293.779,1,0,[7.04251,6.67768],"","",true,false],
	["Land_CzechHedgehog_01_F",[-41.6133,-4.83594,0],148.098,1,0,[0,-0],"","",true,false],
	["Land_HBarrier_1_F",[-37.9961,-19.1035,-0.390991],293.86,1,0,[7.03315,6.68756],"","",true,false],
	["Land_HBarrier_1_F",[-38.3633,-20.0527,-0.479675],293.191,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-26.2598,34.8379,0.00778961],322.221,1,0,[0,0],"","",true,false],
	["Land_HBarrier_1_F",[18.4346,-43.6816,-0.294182],346.551,1,0,[-1.98475,-6.95303],"","",true,false],
	["Land_HBarrier_1_F",[19.4678,-43.248,-0.294891],153.966,1,0,[3.45608,6.36061],"","",true,false],
	["Land_HBarrier_1_F",[20.4688,-42.834,-0.295013],145.18,1,0,[4.38668,5.76383],"","",true,false],
	["Land_Razorwire_F",[17.4756,-46.793,-2.01601],127.305,1,0,[2.71658,-17.5294],"","",true,false],
	["Snake_random_F",[-19.9902,48.6797,0.00819397],359.193,1,0,[0,0],"","",true,false],
	["Snake_random_F",[37.3398,37.5176,0.00858307],152.795,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[-27.3604,46.7715,-0.0232086],348.333,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[12.9824,-55.1699,0.0972672],100.489,1,0,[1.00331,2.98001],"","",true,false],
	["Land_Razorwire_F",[-44.3164,-42.3379,-0.678207],209.551,1,0,[0.0947984,-7.55794],"","",true,false],
	["Land_HBarrier_1_F",[-50.4355,-39.2031,0.000274658],23.4773,1,0,[1.77874,1.27231],"","",true,false],
	["Land_HBarrier_1_F",[-51.5928,-38.7617,0.000244141],10.4921,1,0,[2.01891,0.840105],"","",true,false],
	["Land_Razorwire_F",[6.75195,-68.2637,-0.365234],313.771,1,0,[6.66582,-3.31452],"","",true,false],
	["Land_Razorwire_F",[-6.07129,-83.3438,-1.30132],293.807,1,0,[0.598521,-12.5568],"","",true,false],
	["Land_HBarrierTower_F",[-90.5898,18.9883,-0.548965],181.701,1,0,[15.6204,1.03117],"","",true,false],
	["Land_Razorwire_F",[-19.3994,-94.6973,-0.337036],281.812,1,0,[1.15795,-2.17621],"","",true,false],
	["Rabbit_F",[-89.6885,-34.2969,0.0108948],73.9875,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-40.792,-88.4063,-0.378059],249.917,1,0,[-1.69012,-3.28264],"","",true,false],
	["Land_BagBunker_Large_F",[-93.6699,-26.7813,-0.0195847],38.0149,1,0,[2.12889,2.73123],"","",true,false],
	["Land_CzechHedgehog_01_F",[-37.8057,-92.502,0],4.40233,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-20.3721,-99.6992,0],195.959,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-31.3408,-98,-0.249039],215.89,1,0,[-3.01298,-2.08656],"","",true,false],
	["Rabbit_F",[-35.1582,96.9434,0.00224304],301.291,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-21.1084,-102.236,0.0100861],3.5626,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-27.9736,-100.801,0],153.214,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-27.7852,-102.531,0.0231171],339.113,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[-119.888,5.88867,-0.0628052],112.152,1,0,[7.5794,3.75812],"","",true,false],
	["Rabbit_F",[-32.8662,-126.57,0.016922],89.9467,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-150.198,37.5605,0.00946045],42.1426,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_6", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_6", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_6", "objects", _objects] call DICT_fnc_set;

_center = [14293.3, 18873.1];
_objects = [
	["Land_Shoot_House_Wall_F",[-11.541,-5.60547,-0.587139],229.795,1,0,[-1.15697,-0.422292],"","",true,false],
	["Land_Shoot_House_Wall_F",[-11.6436,-5.67969,-3.8147e-006],229.785,1,0,[0.0213561,-0.0180566],"","",true,false],
	["Land_Shoot_House_Wall_F",[-5.83398,-12.6328,-3.8147e-006],229.785,1,0,[0.0213561,-0.0180566],"","",true,false],
	["Land_BagFence_Corner_F",[-15.1025,-3.96484,0.00285339],229.239,1,0,[0.0211828,-0.0182595],"","",true,false],
	["Land_Shoot_House_Wall_F",[-3.63672,-15.248,-3.8147e-006],229.785,1,0,[0.0213561,-0.0180566],"","",true,false],
	["Land_Shoot_House_Wall_F",[-1.79102,-17.4785,-3.8147e-006],229.785,1,0,[0.0213561,-0.0180566],"","",true,false],
	["Land_Shoot_House_Wall_F",[2.17285,-22.2715,-3.8147e-006],229.785,1,0,[0.0213561,-0.0180566],"","",true,false],
	["Land_Shoot_House_Wall_F",[4.08301,-24.5156,-3.8147e-006],229.785,1,0,[0.0213561,-0.0180566],"","",true,false],
	["Land_CzechHedgehog_01_F",[-27.6328,-15.6523,0],199.714,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-28.3877,-14.2676,0.00337982],57.7712,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-34.7676,-7.63672,0],280.262,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[30.9873,-23.4375,0.103073],160.826,1,0,[-1.3895,0.887852],"","",true,false],
	["Snake_random_F",[-39.4414,-30.998,0.00845718],335.272,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-50.249,-0.109375,0.00835037],212.557,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-35.6523,-38.0859,0.0158195],277.48,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-19.0576,48.6816,0.00838852],337.9,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-44.0859,-31.2129,0.306915],132.804,1,0,[-1.03122,2.68726],"","",true,false],
	["Land_Razorwire_F",[-40.2568,-37.6133,0.1693],179.02,1,0,[-1.42613,1.47624],"","",true,false],
	["Land_Razorwire_F",[-52.0127,30.5449,-0.162926],245.272,1,0,[-4.22128,-1.50043],"","",true,false],
	["Land_CzechHedgehog_01_F",[-49.5088,-37.7031,0],197.23,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-51.9912,-39.2324,0.00802994],41.18,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[86.2305,13.8125,-0.191677],48.0881,1,0,[1.42663,-1.38353],"","",true,false],
	["Land_CzechHedgehog_01_F",[92.2451,7.38867,0],258.892,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[94.6201,19.623,-0.254871],51.339,1,0,[-0.691625,-2.08724],"","",true,false],
	["Land_CzechHedgehog_01_F",[99.709,12.9785,-0.00329971],10.5716,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-37.7354,98.5,-0.30051],136.952,1,0,[3.43571,-2.58286],"","",true,false],
	["Land_CzechHedgehog_01_F",[87.4072,94.3203,0],182.955,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[82.6885,99.8066,-0.0828362],49.6386,1,0,[-0.212728,-0.721552],"","",true,false],
	["Land_Razorwire_F",[90.9443,97.1816,-0.415039],321.803,1,0,[0.528075,-3.52497],"","",true,false],
	["Land_Razorwire_F",[121.653,73.2656,-0.00377655],49.0876,1,0,[1.45834,0.0498914],"","",true,false],
	["Land_Razorwire_F",[21.3047,157.084,-0.158512],317.625,1,0,[-2.63217,-1.52665],"","",true,false]
];
[_dict, "AS_factory_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_1", "objects", _objects] call DICT_fnc_set;

_center = [12724.5, 16293.2];
_objects = [
	["Land_CzechHedgehog_01_F",[-1.94336,-6.01563,0],295.328,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[0.639648,-9.27344,0.22327],51.7802,1,0,[-1.52614,1.39522],"","",true,false],
	["Land_CzechHedgehog_01_F",[20.1445,-13.4561,0],197.23,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[21.7891,-12.6963,-0.000175476],225.042,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[13.2646,-22.8574,0],331.365,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[12.668,-25.4414,0.0206985],26.2242,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-48.9971,9.69043,0.00848389],357.761,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[52.0186,27.6787,0],268.263,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-17.4893,-57.4229,0.286045],48.9807,1,0,[0.107698,2.3352],"","",true,false],
	["Land_Razorwire_F",[-23.2178,-64.8057,0.209488],32.4757,1,0,[0.819878,1.69911],"","",true,false],
	["Land_Razorwire_F",[-103.999,3.59473,-0.161606],42.9508,1,0,[2.31627,-1.70405],"","",true,false],
	["Land_Razorwire_F",[-15.8457,106.764,0.221081],64.3675,1,0,[9.22506,0.78836],"","",true,false],
	["Land_CzechHedgehog_01_F",[79.5967,71.7354,0],268.263,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-17.8154,110.592,0],242.592,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-19.417,115.1,0.318283],255.822,1,0,[-8.67242,2.52162],"","",true,false],
	["Land_BagFence_Short_F",[-72.8477,107.072,-0.0932274],298.1,1,0,[-0.0224993,-5.82267],"","",true,false],
	["Land_BagFence_Long_F",[-74.7178,107.174,-0.00200653],208.816,1,0,[-5.8225,-0.050601],"","",true,false],
	["Land_Razorwire_F",[-19.1631,131.156,2.5014],105.858,1,0,[15.4403,20.3511],"","",true,false],
	["Land_Shoot_House_Wall_F",[-74.085,109.049,-0.550976],208.027,1,0,[0.175232,-0.166138],"","",true,false],
	["Land_Shoot_House_Wall_F",[-76.6729,110.359,0],208.027,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-69.7344,117.186,0],208.027,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-72.3457,118.537,0],208.027,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-83.5654,111.986,0.00524521],29.1654,1,0,[5.82209,0.0861835],"","",true,false],
	["Land_Shoot_House_Wall_F",[-82.1387,113.359,0],208.027,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-86.2275,113.334,-0.000137329],208.12,1,0,[-5.82268,0.020449],"","",true,false],
	["Land_Shoot_House_Wall_F",[-84.7754,114.725,-0.529972],208.027,1,0,[0.103624,-0.0316134],"","",true,false],
	["Land_Shoot_House_Wall_F",[-84.7256,114.779,0],208.027,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-77.0801,123.318,0],208.027,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-87.8105,116.309,-0.528042],208.027,1,0,[0.103624,-0.0316134],"","",true,false],
	["Land_Shoot_House_Wall_F",[-79.4912,124.592,-0.691639],208.047,1,0,[2.17447,0.465859],"","",true,false],
	["Land_Shoot_House_Wall_F",[-90.3516,117.775,0],208.027,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-83.3799,124.449,0],208.027,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-85.9941,125.867,-0.636932],208.056,1,0,[2.69022,0.308549],"","",true,false],
	["Land_Shoot_House_Wall_F",[-85.9893,125.869,0],208.027,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-147.685,44.8721,0.0450935],69.4487,1,0,[0.670697,-0.169656],"","",true,false],
	["Land_BagFence_Long_F",[-96.8633,119.139,0.00523758],29.1654,1,0,[5.82209,0.0861835],"","",true,false],
	["Land_Shoot_House_Wall_F",[-95.7256,120.725,-0.519791],208.027,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-88.7988,127.359,-0.631863],208.056,1,0,[3.01323,-0.298849],"","",true,false],
	["Land_BagFence_Short_F",[-98.0859,120.549,-0.0930214],297.295,1,0,[-0.104575,-5.82179],"","",true,false],
	["Land_BagFence_Corner_F",[-99.627,120.951,-0.000999451],207.538,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-96.6426,123.033,0],117.883,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-91.3477,128.801,0],208.027,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-93.9824,203.479,-0.466537],54.7301,1,0,[14.4907,-4.28921],"","",true,false],
	["Land_CzechHedgehog_01_F",[-253.768,284.9,0],77.7156,1,0,[0,0],"","",true,false]
];
[_dict, "AS_factory", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory", "objects", _objects] call DICT_fnc_set;

_center = [12813.6, 16684.9];
_objects = [
	["Land_CzechHedgehog_01_F",[10.9502,2.4082,0],351.847,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[12.6602,8.3125,0],237.304,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-15.3145,0.490234,-0.0213623],356.288,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-18.6641,-3.23633,0],351.847,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[22.0166,-5.71289,0.0144119],120.381,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-24.6924,-6.51758,0],344.928,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[2.86719,24.4941,-0.130966],301.5,1,0,[-1.81923,-1.56233],"","",true,false],
	["Land_Razorwire_F",[20.2979,21.6289,0.225945],266.798,1,0,[-5.38267,0.60762],"","",true,false],
	["Land_CzechHedgehog_01_F",[4.0625,-40.0996,0],158.127,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-0.0966797,-41.6211,0.00167084],213.716,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-20.7598,36.1563,0.00701141],123.971,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-28.1289,38.2168,0],213.432,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-8.27637,-47.8027,0],163.311,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-27.5654,44.8457,0],27.8532,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-24.1016,-50.4082,0.011116],7.16732,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[54.0547,-5.85352,0.769691],16.9775,1,0,[-5.90091,3.95452],"","",true,false],
	["Land_CzechHedgehog_01_F",[61.3691,-8.40625,0],351.847,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[7.9707,-67.877,0.258492],137.548,1,0,[-3.71084,2.04876],"","",true,false],
	["Land_CzechHedgehog_01_F",[73.625,-14.1426,0],341.699,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-2.19824,75.9746,0.796021],161.892,1,0,[3.27621,5.34405],"","",true,false],
	["Land_Razorwire_F",[76.752,-16.9746,1.40994],35.5214,1,0,[-2.80227,14.3995],"","",true,false],
	["Land_Razorwire_F",[19.918,84.4551,-0.463242],156.543,1,0,[7.46455,-3.42221],"","",true,false],
	["Land_Razorwire_F",[93.7119,8.76953,0.0957108],255.043,1,0,[2.5814,-0.690035],"","",true,false],
	["Land_Razorwire_F",[100.561,43.7773,0.434097],304.011,1,0,[7.917,3.89607],"","",true,false],
	["Land_Razorwire_F",[9.87109,-111.645,0.227478],357.266,1,0,[10.417,2.75939],"","",true,false],
	["Land_Razorwire_F",[-49.8545,-121.232,-0.27903],24.7858,1,0,[18.0676,-3.48185],"","",true,false],
	["Land_CzechHedgehog_01_F",[-55.0664,-119.332,0],295.328,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-71.2725,-111.414,0],295.328,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[115.611,66.4395,-0.164047],250.775,1,0,[0.870946,-1.67862],"","",true,false],
	["Land_Razorwire_F",[-79.1885,-107.74,-0.108932],24.1289,1,0,[8.69347,-1.05736],"","",true,false],
	["Land_PortableLight_double_F",[-55.7676,-121.246,0.0263977],41.311,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-71.9531,-112.938,0.0342636],7.16732,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_5", "objects", _objects] call DICT_fnc_set;

_center = [12467.1, 15196.6];
_objects = [
	["Land_CzechHedgehog_01_F",[-3.0459,2.16211,0.00132751],295.328,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-4.04199,4.99902,-0.000343323],299.997,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[0.0859375,16.6426,0.707428],330.299,1,0,[-2.85424,6.37522],"","",true,false],
	["Land_Razorwire_F",[11.5459,19.8359,0.729103],0.885303,1,0,[-13.007,6.04389],"","",true,false],
	["Land_CzechHedgehog_01_F",[17.7305,19.6631,-0.872955],223.248,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[21.0498,19.5527,0.881676],0.882893,1,0,[-13.0273,7.43555],"","",true,false],
	["Land_Razorwire_F",[11.6826,-31.752,0.219727],13.6925,1,0,[16.6869,1.15035],"","",true,false],
	["Snake_random_F",[28.3086,-22.2793,0.00839996],49.9642,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-41.5654,4.4502,-0.000511169],339.084,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[26.125,-35.2832,0],292.254,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-43.6387,-5.2373,0],295.328,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-46.1357,-0.902344,0.00590515],84.7721,1,0,[0,0],"","",true,false],
	["Snake_random_F",[24.5615,38.9307,0.00820923],3.0359,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[35.0283,-32.8271,0.0806503],337.962,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[32.8164,-37.5049,0.939476],90.5326,1,0,[-1.66687,5.84671],"","",true,false],
	["Land_Razorwire_F",[51.9717,-12.1455,0.0858154],103.729,1,0,[-11.1372,0.704433],"","",true,false],
	["Land_PortableLight_double_F",[46.8848,-27.9834,0.0341263],21.633,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[54.6582,2.98438,-0.388969],267.006,1,0,[0,0],"","",true,false],
	["Rabbit_F",[51.8193,-23.626,0.0357361],238.054,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[51.3779,-27.6963,0.934944],20.3566,1,0,[8.04224,7.34909],"","",true,false],
	["Snake_random_F",[-45.7188,43.4971,0.00892639],65.8427,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_11", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_11", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_11", "objects", _objects] call DICT_fnc_set;

_center = [14149.8, 16339.7];
_objects = [
	["Land_HBarrierWall6_F",[-18.9131,3.20996,0.00686455],287.179,1,0,[-0.0519532,0.943378],"","",true,false],
	["Land_HBarrier_1_F",[-16.624,8.20508,-0.200027],186.392,1,0,[0.936794,-0.125531],"","",true,false],
	["Land_HBarrier_1_F",[-18.1318,8.59473,-0.0854816],274.031,1,0,[0.164013,0.93083],"","",true,false],
	["Land_HBarrier_1_F",[-18.1621,8.59277,-0.199926],274.031,1,0,[0.164013,0.93083],"","",true,false],
	["Land_PortableLight_double_F",[15.7246,-13.0439,0.000547409],204.003,1,0,[0,0],"","",true,false],
	["Land_HBarrierWall6_F",[-17.1904,12.8311,0.00986481],278.147,1,0,[0.0968065,0.939836],"","",true,false],
	["Land_Razorwire_F",[-21.6973,2.4248,0.15365],284.997,1,0,[0.254316,1.41231],"","",true,false],
	["Land_Razorwire_F",[-19.7041,12.376,0.114975],277.853,1,0,[0.101624,0.939328],"","",true,false],
	["Land_PortableLight_double_F",[6.33594,-24.2373,0.00030899],57.756,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[22.6523,-21.0635,0.0621128],221.981,1,0,[-0.0853334,0.437182],"","",true,false],
	["Land_HBarrierTower_F",[-23.8662,-17.1846,0.000555038],104.382,1,0,[-0.181769,-0.51986],"","",true,false],
	["Land_Razorwire_F",[-30.2529,-13.9727,0.00319099],311.158,1,0,[-0.818868,-0.107531],"","",true,false],
	["Land_Razorwire_F",[-28.2236,-24.1318,0.030777],242.965,1,0,[0.206948,0.237023],"","",true,false],
	["Land_Razorwire_F",[13.1836,-40.752,0.0188789],310.269,1,0,[-0.3629,0.193301],"","",true,false],
	["Snake_random_F",[-47.7031,1.98828,0.00833511],127.029,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[2.69922,-49.0518,0],221.096,1,0,[0,0],"","",true,false],
	["Snake_random_F",[51.3447,1.42285,0.00836182],254.106,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-51.7568,0.342773,0.00832367],86.2181,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[19.0996,-64.7178,0],191.63,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[22.9287,65.0625,-0.0203075],172.839,1,0,[0.0570779,-0.160314],"","",true,false],
	["Land_Razorwire_F",[-41.75,-65.8682,0.164557],293.054,1,0,[-0.0870116,1.37409],"","",true,false],
	["Land_PortableLight_double_F",[48.6387,71.3516,-0.000844955],86.8786,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[52.4453,70.3262,0],295.328,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[39.7178,-84.3467,-0.000669479],216.893,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[49.0918,82.252,-0.000362396],80.1024,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[52.9717,83.0332,0],336.413,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[56.9609,85.3594,0.0529633],330.256,1,0,[-0.0474101,0.378593],"","",true,false]
];
[_dict, "AS_outpost_7", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_7", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_7", "objects", _objects] call DICT_fnc_set;

_center = [14609.5, 16782.1];
_objects = [
	["Land_BagFence_Long_F",[0.641602,-1.61914,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[2.69043,0.425781,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-1.41211,-3.67383,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[4.70898,2.46094,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-3.44238,-5.73828,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[6.68457,4.51367,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[-5.1123,-7.41797,-0.000999451],135.031,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[8.76758,6.54297,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[10.79,8.61719,-0.000999451],314.491,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-14.3223,17.1172,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-17.2979,14.3184,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-11.4766,19.9102,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-20.124,11.5098,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-16.4697,16,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-14.4209,18.0449,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-18.5234,13.9453,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-12.4023,20.0801,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-20.5537,11.8809,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-8.62012,22.7012,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-10.4268,22.1328,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[-22.2236,10.2012,-0.000999451],135.031,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-8.34375,24.1621,-0.000999451],314.181,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-5.79492,25.543,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-6.32129,26.2363,-0.000999451],314.491,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-26.8496,9.00195,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-4.85645,31.1055,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[-31.6289,4.26367,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Short_F",[-34.9297,0.931641,-0.000999451],312.748,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[0.151367,35.916,0],135.823,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-36.5791,-0.748047,-0.000999451],134.034,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-38.6387,-2.82422,-0.000999451],134.034,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[4.0791,39.793,0],135.092,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[6.92285,42.5938,0],135.092,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-24.6318,-43.4961,0.00838852],86.671,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-12.1963,74.0781,0.00840569],77.4081,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-57.8887,51.918,0.00263786],247.256,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-5.74121,79.5605,0.00838089],183.495,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-31.5811,78.1055,-0.018856],222.113,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-73.4023,-56.4434,0.00224495],21.3758,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-114.414,-22.8945,-0.00343132],314.985,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-97.1836,-74.4785,0.00870323],269.983,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-63.7363,133.061,0],208.626,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-134.438,60.9004,1.90735e-006],336.413,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-68.7305,132.85,0.0635757],177.802,1,0,[0.402283,0.519455],"","",true,false],
	["Land_Razorwire_F",[-134.848,69.2305,0.0102825],90.168,1,0,[0.151726,0.0770425],"","",true,false],
	["Land_CzechHedgehog_01_F",[-144.795,49.6602,0],208.626,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-53.3789,144.301,0],336.413,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-139.881,66.8496,-0.000120163],172.687,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-70.2549,139.129,0.0010643],89.9007,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-149.792,49.4531,0.0343037],177.802,1,0,[0.0117072,0.304963],"","",true,false],
	["Land_PortableLight_double_F",[-150.22,54.4004,1.14441e-005],89.9007,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-53.7861,152.625,-0.0374374],90.1657,1,0,[0.382948,-0.304081],"","",true,false],
	["Land_PortableLight_double_F",[-59.1084,149.904,0.000684738],172.687,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_resource_7", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_7", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_7", "objects", _objects] call DICT_fnc_set;

_center = [14497.8, 16278.7];
_objects = [
	["Land_BagFence_Long_F",[-24.8242,30.0068,12.6417],45.0374,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-21.9922,32.7402,12.4435],47.8103,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[-26.4736,31.6768,12.6011],224.675,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[-23.5801,34.4883,12.6262],224.675,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[-26.6445,35.0488,0.390854],138.615,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[15.1973,47.3955,0],157.921,1,0,[-0.344572,-0.849438],"","",true,false],
	["Snake_random_F",[50.4238,0.381836,0.00838661],143.531,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Tower_V1_No2_F",[191.106,46.1094,0],225.138,1,0,[-0.000260915,0.108352],"","",true,false],
	["Land_BagBunker_Large_F",[74.1338,-226.646,0.365028],314.027,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Large_F",[-188.998,-201.097,0.00243378],130.242,1,0,[-0.242129,-0.305292],"","",true,false],
	["Land_Cargo_Tower_V1_No1_F",[-207.035,-364.694,0],222.464,1,0,[-0.0603794,-0.15909],"","",true,false],
	["Land_BagBunker_Large_F",[326.197,340.339,0.000562668],136.439,1,0,[-0.0536252,0.0509963],"","",true,false],
	["Land_BagBunker_Large_F",[460.063,176.093,-0.00222206],311.353,1,0,[0.222502,0.0937962],"","",true,false],
	["Land_Cargo_Tower_V1_No3_F",[571.073,431.517,0],224.327,1,0,[0,0],"","",true,false]
];
[_dict, "AS_airfield_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield_3", "objects", _objects] call DICT_fnc_set;

_center = [15160.9, 17335.9];
_objects = [
	["Land_CzechHedgehog_01_F",[3.37305,5.01172,0],341.512,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[7.50098,3.56836,0],39.9242,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[8.30273,-0.458984,0],254.048,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-11.8262,23.4707,0],147.226,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-4.74707,30.8594,0],43.8518,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-57.7363,-14.4004,0],225.126,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-60.0615,-14.959,0.000621796],53.4339,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-66.2705,-6.47852,-0.000324249],340.772,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-41.8018,52.3574,0.00845718],357.04,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-67.1289,-8.5,-0.00108337],24.5297,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-59.1787,37.4297,0.00303268],263.724,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-56.0566,42.582,0.00845146],102.318,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[31.6318,62.3418,0.06427],222.218,1,0,[-0.46731,0.401055],"","",true,false],
	["Land_Razorwire_F",[-73.0781,-4.92188,-0.0983067],13.2596,1,0,[-0.568302,-0.918752],"","",true,false],
	["Land_CzechHedgehog_01_F",[25.1826,68.3438,0.000675201],81.3201,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-70.293,22.8105,0.00850677],36.6719,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[11.0586,76.5801,0.263657],169.364,1,0,[1.96633,2.19552],"","",true,false],
	["Land_PortableLight_double_F",[26.3652,72.4668,0.000118256],209.794,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[16.1816,76.8672,0],23.4482,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[19.8486,79.5039,0.00124931],236.144,1,0,[0,0],"","",true,false],
	["Rabbit_F",[8.58594,92.1094,0.0131035],195.26,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_4", "objects", _objects] call DICT_fnc_set;

_center = [15447, 15970.4];
_objects = [
	["Land_Razorwire_F",[-9.3916,-4.6377,-0.2201],342.371,1,0,[0.314874,-1.78303],"","",true,false],
	["Land_Razorwire_F",[-17.4648,-2.48633,0.110891],31.6158,1,0,[-0.285551,0.900627],"","",true,false],
	["Land_Razorwire_F",[-5.01465,-17.3555,-0.215566],339.583,1,0,[0.0847288,-1.74284],"","",true,false],
	["Land_Razorwire_F",[-12.959,-21.6338,0.0849929],327.564,1,0,[-0.826535,0.977984],"","",true,false],
	["Snake_random_F",[-40.6211,-29.043,0.00838995],69.9344,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[29.4668,-58.7412,-0.0301781],73.9526,1,0,[-1.26996,-0.270464],"","",true,false],
	["Land_Razorwire_F",[29.1982,68.6221,0.292844],255.307,1,0,[-2.84345,2.40323],"","",true,false],
	["Land_Razorwire_F",[26.4082,80.8008,0.207087],255.32,1,0,[-3.84622,1.87713],"","",true,false],
	["Land_Razorwire_F",[57.377,-100.43,-0.122935],83.7567,1,0,[0.608517,-0.757944],"","",true,false],
	["Land_CzechHedgehog_01_F",[-87.5635,-103.45,0],19.9057,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-91.0283,-103.478,0],339.893,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-122.931,-67.917,0.192911],182.3,1,0,[-5.50731,2.38774],"","",true,false],
	["Land_Razorwire_F",[-176.041,-109.813,0.23643],165.069,1,0,[-0.432969,1.93338],"","",true,false],
	["Land_Razorwire_F",[-181.542,-140.943,-0.408951],239.687,1,0,[-2.45541,-4.04334],"","",true,false],
	["Land_Razorwire_F",[-176.389,-154.091,-1.32823],257.765,1,0,[-0.829417,-11.393],"","",true,false]
];
[_dict, "AS_seaport_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_seaport_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_seaport_1", "objects", _objects] call DICT_fnc_set;

_center = [15479.5, 16240];
_objects = [
	["Snake_random_F",[-42.8271,26.5293,0],219.197,1,0,[-3.879,0.774876],"","",true,false],
	["Land_Razorwire_F",[54.5879,28.0811,0.107213],85.8339,1,0,[0.729887,0.559475],"","",true,false],
	["Land_Razorwire_F",[-144.204,1.20801,-2.86102e-006],83.7404,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-144.857,6.78516,0],6.33354,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-145.411,15.1748,0.00713539],87.8834,1,0,[0.00273307,0.0739514],"","",true,false],
	["Land_Razorwire_F",[-228.97,-6.23145,0.0197144],174.463,1,0,[0.463676,0.0320271],"","",true,false],
	["Land_CzechHedgehog_01_F",[-235.671,-6.60742,-0.0132275],26.7976,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-235.922,-3.40723,-0.09552],264.193,1,0,[-0.852778,-0.834645],"","",true,false],
	["Land_Razorwire_F",[-252.979,-59.1475,-0.479036],202.191,1,0,[-4.85115,-4.05087],"","",true,false],
	["Land_CzechHedgehog_01_F",[-260.677,-55.1367,0],19.9997,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-262.531,-51.165,-0.272036],252.998,1,0,[3.18184,-2.64962],"","",true,false],
	["Land_CzechHedgehog_01_F",[-264.899,-44.1299,-0.0119877],71.0587,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-270.677,-38.0576,0.151673],45.8569,1,0,[-0.878507,0.959332],"","",true,false],
	["Land_CzechHedgehog_01_F",[-273.844,-34.3262,-0.00533104],231.823,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-276.032,-22.4336,0],248.681,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-276.441,-32.9795,-0.00309467],94.9475,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-277.705,-24.0605,-0.00291729],76.1423,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[290.494,60.8906,0.161304],247.956,1,0,[-2.05105,1.24232],"","",true,false],
	["Land_CzechHedgehog_01_F",[292.814,56.6396,0.000279427],37.7574,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[299.995,30.7158,-0.00629044],144,1,0,[0.583642,-0.236221],"","",true,false],
	["Land_Razorwire_F",[297.202,49.2422,-0.0103951],231.994,1,0,[0.609067,-0.0886468],"","",true,false],
	["Land_CzechHedgehog_01_F",[300.225,45.3564,0],231.823,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[303.271,33.6357,0],231.823,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[302.467,44.833,-0.000148773],284.144,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[304.252,35.4785,-0.00456429],245.873,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[311.065,23.585,-0.072381],226.795,1,0,[-0.414875,-0.55361],"","",true,false]
];
[_dict, "AS_powerplant_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_5", "objects", _objects] call DICT_fnc_set;

_center = [16033.1, 16997.5];
_objects = [
	["Land_PortableLight_double_F",[-70.2627,-8.58789,-0.000844955],106.857,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-71.8135,5.12109,-0.00157547],57.7766,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-70.2051,25.0137,-0.00602055],287.402,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-68.6943,49.4785,-0.00668907],35.5228,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-35.5752,93.5449,-0.00199699],22.4876,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-101.561,-9.17773,0],55.7569,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-102.652,-10.2207,0.000505447],352.794,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-106.198,2.44141,-0.00133801],63.7817,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-14.1084,106.201,0.00399303],74.6481,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-108.547,3.63086,-0.000252724],157.019,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-125.336,59.6387,-0.185518],67.794,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[19.5957,149.348,0.0753803],358.831,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[127.791,-83.6465,0.0719929],117.47,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[159.699,12.2051,-0.00439167],286.519,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[160.407,0.734375,0.00154686],241.073,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[166.746,0.166016,0.000436783],63.7817,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[64.5547,-155.459,0],196.315,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[68.9199,-153.719,0],13.5846,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[72.7793,-155.973,0],232.958,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-33.1162,-169.238,-0.176886],183.109,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[174.968,13.0527,0],63.7817,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[175.665,0.775391,0.00143623],273.892,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[179.815,-1.78516,0],55.7569,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[179.583,10.7676,0.000632286],317.183,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[79.9678,-169.791,0.480047],123.644,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_outpost_10", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_10", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_10", "objects", _objects] call DICT_fnc_set;

_center = [16606.6, 19015.6];
_objects = [
	["Land_CzechHedgehog_01_F",[-12.1152,7.48633,0],278.978,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[7.96875,20.0742,-0.00230789],3.67344,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-29.8691,0.222656,0.13076],337.634,1,0,[-0.843559,0.760294],"","",true,false],
	["Land_Razorwire_F",[25.3594,15.3613,-0.0560265],103.176,1,0,[0.974874,-0.477925],"","",true,false],
	["Land_Razorwire_F",[31.5703,-2.35742,0.353596],132.092,1,0,[3.46965,6.50713],"","",true,false],
	["Land_Razorwire_F",[22.332,-20.6855,0.269558],89.3986,1,0,[-4.32655,2.18364],"","",true,false],
	["Land_PortableLight_double_F",[27.3301,18.7422,0.00153732],223.052,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[20.9512,26.4141,-0.00141907],233.023,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-5.0918,-33.2188,1.67916],161.508,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-31.3711,34.8047,0],359.564,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-22.8066,-43.9688,-0.0719032],285.241,1,0,[-0.99848,-0.984627],"","",true,false],
	["Land_Razorwire_F",[-35.2246,35.0254,0.261288],319.864,1,0,[-6.82253,4.65898],"","",true,false],
	["Land_Razorwire_F",[0.554688,51.291,-0.382114],62.0603,1,0,[-3.34709,-4.18207],"","",true,false],
	["Snake_random_F",[-10.2656,48.793,0.00843811],17.3645,1,0,[0,0],"","",true,false],
	["Snake_random_F",[27.209,-41.8691,0.00838852],304.282,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-14.8086,49.9355,0.18399],334.356,1,0,[-7.51071,1.91589],"","",true,false],
	["Land_CzechHedgehog_01_F",[-23.9102,-48.6504,0],134.761,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-24.543,-51.9961,0.00379181],357.626,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-57.709,-30.9063,0],201.654,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-34.418,-56.9688,0.0156441],336.663,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-63.4746,-35.6484,0.000461578],42.5634,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-58.0137,-44.7285,0],55.7569,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-60.1172,-45.7441,0.00230026],64.9688,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_7", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_7", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_7", "objects", _objects] call DICT_fnc_set;

_center = [18058.5, 19172.6];
_objects = [
	["Land_Cargo_Tower_V2_F",[12.0586,-12.1934,0],126.971,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-18.3086,28.3809,1.2042],176.187,1,0,[13.1757,10.438],"","",true,false],
	["Land_Razorwire_F",[-38.7305,-24.8301,-0.291286],259.292,1,0,[-0.251153,-1.74013],"","",true,false],
	["Snake_random_F",[16.084,-45.5117,0.00786495],130.426,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-35.5488,-34.9922,-0.910264],252.227,1,0,[-5.45584,-8.13833],"","",true,false],
	["Land_Razorwire_F",[-49.0234,-16.0352,-0.738984],1.54744,1,0,[2.84604,-6.39927],"","",true,false],
	["Land_Razorwire_F",[-38.0566,31.2852,-0.200993],135.557,1,0,[10.961,-1.88626],"","",true,false],
	["Snake_random_F",[-33.5527,-37.5566,0.00868988],282.138,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-45.7695,21.332,-1.66365],116.578,1,0,[13.8164,-16.719],"","",true,false],
	["Land_Razorwire_F",[38.334,37.3867,0.458765],171.807,1,0,[-0.414795,5.67667],"","",true,false],
	["Land_Razorwire_F",[-34.2734,-45.0273,-1.21853],271.857,1,0,[0.120974,-10.7966],"","",true,false],
	["Snake_random_F",[-35.6621,42.0078,0.00809002],246.707,1,0,[0,0],"","",true,false],
	["Land_Bunker_F",[9.31836,55.3984,0.199889],119.708,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-55.8379,0.871094,0.302485],121.044,1,0,[3.47752,2.36163],"","",true,false],
	["Land_CzechHedgehog_01_F",[-54.9688,-15.9219,0],3.67344,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[56.9727,-0.957031,0.0204449],313.769,1,0,[6.33133,1.32906],"","",true,false],
	["Land_PortableLight_double_F",[-56.625,-16.9824,0.019392],60.9278,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-59.7441,-6.13086,0],309.55,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[61.2891,6.90039,-1.14228],270.789,1,0,[2.46264,-9.8757],"","",true,false],
	["Land_Razorwire_F",[56.7012,25.377,0.481646],235.029,1,0,[11.8281,4.27811],"","",true,false],
	["Land_PortableLight_double_F",[-61.459,-7.96484,0.0210199],28.9589,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-32,-55.8652,-1.51594],255.067,1,0,[-6.21393,-13.3488],"","",true,false],
	["Land_Razorwire_F",[-31.5488,-66.9746,-2.14334],270.209,1,0,[0.153384,-19.1193],"","",true,false],
	["Land_Razorwire_F",[-30.0234,-77.8242,-1.71289],259.528,1,0,[-2.36237,-16.2795],"","",true,false]
];
[_dict, "AS_outpost_18", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_18", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_18", "objects", _objects] call DICT_fnc_set;

_center = [18331.5, 15514.2];
_objects = [
	["Snake_random_F",[23.2695,43.8203,0.0083847],193.381,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-49.9238,-7.8291,0.00840378],14.3409,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-33.459,38.8643,0.00838852],346.735,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-47.4473,-51.4082,0.0237236],268.949,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-55.8184,-47.8711,-0.220974],12.6326,1,0,[3.14869,-1.48783],"","",true,false],
	["Land_PortableLight_double_F",[76.8574,-3.19727,-0.000946045],258.804,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[77.2598,6.44531,-0.00202179],272.166,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[67.543,-39.0156,-0.202621],296.144,1,0,[3.4448,-0.43464],"","",true,false],
	["Land_CzechHedgehog_01_F",[80.0391,-5.18848,0],3.67344,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[81.8203,6.95801,-0.083252],1.55539,1,0,[0.552951,-0.672551],"","",true,false],
	["Land_Razorwire_F",[36.1523,77.8545,-0.0586929],179.005,1,0,[-0.848035,-0.44339],"","",true,false],
	["Land_Razorwire_F",[44.6777,77.6133,0.0343857],184.764,1,0,[-0.862654,0.234379],"","",true,false],
	["Land_CzechHedgehog_01_F",[89.2539,6.86914,0],3.67344,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-66.5664,63.3135,0.0134621],154.882,1,0,[0.0278527,0.239856],"","",true,false],
	["Land_Razorwire_F",[-102.197,-36.0693,0.142677],14.3108,1,0,[4.24595,1.55929],"","",true,false],
	["Land_Razorwire_F",[-96.6875,58.4775,0.0607185],176.564,1,0,[-1.66342,0.329414],"","",true,false],
	["Land_Razorwire_F",[-113.365,-21.4844,0.0712166],57.9652,1,0,[-1.75639,0.64862],"","",true,false],
	["Land_Razorwire_F",[119.939,46.1982,0.115337],274.266,1,0,[-4.15221,0.302496],"","",true,false],
	["Land_Razorwire_F",[-150.404,-16.1865,-0.225639],351.962,1,0,[2.45428,-2.27666],"","",true,false],
	["Land_Razorwire_F",[-155.93,18.583,-0.054863],176.77,1,0,[-0.792748,-0.490659],"","",true,false],
	["Land_Razorwire_F",[-149.949,54.3633,0.120586],175.973,1,0,[-0.387535,1.02284],"","",true,false],
	["Land_CzechHedgehog_01_F",[-164.043,18.5186,1.52588e-005],47.7439,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-164.684,23.0996,-0.0598869],269.044,1,0,[-0.0127474,-0.763499],"","",true,false],
	["Land_PortableLight_double_F",[-165.334,18.7568,-0.000965118],102.303,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-177.355,31.5752,-0.00108719],197.093,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-178.09,17.751,-0.104034],198.549,1,0,[-1.27934,-0.269019],"","",true,false],
	["Land_CzechHedgehog_01_F",[-178.961,29.4971,0],3.67344,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-180.873,-27.4736,0.160767],48.0046,1,0,[1.87943,1.28816],"","",true,false],
	["Land_PortableLight_double_F",[-180.809,29.2832,-0.00125504],102.987,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-185.336,20.2021,0],155.94,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_resource_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_3", "objects", _objects] call DICT_fnc_set;

_center = [19615.1, 15620.2];
_objects = [
	["Land_HaulTruck_01_abandoned_F",[-1.90234,17.1328,-0.200491],340.204,1,0,[0.910815,9.65667],"","",true,false],
	["Land_Sea_Wall_F",[-20.916,-1.23535,-2.51169],109.525,1,0,[-27.8108,7.23833],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[-19.8223,-18.2139,0.0336494],124.523,1,0,[-9.10535,-8.57008],"","",true,false],
	["Land_Sea_Wall_F",[-32.668,4.24219,-1.63282],308.364,1,0,[19.9752,2.16172],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[-29.8398,-26.2559,0.00852585],189.238,1,0,[-1.56725,-6.04293],"","",true,false],
	["Land_Sea_Wall_F",[-27.4629,28.1777,-1.38879],345.947,1,0,[-1.94356,19.4501],"","",true,false],
	["Snake_random_F",[-10.998,47.8643,0.00837135],206.739,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-7.4082,49.4033,0.00844765],211.792,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-30.9863,-41.5098,0.00853729],192.229,1,0,[0,0],"","",true,false],
	["Land_Wreck_Ural_F",[-66.8984,-67.9248,0.386269],125.218,1,0,[-8.30452,-3.65433],"","",true,false],
	["Land_Razorwire_F",[-84.6113,-101.044,1.0903],39.0673,1,0,[8.46298,8.46646],"","",true,false],
	["Land_Razorwire_F",[-94.2363,-179.738,-0.26021],270.565,1,0,[0.625495,-1.44493],"","",true,false],
	["Land_Razorwire_F",[-89.6875,-182.007,0.23914],327.698,1,0,[1.031,2.0586],"","",true,false],
	["Land_CzechHedgehog_01_F",[-94.6836,-185.169,0],155.94,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-92.8477,-186.338,-0.00242233],251.597,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-103.441,-185.292,-0.464649],268.067,1,0,[-1.20523,-3.92791],"","",true,false],
	["Land_CzechHedgehog_01_F",[-102.998,-190.079,0.0119324],143.152,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-103.43,-192.758,0.0214806],51.7453,1,0,[0,0],"","",true,false]
];
[_dict, "AS_resource", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource", "objects", _objects] call DICT_fnc_set;

_center = [18477.9, 14260.1];
_objects = [
	["Land_Wreck_Ural_F",[10.5234,-13.4189,-0.0318146],112.264,1,0,[1.31072,1.03194],"","",true,false],
	["Land_Excavator_01_wreck_F",[27.2852,30.1729,0.176147],18.9391,1,0,[6.15902,-18.3091],"","",true,false],
	["Snake_random_F",[44.8027,12.7461,0.00763893],191.599,1,0,[0,0],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[21.7891,46.6387,0.0614338],277.226,1,0,[-10.5723,-13.5712],"","",true,false],
	["Snake_random_F",[61.1914,19.8945,0.00863266],319.89,1,0,[0,0],"","",true,false],
	["Rabbit_F",[62.5488,30.6914,0.0294342],165.547,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[67.3535,27.1436,0.00805283],80.0435,1,0,[0,0],"","",true,false],
	["Rabbit_F",[43.4453,80.8516,0.028511],41.4242,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-16.1953,103.647,0.00301552],359.517,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-110.26,-28.1299,-0.144085],246.275,1,0,[-4.62833,-1.04888],"","",true,false],
	["Land_CzechHedgehog_01_F",[-114.525,-20.4629,0],91.9801,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-118.447,-16.9775,0.221788],223.704,1,0,[-3.57657,1.75623],"","",true,false],
	["Land_Razorwire_F",[-124.443,4.43359,-0.00993919],277.299,1,0,[-0.520431,-0.143883],"","",true,false],
	["Land_CzechHedgehog_01_F",[-123.813,-11.3125,0.0223885],208.623,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-125.146,0.56543,0],143.152,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-125.574,-10.6494,0.0163956],78.6486,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-126.227,-0.97168,0.0271301],68.3087,1,0,[0,0],"","",true,false]
];
[_dict, "AS_resource_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_1", "objects", _objects] call DICT_fnc_set;

_center = [20701.3, 15678.2];
_objects = [
	["Land_Razorwire_F",[13.1152,-21.1699,-0.196043],335.691,1,0,[-0.281258,-1.54914],"","",true,false],
	["Land_Razorwire_F",[2.79102,-28.3906,-0.100922],314.958,1,0,[-0.541313,-0.755223],"","",true,false],
	["Land_Razorwire_F",[23.1797,-16.6592,-0.0438519],335.682,1,0,[0.0441641,-0.271252],"","",true,false],
	["Land_CzechHedgehog_01_F",[-0.945313,-32.2998,0],284.957,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[31.2734,-13.2568,0],359.487,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[35.4707,-14.3135,-0.0121269],27.2425,1,0,[0.411038,-0.131637],"","",true,false],
	["Land_Razorwire_F",[-39.3301,14.7549,-0.25338],290.281,1,0,[0.265833,-2.26245],"","",true,false],
	["Land_Razorwire_F",[-45.0293,7.39355,-0.200953],312.008,1,0,[0.625188,-1.49279],"","",true,false],
	["Land_Razorwire_F",[-36.4453,27.7852,-0.0283966],91.0958,1,0,[-3.42292,-0.600134],"","",true,false],
	["Land_CzechHedgehog_01_F",[37.3535,27.5391,0],69.3119,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[42.3262,26.7295,-0.000951767],54.4985,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-42.0488,27.2598,0],202.093,1,0,[2.97032,1.20657],"","",true,false],
	["Land_CzechHedgehog_01_F",[-38.0254,33.5283,0],143.152,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-22.5859,45.752,0.00838852],301.914,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[48.9277,-20.1113,-0.0218945],200.318,1,0,[-0.259605,-0.177804],"","",true,false],
	["Land_CzechHedgehog_01_F",[-52.3359,0.4375,0],247.361,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[40.3223,31.25,0.0524464],315.079,1,0,[-0.108831,0.431931],"","",true,false],
	["Land_PortableLight_double_F",[-30.7598,42.6885,0.00291634],136.297,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[47.0859,24.7744,0.00133324],61.7457,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-39.5449,36.793,0.00475311],148.53,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[56.5508,-11.9414,3.62396e-005],323.358,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-59.0879,-6.45215,-0.161995],318.443,1,0,[1.05495,-1.34311],"","",true,false],
	["Land_CzechHedgehog_01_F",[54.5098,-22.4199,0.00266647],143.152,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[58,-23.8691,0.000701904],26.4393,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[51.8008,39.6709,-0.0183563],150.801,1,0,[0.637578,-0.268554],"","",true,false],
	["Land_CzechHedgehog_01_F",[63.4668,-13.4053,0],255.108,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-67.1289,-11.4766,-0.02145],336.218,1,0,[0.489109,-0.215547],"","",true,false],
	["Land_PortableLight_double_F",[66.1367,-14.7734,0.00365639],229.501,1,0,[0,0],"","",true,false]
];
[_dict, "AS_powerplant", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant", "objects", _objects] call DICT_fnc_set;

_center = [17496, 13188.8];
_objects = [
	["Land_CzechHedgehog_01_F",[13.418,3.2168,0],143.152,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[15.1504,2.73926,-0.00185585],317.277,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[0.986328,15.9326,0.00265884],157.881,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[0.8125,18.4268,0.00226212],141.983,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[6.69531,29.833,0.0561485],311.149,1,0,[-0.294031,0.452881],"","",true,false],
	["Land_PortableLight_double_F",[-22.4922,-28.6221,-0.00246429],215.693,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[7.44922,-35.7979,0],85.073,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[39.4707,1.86719,0.102917],135.8,1,0,[1.06742,0.87974],"","",true,false],
	["Land_PortableLight_double_F",[-1.33008,-38.8389,-0.00139332],36.6635,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-37.0762,-13.0723,-0.00166702],260.238,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-39.7891,-5.86621,-0.0012598],326.467,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[16.0996,43.4082,-0.173612],119.309,1,0,[-0.0305708,-1.50612],"","",true,false],
	["Land_Razorwire_F",[48.0996,10.6641,-0.0443964],130.16,1,0,[0.27794,-0.564969],"","",true,false],
	["Snake_random_F",[50.2871,-1.58105,0.00833893],132.25,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-54.0391,4.1582,-0.0126514],358.161,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[25.0332,53.1768,-0.000494003],135.345,1,0,[0.809649,0.0590104],"","",true,false],
	["Land_CzechHedgehog_01_F",[35.9727,-63.3965,0],103.557,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[67.416,30.6973,0.125067],299.19,1,0,[-0.870507,1.08853],"","",true,false],
	["Land_CzechHedgehog_01_F",[39.3047,-66.6504,0],164.878,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-74.1035,-32.6084,-0.0143213],358.91,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[75.6191,42.1445,-0.0662298],133.342,1,0,[1.1722,-0.574165],"","",true,false],
	["Land_Razorwire_F",[53.9082,80.5996,-0.0322561],144.888,1,0,[0.543903,-0.288776],"","",true,false],
	["Land_CzechHedgehog_01_F",[-38.1797,-91.8086,-0.014966],354.818,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[61.125,87.8701,-0.0753479],133.351,1,0,[0.413896,-0.659776],"","",true,false],
	["Land_Razorwire_F",[88.5078,56.3789,-0.078021],314.822,1,0,[-1.99922,-0.3722],"","",true,false],
	["Land_CzechHedgehog_01_F",[-105.203,21.1865,0],242.044,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-105.719,24.7705,-0.0209684],297.962,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-48.1055,-110.83,-0.0136518],36.0532,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-121.205,2.69434,-0.0203018],249.439,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-92.082,-91.5449,-0.0126486],109.916,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-148.051,-22.6396,0],228.642,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-151.723,-27.6455,0],358.161,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-157.125,5.38281,-0.0179806],24.0279,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-156.447,-30.2988,0],294.719,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_1", "objects", _objects] call DICT_fnc_set;

_center = [16670.6, 12292.3];
_objects = [
	["Land_BagBunker_Large_F",[-27.4414,4.39453,0.0209434],92.0596,1,0,[-2.00899,-1.52421],"","",true,false],
	["Land_CzechHedgehog_01_F",[8.27734,-26.1143,0],357.568,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[16.0137,-26.6396,0],8.44622,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[30.584,5.94141,0.410559],258.741,1,0,[-4.31095,2.57185],"","",true,false],
	["Land_CzechHedgehog_01_F",[-34.5996,-0.896484,0],68.2743,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-34.418,10.1787,0],105.485,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-36.5801,-4.38281,0.0113332],91.4392,1,0,[2.74722,0.0690739],"","",true,false],
	["Land_Razorwire_F",[-37,16.5967,0.101443],88.3956,1,0,[1.40233,0.954187],"","",true,false],
	["Snake_random_F",[8.69922,48.958,0.00835013],226.942,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[0.910156,51.6055,0.195203],111.985,1,0,[2.73081,1.5973],"","",true,false],
	["Land_CzechHedgehog_01_F",[2.07227,55.2861,0],157.881,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[1.49023,57.252,0.00172353],142.031,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[29.2109,50.4365,1.48315],198.929,1,0,[-11.2748,12.1623],"","",true,false],
	["Land_Razorwire_F",[14.5859,62.4004,-0.0522242],52.17,1,0,[1.32024,-0.541646],"","",true,false],
	["Land_PortableLight_double_F",[10.3184,64.1826,0.00961828],133.721,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[12.0801,65.5576,0],305.739,1,0,[0,0],"","",true,false]
];
[_dict, "AS_seaport", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_seaport", "center", _center] call DICT_fnc_set;
[_dict, "AS_seaport", "objects", _objects] call DICT_fnc_set;

_center = [16819.3, 12040.2];
_objects = [
	["Land_CzechHedgehog_01_F",[7.14453,10.6494,0],194.488,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[7.9082,15.1563,0],89.4368,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[5.0957,-34.1875,-0.490355],317.11,1,0,[-3.74234,-3.9157],"","",true,false],
	["Land_Razorwire_F",[-9.33398,-34.2266,0.059413],227.725,1,0,[-0.087124,0.69874],"","",true,false],
	["Land_Razorwire_F",[6.96289,37.542,0.359712],111.89,1,0,[-1.43804,3.37],"","",true,false],
	["Land_Razorwire_F",[-5.64258,38.5693,0.474136],97.0871,1,0,[5.55818,4.1501],"","",true,false],
	["Land_PortableLight_double_F",[-6.0957,-37.2041,-0.00101709],356.517,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[2.94727,-37.915,-0.00243711],4.12302,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[26.918,28.5645,0],32.3906,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[5.16797,40.7148,0.0163445],182.378,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-3.57422,41.6494,-0.00643301],208.066,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[47.9746,-5.88672,0.554654],267.114,1,0,[-17.8384,5.80515],"","",true,false],
	["Ornate_random_F",[-49.8164,6.95117,-0.87567],356.619,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_outpost_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_3", "objects", _objects] call DICT_fnc_set;

_center = [16976.9, 11367.1];
_objects = [
	["Snake_random_F",[1.79492,-20.4766,0.00849342],302.302,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-7.67188,24.1563,0.00834274],173.905,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[-23.1328,18.2031,0.0458927],330.057,1,0,[0,0],"","",true,false],
	["Land_HaulTruck_01_abandoned_F",[47.502,-1.56836,-0.00708389],83.2787,1,0,[1.477,0.133835],"","",true,false],
	["Snake_random_F",[47.459,26.8779,0.00944519],339.499,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-46.0977,-36.7588,-0.0144711],56.2556,1,0,[0,0],"","",true,false],
	["Rabbit_F",[33.5195,-61.2529,0.00628471],318.471,1,0,[0,0],"","",true,false],
	["Rabbit_F",[1.08594,-71.8252,0.000595093],70.6664,1,0,[0,0],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[86.7148,-0.977539,0.0022831],252.562,1,0,[-3.17914,-0.441561],"","",true,false],
	["Land_PortableLight_double_F",[55.9043,-69.2773,0.000434875],145.177,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[62.1367,-81.2285,-0.00417137],346.831,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[64.0449,-80.8799,-0.258482],60.5852,1,0,[-0.41367,-2.13367],"","",true,false],
	["Rabbit_F",[70.1563,-81.9053,0.00437737],316.31,1,0,[0,0],"","",true,false],
	["Land_MiningShovel_01_abandoned_F",[117.52,-28.5391,-0.0251656],351.462,1,0,[1.04642,4.3921],"","",true,false],
	["Land_Bulldozer_01_wreck_F",[116.096,-111.376,0.00185585],348.35,1,0,[-0.736269,-2.80998],"","",true,false],
	["Land_Excavator_01_abandoned_F",[158.549,21.0713,0.0205688],23.3604,1,0,[5.85997,0.449648],"","",true,false],
	["Land_Razorwire_F",[111.109,-145.685,-0.150034],96.2664,1,0,[1.42432,-1.07303],"","",true,false],
	["Land_Razorwire_F",[102.025,-156.062,-0.357861],105.626,1,0,[0.654706,-2.9081],"","",true,false],
	["Land_Razorwire_F",[115.994,-148.199,-0.0247688],130.528,1,0,[1.78099,-0.0849226],"","",true,false],
	["Land_CzechHedgehog_01_F",[110.535,-153.411,0],37.744,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[98.5371,-162.892,0.00529861],148.04,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[108.99,-166.584,-0.142969],151.27,1,0,[1.73511,-1.12465],"","",true,false],
	["Land_PortableLight_double_F",[102.424,-171.569,-0.00335884],345.322,1,0,[0,0],"","",true,false]
];
[_dict, "AS_resource_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_resource_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_resource_2", "objects", _objects] call DICT_fnc_set;

_center = [17865.3, 11719.2];
_objects = [
	["Land_BagBunker_Small_F",[-4.08984,-33.0664,-0.00580597],323.427,1,0,[1.17895,6.05412],"","",true,false],
	["Land_Razorwire_F",[13.2031,-30.6162,-0.272064],167.318,1,0,[3.1016,-3.59758],"","",true,false],
	["Land_Razorwire_F",[24.9453,-25.3623,0.0407181],148.417,1,0,[-4.56266,0.293799],"","",true,false],
	["Land_Razorwire_F",[-12.9277,-33.1992,-0.234779],180.965,1,0,[4.76735,-2.44803],"","",true,false],
	["Land_Razorwire_F",[32.3242,-17.0293,-0.534355],122.611,1,0,[-8.76993,-5.72707],"","",true,false],
	["Land_Razorwire_F",[-20.0938,31.8535,-0.34108],336.703,1,0,[-8.03115,-3.12496],"","",true,false],
	["Land_Razorwire_F",[-25.043,-31.4365,0.685921],225.217,1,0,[5.25512,5.72902],"","",true,false],
	["Land_Razorwire_F",[-6.47266,39.3154,-0.0752792],328.042,1,0,[-2.38651,-1.66203],"","",true,false],
	["Land_Razorwire_F",[41.4434,-9.96582,-0.840866],156.186,1,0,[-4.20182,-7.04277],"","",true,false],
	["Land_Razorwire_F",[-33.3672,-24.499,0.302414],200.548,1,0,[1.30505,2.61011],"","",true,false],
	["Land_Razorwire_F",[-37.6563,21.8154,-0.284889],325.129,1,0,[-7.83918,-0.496924],"","",true,false],
	["Land_Cargo_Patrol_V2_F",[44.1133,0.551758,0],267.666,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[3.23633,46.792,2.13039],303.627,1,0,[-6.53934,19.7641],"","",true,false],
	["Land_Razorwire_F",[49.5625,-1.77344,0.534157],120.121,1,0,[-9.33104,5.56058],"","",true,false],
	["Snake_random_F",[-13.873,48.1914,0],49.5997,1,0,[6.32893,-20.1797],"","",true,false],
	["Land_Razorwire_F",[-45.0586,-22.1846,-1.20432],176.656,1,0,[-0.996306,-10.3871],"","",true,false],
	["Land_CzechHedgehog_01_F",[52.3984,3.60352,0],129.363,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-52.9063,-0.000976563,-0.42907],271.686,1,0,[5.48935,-2.51136],"","",true,false],
	["Land_Razorwire_F",[32.3145,43.4473,0.980057],41.5836,1,0,[-11.8487,9.09584],"","",true,false],
	["Land_CzechHedgehog_01_F",[38.8594,37.75,0],37.0145,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[42.9258,33.0195,-0.415352],41.2425,1,0,[-10.9271,-4.40926],"","",true,false],
	["Land_Razorwire_F",[-54.1914,-12.3447,0.294357],273.978,1,0,[-6.39592,2.9967],"","",true,false],
	["Land_Razorwire_F",[51.0566,20.4678,-0.449074],246.818,1,0,[8.78885,-3.95378],"","",true,false],
	["Land_Razorwire_F",[14.3281,53.9922,0.294159],169.321,1,0,[5.665,2.5169],"","",true,false],
	["Land_BagBunker_Small_F",[19.418,52.7432,0.000823975],208.941,1,0,[-0.0722744,0.92018],"","",true,false],
	["Land_CzechHedgehog_01_F",[53.457,15.4014,0],0,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[55.2188,5.51172,0.0326309],281.138,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[24.4863,50.627,0.979881],39.4585,1,0,[-7.19965,8.13678],"","",true,false],
	["Land_BagBunker_Small_F",[-54.7656,-19.0947,-0.0897827],60.9911,1,0,[11.2827,0.0383046],"","",true,false],
	["Land_PortableLight_double_F",[57.1445,13.6934,-0.00518036],291.267,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_21", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_21", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_21", "objects", _objects] call DICT_fnc_set;

_center = [18689.6, 10198.1];
_objects = [
	["Land_Razorwire_F",[-7.48047,-2.52637,-0.308563],299.161,1,0,[2.43175,-3.10076],"","",true,false],
	["Land_Razorwire_F",[-2.52148,7.37988,0.195831],282.622,1,0,[2.62302,1.21379],"","",true,false],
	["Land_BagBunker_Small_F",[8.08398,-7.38086,-0.0583801],2.64716,1,0,[6.73575,0.851638],"","",true,false],
	["Land_Razorwire_F",[-4.56641,-9.95605,0.236557],10.8636,1,0,[6.7691,1.85284],"","",true,false],
	["Land_Razorwire_F",[5.88086,-11.4385,0.139679],2.39465,1,0,[6.72353,1.20624],"","",true,false],
	["Land_Razorwire_F",[17.1309,-11.3105,0.0305328],357.206,1,0,[6.25444,0.15521],"","",true,false],
	["Snake_random_F",[4.61914,26.3057,0.00834656],320.858,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[2.92578,27.0244,-0.0455627],138.749,1,0,[5.28896,-3.21766],"","",true,false],
	["Land_Razorwire_F",[31.0957,-15.3203,-0.420746],208.198,1,0,[-6.43127,-3.63159],"","",true,false],
	["Land_Razorwire_F",[41.1602,-18.1211,-0.554184],182.715,1,0,[-3.77407,-5.75668],"","",true,false],
	["Rabbit_F",[-12.8691,-46.248,-0.0325165],175.72,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[-41.9883,-24.7734,0.0287933],88.5308,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[37.2734,31.4609,-0.17746],9.35596,1,0,[-8.38199,-1.39068],"","",true,false],
	["Snake_random_F",[8.77148,51.1934,0.00927734],95.0235,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[52.5293,-12.834,0.340195],144.872,1,0,[-9.53,2.78878],"","",true,false],
	["Land_Cargo_Patrol_V2_F",[54.1152,-0.0205078,0],301.925,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[48.6738,29.0928,-0.299637],11.1771,1,0,[-8.78885,-2.45864],"","",true,false],
	["Land_Razorwire_F",[60.1992,-4.16992,0.781952],120.322,1,0,[-7.45283,6.64897],"","",true,false],
	["Land_CzechHedgehog_01_F",[62.8184,-0.143555,0],129.363,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[64.7949,-0.889648,0.0238953],292.393,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[61.0488,24.7832,-0.0500488],32.827,1,0,[5.11366,-0.338074],"","",true,false],
	["Land_CzechHedgehog_01_F",[70.416,7.25684,0],136.093,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[70.1777,13.0293,-0.847473],260.948,1,0,[2.31654,-5.91785],"","",true,false],
	["Snake_random_F",[52.4883,49.2832,0.00782776],259.171,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[72.0469,6.26953,0.0229187],312.19,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-9.77344,70.8369,0.0348206],270.065,1,0,[0,0],"","",true,false],
	["Rabbit_F",[84.0293,39.4805,0.0228729],232.729,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-30.5117,89.3311,0.00349426],0.928757,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_20", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_20", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_20", "objects", _objects] call DICT_fnc_set;

_center = [19380, 9726.14];
_objects = [
	["Land_Cargo_Patrol_V2_F",[6.42773,9.3291,0],177.034,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[25.3613,-15.126,0.00860596],254.172,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-10.9141,51.6758,0.00845337],176.073,1,0,[0,-0],"","",true,false],
	["Land_BagBunker_Small_F",[11.3047,-52.9688,-0.0347137],266.622,1,0,[4.11611,-4.21519],"","",true,false],
	["Snake_random_F",[-8.63477,53.5068,0.00845337],35.1387,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[14.7148,-51.6143,0.532867],87.3759,1,0,[-4.17101,4.16089],"","",true,false],
	["Rabbit_F",[26.4961,-54.0332,-0.00434875],163.873,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[20.0938,-58.1689,0.0202942],89.9881,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V2_F",[-69.9375,-16.3555,0],81.9001,1,0,[0,0],"","",true,false],
	["Rabbit_F",[26.9648,70.957,0.0264893],314.979,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-77.3359,-19.9502,0],100.676,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[52.1855,60.1152,0.00709534],225.107,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-75.7754,-29.7773,0.0324554],54.8212,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-81.1465,-17.7705,0],129.363,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-77.7266,-31.1826,0],115.488,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[82.2871,25.0088,0.0148315],134.935,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_outpostAA_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_2", "objects", _objects] call DICT_fnc_set;

_center = [20092, 9402.28];
_objects = [
	["Land_PortableLight_double_F",[1.49414,4.2627,0.000587463],100.676,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-3.08398,6.82813,-0.155098],101.399,1,0,[1.44044,-1.34587],"","",true,false],
	["Land_PortableLight_double_F",[13.498,14.0947,-0.00598907],191.799,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[20.5039,-9.50684,0.326607],276.869,1,0,[0.609466,2.61087],"","",true,false],
	["Land_PortableLight_double_F",[21.9961,-2.58887,0.00362396],226.955,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[9.64648,22.7715,0.00614166],141.317,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[11.4375,23.7666,0.477203],265.591,1,0,[1.14503,3.88995],"","",true,false],
	["Land_PortableLight_double_F",[19.5586,19.9473,0.008461],217.773,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[20.0547,25.3926,-0.404762],117.652,1,0,[1.08825,-3.39309],"","",true,false],
	["Snake_random_F",[-49.4063,2.65137,0.00850677],27.3347,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-45.2754,-23.1523,0.00811005],263.555,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-50.7813,-6.47461,0.00782776],230.775,1,0,[0,0],"","",true,false]
];
[_dict, "AS_powerplant_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_2", "objects", _objects] call DICT_fnc_set;

_center = [20754.4, 7194.14];
_objects = [
	["Land_BagBunker_Large_F",[-2.52148,-4.69238,0.0047226],53.1747,1,0,[-0.459082,0.53357],"","",true,false],
	["Land_Cargo_Patrol_V2_F",[-31.6309,11.4224,0],55.5536,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-32.8281,-6.93262,-0.123432],251.64,1,0,[0.145988,-1.01422],"","",true,false],
	["Land_Razorwire_F",[-31.0547,17.0723,-0.0666847],146.017,1,0,[1.67139,-0.38978],"","",true,false],
	["Land_Razorwire_F",[-24.6992,-28.5547,0.0477695],253.737,1,0,[0.295561,0.470553],"","",true,false],
	["Snake_random_F",[38.2813,4.79541,0.00838852],54.9988,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-37.002,13.1147,0.00056076],78.3706,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-39.0938,6.09131,0.0517578],277.639,1,0,[0.802327,0.338665],"","",true,false],
	["Land_Razorwire_F",[25.7188,-34.3789,-0.207983],146.715,1,0,[-0.83489,-1.82729],"","",true,false],
	["Land_PortableLight_double_F",[-43.1113,21.9111,-0.00294876],40.7041,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-42.8105,-30.187,0.00863457],214.567,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[51.6855,-16.4443,-0.221071],146.78,1,0,[0.989402,-1.83496],"","",true,false],
	["Land_Razorwire_F",[-50.4063,24.5752,-0.38796],19.2833,1,0,[-1.10637,-3.54145],"","",true,false],
	["Land_CzechHedgehog_01_F",[-2.23242,55.9004,0],300.914,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-6.26563,-55.9531,-0.0114365],146.547,1,0,[0.296865,-0.104311],"","",true,false],
	["Land_CzechHedgehog_01_F",[1.58008,58.6045,-0.00366402],352.004,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[61.8047,-8.97949,0.0522461],142.489,1,0,[0.39113,0.759033],"","",true,false],
	["Land_Razorwire_F",[68.5918,-3.50293,-0.0359116],139.995,1,0,[0.105547,-0.587339],"","",true,false],
	["Land_CzechHedgehog_01_F",[17.9844,67.8726,0],320.7,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-49.4434,53.0791,0.0085144],13.8483,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[21.2031,70.2925,-0.00534439],321.035,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-61.5918,48.0273,0.632521],238.92,1,0,[-1.62051,5.15539],"","",true,false],
	["Land_Razorwire_F",[-44.998,66.5908,-0.325062],142.221,1,0,[2.50152,-2.1317],"","",true,false],
	["Land_Razorwire_F",[-52.2227,61.5659,0.368471],154.875,1,0,[4.4511,2.1326],"","",true,false],
	["Land_Razorwire_F",[-41.1191,69.7041,0.193705],312.484,1,0,[-4.74751,1.33938],"","",true,false],
	["Land_Razorwire_F",[-31.8867,76.6831,0.383087],152.653,1,0,[2.71916,4.09032],"","",true,false],
	["Land_Razorwire_F",[-21.6602,84.1997,0.241535],327.887,1,0,[1.63877,2.03688],"","",true,false],
	["Land_Razorwire_F",[95.1328,-6.53369,0.0119228],241.693,1,0,[0.3102,0.0930233],"","",true,false],
	["Rabbit_F",[-61.168,77.3647,0.00588799],313.295,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[45.5527,87.585,0],326.006,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[100.289,-13.5225,-0.0368881],230.184,1,0,[0.244408,-0.303465],"","",true,false],
	["Land_CzechHedgehog_01_F",[48.4766,89.7461,-0.00132942],34.2646,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[7.68555,102.816,-0.091238],148.181,1,0,[-0.143431,-0.80996],"","",true,false],
	["Land_Razorwire_F",[104.895,-20.2695,-0.0240536],239.121,1,0,[1.11385,-0.220977],"","",true,false],
	["Rabbit_F",[-42.7266,103.47,0.00297165],102.362,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[62.5645,99.3091,-0.000993729],322.242,1,0,[0,0],"","",true,false],
	["Rabbit_F",[115.172,27.9072,0.00630188],299.35,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[33.3281,119.177,-0.0530453],142.966,1,0,[0.091286,-0.25922],"","",true,false],
	["Rabbit_F",[-1.88477,125.806,0.00455856],314.854,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[119.48,-48.415,-0.0939922],241.348,1,0,[-1.12864,-0.949995],"","",true,false],
	["Land_Razorwire_F",[52.7852,132.165,-0.377533],147.161,1,0,[3.4126,-3.29616],"","",true,false],
	["Rabbit_F",[9.13086,145.332,0.0302467],254.121,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[89.4941,121.461,0.616529],323.61,1,0,[0.589543,2.60113],"","",true,false],
	["Land_Razorwire_F",[144.02,-88.356,-0.0425625],236.021,1,0,[0.506689,-0.3415],"","",true,false],
	["Land_Cargo_Tower_V2_F",[198.166,-0.0727539,0],123.015,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Tower_V2_F",[348.633,269.213,0],292.316,1,0,[0,0],"","",true,false]
];
[_dict, "AS_airfield", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield", "objects", _objects] call DICT_fnc_set;

_center = [20080.5, 6731.98];
_objects = [
	["Land_PortableLight_double_F",[-2.8457,-19.0693,-3.05176e-005],359.576,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-5.71094,-21.7075,0.0162354],66.7975,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-22.707,1.7793,0.103371],234.86,1,0,[2.07994,0.964327],"","",true,false],
	["Land_Razorwire_F",[-22.1504,11.291,0.1754],326.898,1,0,[-7.14567,3.66492],"","",true,false],
	["Land_CzechHedgehog_01_F",[-4.8125,-24.4404,0],0,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[1.43359,-27.498,0.0114594],351.643,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base", "center", _center] call DICT_fnc_set;
[_dict, "AS_base", "objects", _objects] call DICT_fnc_set;

_center = [19598.9, 6624.75];
_objects = [
	["Land_PortableLight_double_F",[4.70898,-1.39307,0.00645447],108.771,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-4.99023,-4.19678,-0.00037384],355.879,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-3.63086,-11.8975,-0.000205994],357.647,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[12.1133,6.2583,-0.137123],98.2578,1,0,[3.19893,-1.31056],"","",true,false],
	["Land_PortableLight_double_F",[-9.25977,-10.5815,0.00150299],32.3711,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-0.941406,-14.2656,-0.0449829],67.1943,1,0,[0.57493,-0.406585],"","",true,false],
	["Land_Razorwire_F",[-12.5254,-12.5605,-0.0452805],125.531,1,0,[1.41179,-0.399636],"","",true,false],
	["Land_PortableLight_double_F",[-7.84766,19.8115,0.000694275],120.363,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-13.0977,16.1816,-0.250618],277.932,1,0,[1.74385,-1.99298],"","",true,false],
	["Land_CzechHedgehog_01_F",[21.0273,-7.57568,0],31.4623,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-1.70508,24.4185,0.00830841],310.474,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[21.4648,15.1147,0],0,1,0,[0,0],"","",true,false],
	["Snake_random_F",[30.418,14.9146,0.00804138],212.262,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-8.29102,53.9839,0.00400543],124.183,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-54.252,-31.6514,0.00858688],244.03,1,0,[0,0],"","",true,false],
	["Rabbit_F",[36.9824,59.5313,0],79.5715,1,0,[0.166859,-4.98941],"","",true,false]
];
[_dict, "AS_powerplant_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_3", "objects", _objects] call DICT_fnc_set;

_center = [23079.2, 7288.79];
_objects = [
	["Land_Razorwire_F",[-27.3398,42.7163,-0.443249],145.466,1,0,[2.44164,-3.72157],"","",true,false],
	["Land_Razorwire_F",[-20.168,47.9531,-0.259483],142.065,1,0,[1.24341,-2.13156],"","",true,false],
	["Land_Razorwire_F",[-12.8242,53.0493,0.0244942],144.553,1,0,[1.58934,-0.00615423],"","",true,false],
	["Land_Razorwire_F",[54.7051,15.2544,-0.608959],137.552,1,0,[-14.0018,-5.9776],"","",true,false],
	["Land_BagBunker_Small_F",[11.3164,-59.854,-0.00722122],311.65,1,0,[1.19337,-5.36376],"","",true,false],
	["Land_Razorwire_F",[58.3457,22.4106,0.239063],109.931,1,0,[-13.4793,2.00768],"","",true,false],
	["Land_Razorwire_F",[18.1602,-59.2451,0.625053],106.183,1,0,[-0.720803,4.94893],"","",true,false],
	["Land_Razorwire_F",[14.1406,-65.9756,0.571262],152.39,1,0,[-1.75534,4.7091],"","",true,false],
	["Land_BagBunker_Small_F",[40.4883,58.165,-0.0386963],225.823,1,0,[4.38827,2.54319],"","",true,false],
	["Land_Razorwire_F",[-82.4512,-34.7041,0.261654],155.515,1,0,[-1.0287,1.97947],"","",true,false],
	["Land_Razorwire_F",[57.4785,76.0342,0.174026],35.0435,1,0,[-16.6622,1.5667],"","",true,false],
	["Land_CzechHedgehog_01_F",[54.2773,79.0073,0.000305176],67.7357,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[48.4551,84.1128,-0.627804],46.2922,1,0,[-15.2718,-6.15865],"","",true,false],
	["Land_PortableLight_double_F",[-84.6582,-46.937,0.00893402],48.1673,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-90.3867,-36.1689,0.00814819],75.7993,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-47.3848,-98.0059,-0.216949],185.707,1,0,[-2.11984,-1.82493],"","",true,false]
];
[_dict, "AS_outpost", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost", "objects", _objects] call DICT_fnc_set;

_center = [20607.5, 18809.5];
_objects = [
	["Land_CzechHedgehog_01_F",[-5.69531,-3.35156,0],297.734,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-8,-3.57422,-0.0530128],51.5271,1,0,[0.430711,-0.440131],"","",true,false],
	["Land_CzechHedgehog_01_F",[-6.90625,5.82227,0],248.301,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-7.5,11.6836,0.000331879],302.35,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[2.65234,-16.5762,0],235.547,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[5.08398,-17.25,0.00845337],301.252,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[13.5059,-12.1113,0.00302124],341.381,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[4.12305,20.9375,-0.144909],57.3781,1,0,[-1.1224,-1.18612],"","",true,false],
	["Land_CzechHedgehog_01_F",[-8.44727,22.1289,0],297.734,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[1.87109,25.6074,0.00968933],169.644,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-8.8125,24.8887,0.0103226],165.088,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-17.7578,23.4121,0.154675],10.5462,1,0,[-2.62026,1.14495],"","",true,false],
	["Land_Razorwire_F",[-25.2969,-12.8711,0.0298958],230.15,1,0,[1.06625,0.204484],"","",true,false],
	["Land_Razorwire_F",[-32.543,-4.61914,0.114296],233.736,1,0,[1.34723,1.19043],"","",true,false]
];
[_dict, "AS_outpost_8", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_8", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_8", "objects", _objects] call DICT_fnc_set;

_center = [20942.7, 19347.5];
_objects = [
	["Land_PortableLight_double_F",[-4.54492,-3.50195,0.00286102],160.058,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-4.35156,3.83203,0.0149784],189.88,1,0,[0.601957,0.104842],"","",true,false],
	["Land_Razorwire_F",[-33.7715,19.6465,2.14866],237.344,1,0,[7.02167,16.7593],"","",true,false],
	["Snake_random_F",[-28.9004,-32.5918,0.00834656],45.2702,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-45.8711,0.0273438,0.00838757],138.895,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[51.7656,25.2422,0.00839233],148.217,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[-63.8145,28.3223,0.00745583],196.034,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[44.7324,-64.416,-1.90735e-006],39.9932,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[70.5703,-45.7813,0.00670433],129.759,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[52.8438,-67.3301,-1.90735e-006],341.812,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[61.6582,-64.375,-1.90735e-006],341.812,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[82.5742,-39.752,0.00066185],150.179,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[68.1211,-62.6035,0],275.344,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[53.918,-80.0313,-1.90735e-006],343.02,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[49.6602,-82.8945,-1.90735e-006],76.7315,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[64.998,-76.6992,-1.90735e-006],343.02,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[71.4629,-75.7539,0],232.794,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[94.9336,-46.8164,-0.00962925],60.3315,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[97.2813,-50.5742,-0.00200844],36.6326,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-3.9375,-109.754,0.0521774],33.9166,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[48.5547,-102.582,0],294.894,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[112.039,-63.9707,-0.0187263],49.5697,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-93.7598,-93.0586,-0.00515938],143.694,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-97.6543,-91.4805,-0.0149879],296.05,1,0,[8.69384,-0.47924],"","",true,false],
	["Land_Razorwire_F",[119.305,-76.0293,-0.24235],219.159,1,0,[1.6991,-1.96487],"","",true,false],
	["Land_PortableLight_double_F",[122.631,-78.9082,0.00600624],300.932,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[120.855,-88.5,-0.0131207],263.072,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-12.5215,-151.781,0],48.7838,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-17.834,-177.434,0.00808811],269.987,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-18.3398,-196.914,0.0220757],77.3833,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[58.8262,-189.066,0],294.894,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-25.2246,-201.861,0.733788],196.751,1,0,[-4.9204,5.76615],"","",true,false],
	["Land_Razorwire_F",[-130.486,-164.146,-0.658212],159.392,1,0,[1.95763,-5.62617],"","",true,false],
	["Land_Razorwire_F",[77.0898,-211.074,-0.0750065],75.2354,1,0,[0.812493,-0.214146],"","",true,false],
	["Land_Razorwire_F",[90.0938,-212.182,0.401085],287.125,1,0,[1.45562,3.3226],"","",true,false],
	["Land_PortableLight_double_F",[79.5703,-217.697,-0.00404549],339.328,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[89.4219,-217.641,-0.0182343],14.0858,1,0,[0,0],"","",true,false]
];
[_dict, "AS_base_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_2", "objects", _objects] call DICT_fnc_set;

_center = [20690.1, 19460.6];
_objects = [
	["Land_Razorwire_F",[47.3105,-21.873,0.145392],309.919,1,0,[-8.79595,1.2478],"","",true,false],
	["Land_Razorwire_F",[52.8438,-15.0098,0.208267],306.606,1,0,[-8.69592,1.86423],"","",true,false],
	["Land_Razorwire_F",[42.0117,47.9434,-0.405985],39.1153,1,0,[0.14673,-3.32521],"","",true,false],
	["Land_Razorwire_F",[-10.9531,-67.6934,-0.324378],358.338,1,0,[0.151339,-2.67734],"","",true,false],
	["Land_CzechHedgehog_01_F",[-3.24219,73.6855,0],325.736,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[73.043,16.3848,0],308.045,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-1.27148,81.5879,-0.896856],45.396,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-82.2441,-22.9297,-0.0338672],267.063,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-66.5195,-55.166,-0.0056448],314.133,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-73.8359,-50.1914,0.00631094],92.8837,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-90.2988,-21.4824,-0.0276611],0,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-98.0078,-16.2754,-1.56595],89.1946,1,0,[0,0],"","",true,false]
];
[_dict, "AS_seaport_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_seaport_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_seaport_3", "objects", _objects] call DICT_fnc_set;

_center = [20577.1, 20104.2];
_objects = [
	["Land_PortableLight_double_F",[2.58008,-2.11719,0.0115204],48.9712,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-2.88281,4.50195,0.0416031],64.8291,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[9.67773,-4.21875,0.136749],207.494,1,0,[-0.00850415,0.512365],"","",true,false],
	["Land_Razorwire_F",[-3.17578,8.03516,0.023407],251.875,1,0,[-4.96674,0.263433],"","",true,false],
	["Land_Razorwire_F",[9.0918,-11.7949,-2.13597],301.165,1,0,[11.7051,-19.7635],"","",true,false],
	["Land_CzechHedgehog_01_F",[5.96289,-16.2227,0.0506172],115.309,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[4.7793,-17.3379,0.00231552],111.994,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[14.9395,13.4941,0],186.05,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[19.3809,11.2109,0],253.212,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[4.62109,-20.8438,0.147964],100.607,1,0,[-0.388439,1.24829],"","",true,false],
	["Land_CzechHedgehog_01_F",[24.4824,11.6758,0],32.9992,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[2.66797,-27.125,0.00852966],82.8548,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-15.373,24.2441,0.00786591],262.949,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[3.39063,-28.9121,0],101.486,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[40.4863,-6.07422,1.93695],99.507,1,0,[-3.59739,14.9284],"","",true,false],
	["Land_Razorwire_F",[38.4375,-14.5352,1.38955],104.885,1,0,[1.38255,10.3708],"","",true,false],
	["Land_Razorwire_F",[44.8516,1.65039,0.101082],126.209,1,0,[-1.06624,1.5859],"","",true,false],
	["Land_Razorwire_F",[36.5059,-22.7402,0.140484],94.9775,1,0,[-0.340862,1.27368],"","",true,false],
	["Land_Razorwire_F",[42.3848,21.1367,-0.0897713],41.1887,1,0,[-0.05023,-0.754209],"","",true,false],
	["Land_Razorwire_F",[34.2168,-35.4023,-0.154816],283.625,1,0,[2.16139,-0.812061],"","",true,false],
	["Land_Razorwire_F",[51.0547,8.69336,-0.165615],134.125,1,0,[-1.31976,-1.4916],"","",true,false],
	["Snake_random_F",[-39.3457,-32.9512,0.00839233],110.786,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[48.6465,15.4121,0.135761],41.1828,1,0,[-1.22854,1.05652],"","",true,false],
	["Rabbit_F",[-32.207,-59.998,-0.00497055],245.384,1,0,[0,0],"","",true,false],
	["Snake_random_F",[76.7109,-16.0059,0.00838089],12.4094,1,0,[0,0],"","",true,false],
	["Rabbit_F",[10.7207,78.7305,0.00923347],214.55,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_9", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_9", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_9", "objects", _objects] call DICT_fnc_set;

_center = [22983.1, 18850.4];
_objects = [
	["Land_Razorwire_F",[7.57227,10.5039,-0.0984883],113.098,1,0,[-2.54756,-0.838249],"","",true,false],
	["Land_Razorwire_F",[-10.5625,-9.44531,0.225695],331.808,1,0,[1.48642,1.80279],"","",true,false],
	["Land_Cargo_Tower_V2_F",[-3.41211,2.90625,0],40.1779,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[10.3145,18.916,-0.0251927],104.625,1,0,[-1.99816,-0.206217],"","",true,false],
	["Land_Razorwire_F",[-18.9551,-11.8105,0.178915],348.377,1,0,[1.6872,1.75868],"","",true,false],
	["Snake_random_F",[17.0488,11.9629,0.00843191],180.528,1,0,[0,0],"","",true,false],
	["Snake_random_F",[22.9063,4.80469,0.00835562],319.774,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[11.0352,27.4629,0.00866032],89.7104,1,0,[-1.06895,0.0820027],"","",true,false],
	["Land_Razorwire_F",[-28.457,-13.0547,0.053997],357.563,1,0,[1.38985,0.323339],"","",true,false],
	["Land_Razorwire_F",[9.62891,36.0586,0.0115209],74.7841,1,0,[-0.44194,0.120206],"","",true,false],
	["Land_Razorwire_F",[-38.6484,-2.71484,0.0752063],66.0517,1,0,[-0.0619683,0.612358],"","",true,false],
	["Snake_random_F",[41.3926,7.375,0.00838304],50.1799,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[8.13086,44.6133,0.0220723],77.9992,1,0,[-0.416796,0.243942],"","",true,false],
	["Rabbit_F",[44.4238,6.71875,0.00201774],37.2825,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-31.4023,-44.3438,0.00707459],45.0739,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-33.7891,42.5957,-0.0339141],145.368,1,0,[-0.661595,-0.285662],"","",true,false],
	["Land_PortableLight_double_F",[-43.7285,37.5254,-0.00486135],108.818,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-51.0703,29.1914,0.0121469],84.0912,1,0,[-1.63987,0.476578],"","",true,false],
	["Land_PortableLight_double_F",[-53.5039,32.8633,-0.00282192],129.591,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[-44.6855,52.9941,0.00647402],225.087,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-49.002,59.0332,0.0253854],222.522,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-81.3945,11.7813,0.0272841],311.227,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Large_F",[83.5664,-25.084,0],178.774,1,0,[0,-0],"","",true,false],
	["Land_BagBunker_Large_F",[30.9375,-173.129,0],90.908,1,0,[0,-0],"","",true,false],
	["Land_BagBunker_Small_F",[214.111,73.4082,0],225.165,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Large_F",[235.352,-199.406,0.17834],270.306,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Large_F",[71.0996,-311.445,0],0.363212,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[209.553,-451.883,0],309.669,1,0,[0,0],"","",true,false]
];
[_dict, "AS_airfield_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield_1", "objects", _objects] call DICT_fnc_set;

_center = [21948.6, 21000.9];
_objects = [
	["Land_CzechHedgehog_01_F",[4.58789,2.58008,0],71.7046,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[1.66406,5.77539,0],106.397,1,0,[0,-0],"","",true,false],
	["Land_BagFence_End_F",[11.2012,9.36328,0.0017128],48.3593,1,0,[0,0],"","",true,false],
	["Land_BagFence_End_F",[8.31641,12.1387,0.00318527],214.479,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[11.5762,10.8359,-0.0106316],43.0579,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[9.50195,12.7051,-0.00103569],224.172,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[15.1973,9.13281,-0.00105476],14.6558,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[7.48242,16.4219,-0.00110245],251.378,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[5.00391,19.0352,-0.00714684],29.6094,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[2.24805,20.4063,-0.00146484],207.733,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[24.7734,-3.05273,-0.000900269],238.246,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-5.42188,24.5527,0.000354767],29.5991,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[19.9082,12.8906,-0.00157166],45.7562,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[10.957,21.0645,-0.00253105],219.713,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[26.4512,-5.51367,-0.0872917],56.2441,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-8.08008,26,0.0391998],208.469,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[10.709,26.9707,0],25.7059,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[26.0313,13.2246,0],55.561,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[5.69727,28.916,-0.0820808],28.503,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-14.8672,29.6191,-0.0123425],27.2918,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[2.98633,30.2891,-0.0108719],207.229,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[31.0801,-12.9648,-0.0105209],237.225,1,0,[0,0],"","",true,false],
	["Land_BagFence_Corner_F",[-17.0215,30.7891,0.0213928],210.362,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[33.3965,-13.5059,0.0277996],148.03,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-16.0039,32.707,-0.0149937],297.828,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-8.51953,36.4922,0.105507],28.4028,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[38.5098,-7.95117,0.370499],237.225,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-11.1602,37.9219,0.0220795],208.251,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[40.8945,-8.47656,11.9763],148.03,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-11.8418,40.2012,-0.17762],297.446,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-24.0566,43.7246,0.00851822],190.623,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[45.1836,27.7441,0],237.413,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[42.4844,31.8574,0],237.413,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[23.6758,47.541,0],208.452,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[35.7754,39.2637,0],222.572,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_Long_F",[28.1191,45.1992,0],207.512,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[40.1543,41.4395,0.0334015],223.893,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[63.2285,37.0938,0.00868225],279.474,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[49.5371,56.9023,0],111.335,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[52.3105,54.6602,0],227.791,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[73.2383,29.1113,0],269.986,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-56.5938,-62.7188,0],51.1675,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[68.8672,51.1875,0.334166],146.269,1,0,[-0.145944,2.66859],"","",true,false],
	["Land_CzechHedgehog_01_F",[-70.1035,-53.582,0],114.097,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-53.9355,-73.9023,0],168.593,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[75.832,60.0098,0.0162182],220.432,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[65.8164,72.207,0.00297737],243.697,1,0,[-4.33118,-0.49672],"","",true,false],
	["Land_PortableLight_double_F",[69.4727,69.6602,-0.00647545],246.276,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-83.4902,-56.3047,0.969635],39.2416,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-64.3086,-85.9707,0],232.455,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpost_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_4", "objects", _objects] call DICT_fnc_set;

_center = [23553.4, 21115.9];
_objects = [
	["Land_Razorwire_F",[31.7031,28.1465,-0.608604],191.043,1,0,[-0.15862,-5.15522],"","",true,false],
	["Land_Razorwire_F",[39.707,24.4316,-0.0139236],208.4,1,0,[4.71103,-0.0591208],"","",true,false],
	["Land_Razorwire_F",[13.0977,46.6094,0.215004],78.9992,1,0,[2.05819,1.77816],"","",true,false],
	["Snake_random_F",[-17.0234,46.791,0],0.679389,1,0,[-0.989314,-0.317335],"","",true,false],
	["Land_PortableLight_double_F",[11.2246,50.4668,-0.00120544],210.267,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-11.8867,53.2461,0.646698],337.105,1,0,[-2.98185,6.06661],"","",true,false],
	["Land_PortableLight_double_F",[-4.53125,55.1953,-0.0163116],186.114,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-55.5801,-14.4551,0],205.194,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[49.0195,-35.7168,0],195.604,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[47.0039,-40.8457,-0.0158539],30.9495,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[62.5996,-20.0313,-0.000137329],228.112,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-70.8223,-2.5332,-0.0426102],130.999,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-64.8652,-32.9336,0],24.9316,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[48.8711,-59.5469,-1.4988],310.39,1,0,[-2.19421,-13.1655],"","",true,false],
	["Land_Razorwire_F",[-50.5703,65.4727,-0.0754776],172.019,1,0,[-2.63276,-0.634246],"","",true,false],
	["Land_Razorwire_F",[-59.1777,64.0879,-0.33342],164.638,1,0,[-1.16435,-3.08377],"","",true,false],
	["Land_Razorwire_F",[81.2832,-66.4648,1.60132],56.7775,1,0,[5.99309,12.5667],"","",true,false],
	["Land_Razorwire_F",[-112.707,13.2012,-0.114014],21.6541,1,0,[7.09026,-0.973952],"","",true,false],
	["Land_CzechHedgehog_01_F",[-104.982,47.1172,0],227.663,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-109.02,43.0742,0],54.838,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-117.334,14.416,0.0286636],95.7465,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[88.0938,-76.1348,1.22995],55.3608,1,0,[4.26102,10.3089],"","",true,false],
	["Land_Razorwire_F",[-97.3242,67.334,-0.521942],208.051,1,0,[3.00533,-5.30697],"","",true,false],
	["Land_PortableLight_double_F",[-121.021,22.6914,0.0296402],84.0057,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-125.367,27.9297,-0.512672],19.4002,1,0,[11.1421,-3.97918],"","",true,false],
	["Land_Razorwire_F",[96.0215,-84.832,0.960869],31.676,1,0,[3.91374,7.71207],"","",true,false],
	["Land_Razorwire_F",[-121.146,55.6289,0.454926],97.9619,1,0,[9.93984,3.25221],"","",true,false],
	["Land_Razorwire_F",[103.623,-91.6328,1.11461],54.7581,1,0,[-0.75707,9.51947],"","",true,false],
	["Land_Razorwire_F",[180.516,-8.5625,-0.507996],208.217,1,0,[8.74574,-3.97926],"","",true,false],
	["Land_Razorwire_F",[147.688,-115.553,1.54009],185.808,1,0,[-5.72892,11.8007],"","",true,false],
	["Land_Razorwire_F",[188.379,-11.8105,-1.35849],194.916,1,0,[7.575,-11.5287],"","",true,false],
	["Land_PortableLight_double_F",[145.973,-117.301,0.0697098],18.0153,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[158.986,-102.26,0.0105667],71.8895,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[191.994,-13.4199,0.0325623],236.485,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[173.207,-94.9238,-0.00676727],211.975,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[196.371,-20.1328,-0.0272064],242.73,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[182.17,-92.4902,-0.0678864],183.234,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[204.916,-51.1992,0.723595],106.389,1,0,[-4.00033,5.96659],"","",true,false],
	["Land_Razorwire_F",[202.9,-63.0156,1.24392],97.3774,1,0,[-9.47377,9.08455],"","",true,false],
	["Land_Razorwire_F",[200.299,-77.0547,-2.11379],96.7047,1,0,[6.56666,-19.7148],"","",true,false],
	["Land_Razorwire_F",[196.42,-88.3184,-1.21868],109.188,1,0,[10.4852,-9.88084],"","",true,false]
];
[_dict, "AS_base_3", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_base_3", "center", _center] call DICT_fnc_set;
[_dict, "AS_base_3", "objects", _objects] call DICT_fnc_set;

_center = [25377.4, 20308.9];
_objects = [
	["Land_Razorwire_F",[4.60938,-3.16406,-0.0716286],140.515,1,0,[-1.34571,-0.672691],"","",true,false],
	["Land_PortableLight_double_F",[-7.84766,0.408203,-0.00208759],110.302,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[-2.40234,-7.62305,-0.00483513],346.028,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[9.88477,-25.4941,-0.117848],58.1932,1,0,[-0.789762,-1.12798],"","",true,false],
	["Land_CzechHedgehog_01_F",[-15.0332,25.5488,0],228.122,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[22.7246,24.2734,-0.00227642],10.166,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-12.9082,30.9609,0],47.5458,1,0,[0,0],"","",true,false],
	["Snake_random_F",[26.0488,-41.6055,0.0084362],98.3865,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-33.4766,36.4883,0.0085001],179.258,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[53.3887,-5.09961,0.00840664],150.342,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[39.5977,-37.0293,0.0442944],329.628,1,0,[0.0232123,0.340134],"","",true,false],
	["Land_Razorwire_F",[54.4492,-28.0762,0.435463],327.303,1,0,[-0.184975,3.38479],"","",true,false],
	["Land_Razorwire_F",[-8.17188,64.2695,0.249396],137.772,1,0,[-6.82696,1.76273],"","",true,false],
	["Land_PortableLight_double_F",[70.9707,3.13477,0.00169373],108.69,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[89.6816,29.4277,-0.00545979],240.479,1,0,[1.31786,-0.307902],"","",true,false],
	["Land_Razorwire_F",[47.4414,97.9922,-0.0922623],236.062,1,0,[-2.01674,-0.944262],"","",true,false]
];
[_dict, "AS_factory_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_factory_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_factory_5", "objects", _objects] call DICT_fnc_set;

_center = [25308.8, 21813.5];
_objects = [
	["Land_CzechHedgehog_01_F",[2.24805,-3.73438,0],73.2876,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-2.14844,-35.6309,-0.497589],237.385,1,0,[0.157387,-4.71555],"","",true,false],
	["Land_Razorwire_F",[14.0273,-33.6094,-0.593742],237.341,1,0,[0.66942,-5.04381],"","",true,false],
	["Land_PortableLight_double_F",[1.76758,-41.0684,0.0047226],278.8,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[15.7461,-38.3457,0.0196533],325.583,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[-23.5703,43.0137,0],187.554,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-2.39258,48.4277,0.00860596],201.434,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-15.5527,46.5723,-0.339012],187.449,1,0,[-0.041612,-2.62309],"","",true,false],
	["Snake_random_F",[-6.86328,50.5273,0.00801849],282.46,1,0,[0,0],"","",true,false],
	["Snake_random_F",[51.1172,2.91992,0.00772858],52.4806,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-24.5332,47.8086,-0.577873],186.551,1,0,[1.80664,-5.00981],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[-113.527,8.50391,0],70.1809,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-118.398,9.34766,0.616524],68.7348,1,0,[-2.42215,4.94769],"","",true,false]
];
[_dict, "AS_outpostAA_6", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_6", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_6", "objects", _objects] call DICT_fnc_set;

_center = [27044.5, 21458.9];
_objects = [
	["Land_Razorwire_F",[0.0898438,-4.95313,0.0156479],42.4744,1,0,[2.38317,0.110531],"","",true,false],
	["Land_Razorwire_F",[-7.90234,3.70898,0.0674934],48.7739,1,0,[2.29228,0.529666],"","",true,false],
	["Land_PortableLight_double_F",[6.36523,-11.1504,0.00604057],23.2869,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[14.2344,3.22266,0.280462],114.623,1,0,[0.727009,2.26481],"","",true,false],
	["Land_PortableLight_double_F",[13.4668,-4.98242,0.0116634],252.713,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[19.9063,10.0996,0.295055],136.258,1,0,[0.272314,2.38244],"","",true,false],
	["Land_PortableLight_double_F",[-16.3672,12.9238,0.0114479],281.837,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[26.7852,16.9297,0.266199],133.23,1,0,[0.391009,2.14895],"","",true,false],
	["Snake_random_F",[19.707,-35.6211,0.00834846],45.0231,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-39.1816,-12.1055,0.00833511],92.0524,1,0,[0,-0],"","",true,false],
	["Land_PortableLight_double_F",[31.7852,26.957,-0.00247002],181.671,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-45.0391,-3.60742,0.00845337],255.17,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[1.48633,57.8789,-0.00230026],277.62,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-61.9297,-5.29688,0.15206],20.2264,1,0,[1.86664,1.33977],"","",true,false],
	["Land_Razorwire_F",[44.9688,42.5527,0.0951195],70.2936,1,0,[0.910097,0.728711],"","",true,false],
	["Land_Razorwire_F",[12.2344,130.004,-0.0123539],252.847,1,0,[-0.578252,-0.0611701],"","",true,false],
	["Land_Razorwire_F",[-145.766,41.8789,0.312096],46.2182,1,0,[2.59533,2.37702],"","",true,false],
	["Land_Razorwire_F",[-100.139,116.725,0.149368],137.966,1,0,[-2.80865,0.989192],"","",true,false],
	["Land_Razorwire_F",[-46.7598,159.055,-0.102448],142.177,1,0,[-3.15943,-0.834834],"","",true,false]
];
[_dict, "AS_powerplant_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_powerplant_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_powerplant_1", "objects", _objects] call DICT_fnc_set;

_center = [26412.4, 22155.7];
_objects = [
	["Land_CzechHedgehog_01_F",[-5.54297,-10.1641,0],86.0996,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[-6.41602,-12.5313,0.003685],17.732,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-12.4805,-8.20313,-0.505371],35.4092,1,0,[1.52709,-4.25024],"","",true,false],
	["Land_PortableLight_double_F",[13.5,-6.87305,0.00211334],193.755,1,0,[0,0],"","",true,false],
	["Land_HelipadSquare_F",[-8.6543,12.6465,0],304.185,1,0,[-5.12062,0.206702],"","",true,false],
	["Land_CzechHedgehog_01_F",[13.6602,-8.76953,0],86.0996,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[17.834,-3.26563,-0.0182419],126.82,1,0,[2.09244,-0.246],"","",true,false],
	["Land_PortableLight_double_F",[5.60352,-16.7227,0.0115509],59.459,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[7.19727,-16.627,0.00737],179.214,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-22.1289,-1.42578,-0.536987],35.4222,1,0,[0.285952,-4.47887],"","",true,false],
	["Land_Razorwire_F",[4.95898,-19.832,0.125374],129.083,1,0,[1.84137,1.00373],"","",true,false],
	["Land_CzechHedgehog_01_F",[13.7148,18.1113,-0.00582886],86.0996,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[23.8594,4.80273,-0.100761],126.809,1,0,[2.06146,-0.842026],"","",true,false],
	["Land_PortableLight_double_F",[16.7422,18.252,0.00398254],226.664,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[8.86523,23.9785,-0.468437],35.5336,1,0,[-2.50031,-3.85197],"","",true,false],
	["Land_Razorwire_F",[0.921875,-27.709,-0.0446396],90.9394,1,0,[1.84139,-0.504363],"","",true,false],
	["Land_Razorwire_F",[-0.744141,30.7773,-0.647194],35.4225,1,0,[-0.84941,-5.37997],"","",true,false],
	["Land_Cargo_Patrol_V2_F",[5.86328,-28.6641,0],88.0721,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[29.4297,11.9688,-0.168686],126.808,1,0,[1.87762,-1.36127],"","",true,false],
	["Land_Razorwire_F",[-31.4941,5.45313,-0.55933],35.4254,1,0,[-0.130895,-4.682],"","",true,false],
	["Land_Razorwire_F",[-29.8184,15.4805,-0.0579224],122.599,1,0,[4.85719,-0.513549],"","",true,false],
	["Land_Razorwire_F",[-23.1172,25.7168,-0.0782814],123.438,1,0,[5.03227,-0.69655],"","",true,false],
	["Land_CzechHedgehog_01_F",[-34.2988,8.41992,0],132.574,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[13.0371,34.0957,0.00815582],184.067,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-10.1113,37.6641,-0.61121],35.4387,1,0,[-1.0254,-5.13281],"","",true,false],
	["Land_Razorwire_F",[3.79297,-36.2754,-0.144455],43.7836,1,0,[1.10745,-1.26616],"","",true,false],
	["Land_Razorwire_F",[-16.5723,35.5488,-0.0904884],123.432,1,0,[5.07409,-0.760617],"","",true,false],
	["Land_Razorwire_F",[40.6113,2.33008,-0.167419],127.134,1,0,[1.4883,-1.45973],"","",true,false],
	["Land_Razorwire_F",[38.0586,-5.30078,-0.162003],57.1497,1,0,[-0.484894,-1.59602],"","",true,false],
	["Land_CzechHedgehog_01_F",[-13.1875,39.707,-0.00155258],218.23,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-20.543,37.8203,0.0183525],180.889,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[37.2031,22.6387,0],95.9665,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[10.9102,-42.7383,0.0226212],49.0009,1,0,[0.488567,-0.0203218],"","",true,false],
	["Land_PortableLight_double_F",[47.7031,17.2188,0.00171661],113.668,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[18.1172,-49.6445,0.232773],30.4103,1,0,[1.31442,1.83437],"","",true,false],
	["Snake_random_F",[-20.6875,-50.9688,0.00830078],200.596,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-42.9395,34.2871,-0.000419617],1.82692,1,0,[0,0],"","",true,false],
	["Rabbit_F",[9.04883,62.5508,0.000873566],18.8497,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[27.0723,-56.5059,-0.0386124],43.7062,1,0,[3.28581,-0.345625],"","",true,false],
	["Land_BagBunker_Small_F",[33.8535,-55.6816,-0.00989532],20.243,1,0,[1.08189,1.70173],"","",true,false],
	["Snake_random_F",[55.125,40.791,0.00849152],66.0551,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[38.8828,-59.4551,-0.112656],173.144,1,0,[-1.73812,-1.02236],"","",true,false],
	["Rabbit_F",[28.3242,66.0645,-0.00561142],6.1476,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[64.7227,-31.2617,0.278687],38.1344,1,0,[0.270825,2.25189],"","",true,false],
	["Land_Razorwire_F",[49.7988,-56.502,-0.211021],163.53,1,0,[-3.35211,-0.842454],"","",true,false],
	["Land_Razorwire_F",[58.6074,-52.8281,-0.0399551],152.878,1,0,[-4.33722,-0.440385],"","",true,false],
	["Land_BagBunker_Small_F",[72.9551,-41.8652,-0.0258408],274.732,1,0,[2.9116,-2.74622],"","",true,false],
	["Land_Razorwire_F",[74.0254,-37.5059,0.465652],26.0521,1,0,[1.19413,3.81328],"","",true,false],
	["Land_Razorwire_F",[73.7813,-47.2656,-0.10585],158.444,1,0,[-4.47178,-0.94638],"","",true,false],
	["Rabbit_F",[73.084,-59.8535,-0.0119743],138.793,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_outpost_24", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_24", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_24", "objects", _objects] call DICT_fnc_set;

_center = [26792.7, 24583.7];
_objects = [
	["Snake_random_F",[-46.1602,19.5469,0.00841713],80.9511,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[-61.7715,-3.07813,0],37.3708,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-65.8145,-4.84375,-0.342003],41.1101,1,0,[-2.40213,-2.70454],"","",true,false],
	["Land_Razorwire_F",[-77.1641,5.18555,-0.0844078],41.0755,1,0,[-1.02197,-0.687503],"","",true,false],
	["Land_Razorwire_F",[-83.8574,10.5645,-0.151537],40.2068,1,0,[-1.96523,-1.46066],"","",true,false],
	["Land_Cargo_Tower_V1_F",[68.3809,54.502,0],37.9142,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-84.8945,77.6797,-0.344587],127.932,1,0,[7.45016,-3.84044],"","",true,false],
	["Land_Razorwire_F",[-90.6621,71.6016,-0.0653725],139.295,1,0,[6.22286,-0.820596],"","",true,false],
	["Land_Razorwire_F",[-97.3672,66.502,0.521633],145.583,1,0,[4.28262,4.09291],"","",true,false],
	["Land_Razorwire_F",[-104.738,61.5352,0.162085],149.723,1,0,[3.36843,0.776083],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[55.5313,-110.303,0],310.668,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[51.7813,-113.281,0.218876],220.476,1,0,[1.64329,1.6039],"","",true,false],
	["Land_Razorwire_F",[61.8438,-110.627,-0.0930347],139.214,1,0,[1.40589,-0.709029],"","",true,false],
	["Land_CzechHedgehog_01_F",[55.7266,-115.234,0],86.0996,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[65.5332,-111.916,0.00172424],225.761,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[56.2168,-116.955,-0.00332451],5.82819,1,0,[0,0],"","",true,false]
];
[_dict, "AS_airfield_2", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_airfield_2", "center", _center] call DICT_fnc_set;
[_dict, "AS_airfield_2", "objects", _objects] call DICT_fnc_set;

_center = [27600.1, 24585.9];
_objects = [
	["Land_CzechHedgehog_01_F",[-10.082,-3.2207,-0.00265646],63.3514,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V2_F",[8.05273,-14.5723,0],340.053,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-18.498,0.00195313,0],31.3583,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[13.4375,14.1445,-0.0247068],300.681,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[39.5625,14.9785,-0.248637],0.711233,1,0,[9.8702,-2.97514],"","",true,false],
	["Land_CzechHedgehog_01_F",[40.4258,18.002,0],273.635,1,0,[0,0],"","",true,false],
	["Mullet_F",[33.7773,-36.9004,-1.92502],42.3471,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[50.4551,7.83789,0.256271],60.6203,1,0,[0.0836862,1.70577],"","",true,false],
	["Land_Razorwire_F",[-51.2773,1.3125,0.238602],135.708,1,0,[-0.938813,1.66264],"","",true,false],
	["Land_PortableLight_double_F",[-50.832,13.0215,-0.00232553],173.105,1,0,[0,-0],"","",true,false],
	["Land_CzechHedgehog_01_F",[51.7715,10.5664,0],31.3583,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-53.4355,7.74023,0.246595],118.794,1,0,[-0.414434,1.86366],"","",true,false],
	["Land_CzechHedgehog_01_F",[54.9941,5.25586,0],71.7997,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-58.7637,-1.77539,0.482934],118.845,1,0,[-0.123139,4.02464],"","",true,false],
	["Land_CzechHedgehog_01_F",[-63.3281,-10.25,0],50.6034,1,0,[0,0],"","",true,false],
	["Land_CzechHedgehog_01_F",[-72.625,-30.3594,0],94.5018,1,0,[0,-0],"","",true,false],
	["Land_Razorwire_F",[-74.4707,-34.3301,0.53774],0.855964,1,0,[0.472023,4.20183],"","",true,false],
	["Land_PortableLight_double_F",[-77.3359,-36.3164,0.000189781],50.7048,1,0,[0,0],"","",true,false]
];
[_dict, "AS_seaport_4", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_seaport_4", "center", _center] call DICT_fnc_set;
[_dict, "AS_seaport_4", "objects", _objects] call DICT_fnc_set;

_center = [28309.7, 25787.7];
_objects = [
	["Land_Shoot_House_Wall_F",[2.91211,-0.160156,-0.327093],148.341,1,0,[-1.12658,-1.10014],"","",true,false],
	["Land_Shoot_House_Wall_F",[2.80078,0.107422,0],148.335,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-4.73633,-4.98047,0],148.335,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-6.63477,-8.3457,-0.327839],148.336,1,0,[-0.200295,-0.324755],"","",true,false],
	["Land_BagFence_Short_F",[-5.73242,-6.79688,-0.00111771],237.978,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-6.26953,-8.54883,-0.00777054],148.915,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Short_F",[-7.9043,-8.2207,-0.00106621],238.177,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-8.91016,-9.9082,0],148.335,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Short_F",[-10.9434,-10.0605,0.00354004],237.529,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-17.9238,4.50195,-2.86102e-006],331.216,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-11.4766,-11.6992,-0.00502205],327.765,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[-13.1953,-11.4023,-0.000967026],237.978,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-15.3867,-11.4824,0],148.335,1,0,[0,-0],"","",true,false],
	["Land_Shoot_House_Wall_F",[-17.9277,-13.1133,-0.268873],146.213,1,0,[0.168538,-0.572454],"","",true,false],
	["Land_Razorwire_F",[16.8203,20.791,0.23948],38.205,1,0,[-7.2086,2.28911],"","",true,false],
	["Land_Razorwire_F",[3.91602,-30.7871,-0.400758],174.696,1,0,[0.879704,-2.91846],"","",true,false],
	["Land_Razorwire_F",[35.8359,5.82422,0.601808],37.5174,1,0,[-9.95474,4.93123],"","",true,false],
	["Land_Razorwire_F",[-33.2422,-22.2207,-0.643774],125.498,1,0,[0.0227516,-5.68892],"","",true,false],
	["Land_Razorwire_F",[-24.1797,-38.5293,0.1478],271.082,1,0,[0.902119,0.781051],"","",true,false],
	["Land_PortableLight_double_F",[-36.3008,-28.9355,0.00682259],328.375,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[39.0137,-29.1289,-0.0520601],176.854,1,0,[-0.105819,-0.529484],"","",true,false],
	["Land_PortableLight_double_F",[-22.6836,-44.248,-0.00199127],351.229,1,0,[0,0],"","",true,false],
	["Rabbit_F",[30.25,44.8965,0.00940418],135.162,1,0,[0,-0],"","",true,false],
	["Snake_random_F",[-10.0117,-61.7852,0.00841331],132.999,1,0,[0,-0],"","",true,false],
	["Rabbit_F",[18.3516,60.5469,0.00827694],315.017,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-43.4512,-54.8223,0.00736237],310.997,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-57.2363,-41.0938,0.00835419],263.865,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-44.0469,-72.9531,-0.012291],44.8607,1,0,[0,0],"","",true,false],
	["Rabbit_F",[-88.3379,-30.2578,0.0289669],171.351,1,0,[0,-0],"","",true,false]
];
[_dict, "AS_outpost_5", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpost_5", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpost_5", "objects", _objects] call DICT_fnc_set;

_center = [14889.1, 11088.1];
_objects = [
	["Land_BagBunker_Small_F",[-4.71777,5.03711,-0.00539875],131.691,1,0,[0.564397,0.400115],"","",true,false],
	["Land_Razorwire_F",[-9.22949,7.13574,-0.00231457],317.228,1,0,[-0.52316,-0.452706],"","",true,false],
	["Land_Razorwire_F",[-2.68848,13.3193,-0.0205584],311.601,1,0,[-0.342485,-0.304086],"","",true,false],
	["Land_Razorwire_F",[-20.4316,-6.76855,0.588001],311.831,1,0,[-1.40072,4.88576],"","",true,false],
	["Land_Razorwire_F",[3.89746,20.4229,-0.00167656],310.06,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-18.2666,-14.6445,0.138196],223.936,1,0,[7.40441,1.41041],"","",true,false],
	["Land_Razorwire_F",[24.1084,-7.01563,-0.0783873],144.969,1,0,[-1.20179,-0.650104],"","",true,false],
	["Land_PortableLight_double_F",[16.9111,-23.1777,-0.0350332],266.817,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[21.54,21.1846,-0.0150185],222.926,1,0,[1.60594,1.07694],"","",true,false],
	["Land_Razorwire_F",[10.4834,27.2715,0.20531],322.244,1,0,[-0.981494,1.72635],"","",true,false],
	["Land_Razorwire_F",[23.5352,24.3799,-0.144957],43.6714,1,0,[-1.9161,-1.0898],"","",true,false],
	["Land_Razorwire_F",[42.5889,9.87012,0.234806],9.87215,1,0,[-1.69492,1.72111],"","",true,false],
	["Snake_random_F",[-26.5791,42.7617,0.00845814],28.1249,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[49.6387,8.76758,0.00939751],235.761,1,0,[0,0],"","",true,false],
	["Land_PortableLight_double_F",[56.252,3.90332,-0.0119905],198.714,1,0,[0,0],"","",true,false]
];
[_dict, "AS_outpostAA_1", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AS_outpostAA_1", "center", _center] call DICT_fnc_set;
[_dict, "AS_outpostAA_1", "objects", _objects] call DICT_fnc_set;

_center = [9136.29,8342.23,0];
_objects = [
	["Land_HBarrier_Big_F",[6.6543,-0.875,-0.00107574],87.1529,1,0,[5.19154,1.5764],"","",true,false], 
	["Land_HBarrier_Big_F",[6.30957,7.44531,-0.00167084],89.0136,1,0,[1.76415,0.428091],"","",true,false], 
	["Land_BagFence_Round_F",[9.80859,-0.00488281,-0.0627441],69.9862,1,0,[1.12844,-2.0363],"","",true,false], 
	["Land_PaperBox_open_full_F",[8.53516,6.47949,0.000236511],0,1,0,[0.458405,-1.75653],"","",true,false], 
	["Land_BagFence_Round_F",[11.8877,-1.16602,-0.00310516],340.291,1,0,[-2.03028,-1.13926],"","",true,false], 
	["Land_Pallet_MilBoxes_F",[8.5498,8.67188,0.00405121],0,1,0,[0.458405,-1.75653],"","",true,false], 
	["Land_BagFence_Round_F",[12.9717,0.993164,0.0537796],249.636,1,0,[-1.11599,2.04315],"","",true,false], 
	["Land_HBarrier_Big_F",[12.0381,-3.97656,0.0280609],181.004,1,0,[-7.38203,5.01794],"","",true,false], 
	["Land_Cargo_Patrol_V1_F",[12.1113,9.06641,0],177,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_Big_F",[9.60254,12.3945,0.00258636],0,1,0,[-0.76387,-4.87784],"","",true,false], 
	["Land_BagFence_Long_F",[17.5703,-4.30176,0.0333557],181.007,1,0,[-6.94095,1.26247],"","",true,false], 
	["Land_HBarrier_5_F",[18.2471,1.01953,-0.0569763],269.123,1,0,[-4.5236,-1.53477],"","",true,false], 
	["Land_BagFence_End_F",[19.9971,-4.35938,0.017395],0,1,0,[6.91802,-1.38481],"","",true,false], 
	["Land_HBarrier_5_F",[18.1602,6.76074,-0.0714722],269.094,1,0,[-2.8556,-1.86423],"","",true,false], 
	["Land_BagFence_Long_F",[20.5068,0.629883,0.133522],181.995,1,0,[-1.75973,4.44151],"","",true,false], 
	["CamoNet_BLUFOR_open_Curator_F",[21.8135,-1.66797,0.914429],0,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[18.0996,13.0625,0.00907135],179,1,0,[-2.92697,2.8795],"","",true,false], 
	["Land_BagFence_Long_F",[23.4395,0.512695,0.0770264],181.998,1,0,[-1.7094,2.99643],"","",true,false], 
	["Land_Cargo_House_V1_F",[23.6465,8.41699,0],0,1,0,[0,0],"","",true,false], 
	["Land_BagFence_End_F",[24.0303,-4.18652,-0.0317688],178.992,1,0,[-7.84019,3.22096],"","",true,false], 
	["Land_BagFence_Long_F",[26.4521,-4.15039,0.0943527],176.977,1,0,[-7.72409,3.49545],"","",true,false], 
	["Land_HBarrier_Big_F",[28.877,-0.210938,0.00062561],91.1545,1,0,[3.07544,2.8867],"","",true,false], 
	["Land_HBarrier_Big_F",[26.334,12.9473,0.00335693],2.97635,1,0,[1.91398,-7.35914],"","",true,false], 
	["Land_HBarrier_Big_F",[28.9883,8.28613,0.00541687],91.2761,1,0,[3.027,5.17303],"","",true,false], 
	["Land_Razorwire_F",[32.832,-4.50586,-0.340569],269.479,1,0,[-3.15835,-2.79569],"","",true,false], 
	["Land_Razorwire_F",[34.4199,1.99414,-0.540657],318.669,1,0,[0.0514943,-4.21384],"","",true,false], 
	["Land_BagFence_Long_F",[36.1855,-1.62109,0.100708],131.678,1,0,[-0.508456,3.32798],"","",true,false], 
	["Land_BagFence_Long_F",[36.2588,-3.72363,-0.0387192],226.608,1,0,[-2.30468,-2.54914],"","",true,false], 
	["Land_Razorwire_F",[34.582,-7.38379,0.0576172],36.5976,1,0,[4.62067,-0.469599],"","",true,false], 
	["Land_Razorwire_F",[-38.0537,-2.09766,0.339897],269.726,1,0,[8.96232,2.55247],"","",true,false], 
	["Land_BagFence_Long_F",[38.1348,0.539063,0.0803146],131.678,1,0,[-0.508456,3.32798],"","",true,false], 
	["Land_BagFence_Long_F",[38.1592,-5.71289,-0.0664825],226.608,1,0,[-2.30468,-2.54914],"","",true,false], 
	["Land_BagFence_Long_F",[40.4189,2.99316,-0.0805969],2.31726,1,0,[4.55703,-3.26253],"","",true,false], 
	["Land_BagFence_Long_F",[40.5039,-8.43359,-0.00987244],2.31824,1,0,[3.42774,0.215728],"","",true,false], 
	["Land_Razorwire_F",[-42.2949,-7.44141,-0.156822],318.418,1,0,[5.14464,-2.01251],"","",true,false], 
	["Land_Razorwire_F",[-42.5859,6.47852,-0.11161],36.8925,1,0,[-8.46857,-1.48754],"","",true,false], 
	["Land_BagFence_Long_F",[-41.6279,-1.58398,0.0703735],312.239,1,0,[1.00296,1.73603],"","",true,false], 
	["Land_BagFence_Long_F",[-41.7285,0.578125,0.0211639],46.0473,1,0,[-4.60053,0.836899],"","",true,false], 
	["Land_BagFence_Long_F",[42.9814,0.520508,0.0469055],46.1641,1,0,[5.53864,0.807965],"","",true,false], 
	["Land_BagFence_Long_F",[43.0068,-5.77832,-0.115532],312.199,1,0,[2.22675,-5.18431],"","",true,false], 
	["Land_Razorwire_F",[39.1377,-14.7598,-0.00222778],359.655,1,0,[6.76776,0.0361489],"","",true,false], 
	["Land_BagFence_Long_F",[-43.6484,2.55762,0.0211639],46.0473,1,0,[-4.60053,0.836899],"","",true,false], 
	["Land_BagFence_Long_F",[-43.5977,-3.69238,-0.0170059],312.018,1,0,[4.89006,-2.57403],"","",true,false], 
	["Land_BagFence_Long_F",[44.8604,-1.45898,0.131096],45.9681,1,0,[1.48183,4.71935],"","",true,false], 
	["Land_BagFence_Long_F",[44.9473,-3.63379,-0.0418396],312.042,1,0,[4.76049,-1.97147],"","",true,false], 
	["Land_Razorwire_F",[44.0781,4.6084,0.438377],37.036,1,0,[9.31256,3.39844],"","",true,false], 
	["Land_BagFence_Long_F",[-46.2109,4.99316,0.157455],2.33044,1,0,[-7.82035,3.60943],"","",true,false], 
	["Land_Razorwire_F",[44.2871,-9.52637,-0.260506],318.418,1,0,[5.00575,-2.3999],"","",true,false], 
	["Land_BagFence_Long_F",[-46.0771,-6.32422,0.0924149],2.32825,1,0,[6.35745,0.95221],"","",true,false], 
	["Land_BagFence_Long_F",[-48.4131,2.60156,0.0961838],131.761,1,0,[4.78411,3.45775],"","",true,false], 
	["Land_BagFence_Long_F",[-48.376,-3.60352,0.0456161],226.934,1,0,[-8.58517,-0.698814],"","",true,false], 
	["Land_Razorwire_F",[48.6113,-4.09082,-0.668015],269.156,1,0,[2.15551,-4.45414],"","",true,false], 
	["Land_BagFence_Long_F",[-50.2754,-1.66602,0.123558],226.378,1,0,[-3.72366,4.49428],"","",true,false], 
	["Land_BagFence_Long_F",[-50.3623,0.44043,0.0918961],131.753,1,0,[4.77847,3.34975],"","",true,false], 
	["Land_Razorwire_F",[-51.9561,-5.25195,-0.0884476],36.784,1,0,[8.57322,-0.836412],"","",true,false], 
	["Land_Razorwire_F",[-52.1162,3.99707,-0.195076],318.582,1,0,[-5.99388,-2.54491],"","",true,false], 
	["Land_Razorwire_F",[-53.71,-2.46582,0.10704],269.252,1,0,[-5.77722,0.763301],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[11.8877,0.147461,-0.0497971],308.589,1,0,[-2.32635,0.0968218],"","",true,false],
	[["CSAT", "self_aa"] call AS_fnc_getEntity,[40.3721,-2.87402,-0.121872],0.0129312,1,0,[2.82822,-1.83257],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[13.3477,7.52344,4.2],149.445,1,0,[0.334842,0.623217],"","",true,false],
	[["CSAT", "self_aa"] call AS_fnc_getEntity,[-46.1152,-0.722656,-0.057579],0.00125647,1,0,[6.39846,-5.78442],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[7.19922,1.52051,0.0274963],217.695,1,0.0152418,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[-11.6289,-5.40039,0],0,1,0,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[4.3418,-1.6709,0.155876],176.582,1,0,[],"","",true,false]

];
[_dict, "Agela", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Agela", "center", _center] call DICT_fnc_set;
[_dict, "Agela", "objects", _objects] call DICT_fnc_set;

_center = [11669.5,7578.51,0];
_objects = [
	["Land_BagFence_Long_F",[-1.0459,4.30664,-0.127701],139.803,1,0,[-0.013102,-4.38634],"","",true,false], 
	["Land_BagFence_End_F",[0.81543,5.8833,-0.0349274],318.775,1,0,[1.60426,2.7565],"","",true,false], 
	["Land_HBarrier_Big_F",[-5.48633,0.706543,0.00202942],139.845,1,0,[0.0788142,-5.45798],"","",true,false], 
	["Land_BagFence_Round_F",[-7.43359,2.95264,0.12944],299.226,1,0,[1.85345,5.13781],"","",true,false], 
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[-8.2832,3.96094,-0.0244293],270.193,1,0,[1.97648,3.59097],"","",true,false], 
	["Land_BagFence_Round_F",[-8.00879,5.28857,0.0503845],208.443,1,0,[3.09453,2.46011],"","",true,false], 
	["CamoNet_BLUFOR_open_Curator_F",[0.316406,9.07471,0.904099],318.72,1,0,[0,0],"","",true,false], 
	["Land_BagFence_End_F",[3.73242,8.65674,0.0376129],137.776,1,0,[-1.65209,-2.72816],"","",true,false], 
	["Land_BagFence_Round_F",[-9.74707,2.4541,0.0233612],28.8114,1,0,[-4.0982,0.0133776],"","",true,false], 
	["Land_BagFence_Long_F",[-2.11133,9.98047,-0.0125732],140.719,1,0,[0.424469,-0.446151],"","",true,false], 
	["Land_HBarrier_Big_F",[-11.6387,-0.459961,0.0146332],45.9343,1,0,[-5.96473,-1.2226],"","",true,false], 
	["Land_BagFence_Long_F",[5.52637,10.2837,-0.0695496],135.777,1,0,[-1.74622,-2.669],"","",true,false], 
	["Land_HBarrier_5_F",[-4.0791,8.75537,0.0157776],227.722,1,0,[0.46773,0.400566],"","",true,false], 
	["Land_BagFence_Long_F",[0.155273,11.834,-0.0286255],140.774,1,0,[-1.50716,-2.81065],"","",true,false], 
	["Land_Razorwire_F",[-12.2646,-0.554199,-0.418701],151.534,1,0,[2.78539,-5.4208],"","",true,false], 
	["Land_HBarrier_Big_F",[4.71973,14.7686,0.0037384],49.7616,1,0,[-2.23783,-1.1073],"","",true,false], 
	["Land_PaperBox_open_full_F",[-14.9814,6.42773,0.00491333],318.651,1,0,[-3.60651,5.82106],"","",true,false], 
	["Land_HBarrier_5_F",[-14.6777,0.0703125,0.101791],150.325,1,0,[7.19035,2.49955],"","",true,false], 
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-12.0127,10.4976,-0.0650635],107.983,1,0,[2.13773,-3.79196],"","",true,false], 
	["Land_Cargo_Patrol_V1_F",[-13.9707,10.8149,3.05176e-005],135.633,1,0,[3.26359,-2.2305],"","",true,false], 
	["Land_HBarrier_5_F",[-7.93359,12.9771,0.0881348],227.856,1,0,[4.05126,2.19946],"","",true,false], 
	["Land_Cargo_House_V1_F",[-4.87305,17.9375,1.52588e-005],318.641,1,0,[-3.22079,3.04034],"","",true,false], 
	["Land_Pallet_MilBoxes_F",[-16.3789,8.10693,-0.00224304],318.457,1,0,[-6.11783,2.9731],"","",true,false], 
	["Land_TTowerSmall_1_F",[-18.3203,6.86475,0.0293274],163.355,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_Big_F",[-0.591797,21.2012,0.000671387],49.3508,1,0,[4.53729,-6.29491],"","",true,false], 
	["Land_HBarrierBig_F",[-12.1416,17.5918,-0.00169373],137.701,1,0,[2.18848,-4.05717],"","",true,false], 
	["Land_Razorwire_F",[-19.3916,-4.32617,0.595688],151.547,1,0,[-0.239615,3.08233],"","",true,false], 
	["Land_HBarrier_Big_F",[-18.0996,11.4697,0.019104],318.457,1,0,[-6.11783,2.9731],"","",true,false], 
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[-21.501,2.0293,-0.0150452],230.097,1,0,[-4.53582,7.36498],"","",true,false], 
	["Land_HBarrier_5_F",[-19.5293,-2.58887,0.489944],150.811,1,0,[-2.76821,12.2386],"","",true,false], 
	["Land_BagFence_Long_F",[22.8291,1.59473,-0.0493927],134.029,1,0,[-1.65074,-1.8087],"","",true,false], 
	["Land_BagFence_Long_F",[21.9941,-7.32227,0.109833],43.0668,1,0,[2.9275,3.57315],"","",true,false], 
	["Land_HBarrier_Big_F",[-5.94043,22.7905,0.0306549],321.348,1,0,[-7.32041,6.063],"","",true,false], 
	["Land_HBarrier_5_F",[-21.6631,8.2915,0.234238],129.638,1,0,[11.0486,5.77622],"","",true,false], 
	["Land_Razorwire_F",[-24.1064,7.9917,-0.365509],307.973,1,0,[-11.2062,-5.45183],"","",true,false], 
	["Land_BagFence_Long_F",[24.9092,3.69189,-0.183746],134.359,1,0,[-1.71887,-7.61961],"","",true,false], 
	["Land_HBarrier_5_F",[-24.0752,-3.7168,0.306717],228.406,1,0,[-4.3003,7.66006],"","",true,false], 
	["Land_BagFence_Long_F",[24.1768,-9.36768,0.125397],43.0044,1,0,[2.04438,4.51807],"","",true,false], 
	["Land_HBarrier_5_F",[-25.1865,4.0127,0.210312],129.635,1,0,[8.40802,5.21456],"","",true,false], 
	["Land_Razorwire_F",[-28.0205,-1.30078,-0.758774],48.9225,1,0,[4.36925,-7.62158],"","",true,false], 
	["CamoNet_OPFOR_Curator_F",[26.6904,4.9873,0.0231781],311.328,1,0,[3.17006,6.32531],"","",true,false], 
	["Land_BagFence_Long_F",[26.9902,5.77197,-0.144241],134.313,1,0,[-2.83589,-6.48002],"","",true,false], 
	["Land_Razorwire_F",[-28.9844,1.9082,-0.501999],307.982,1,0,[-8.55214,-4.97002],"","",true,false], 
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[25.6045,-12.6768,-0.094635],190.74,1,0,[-4.54319,-2.83457],"","",true,false], 
	["Land_BagFence_Round_F",[25.5303,-14.0576,0.0579834],13.0317,1,0,[4.39678,2.98465],"","",true,false], 
	["Land_BagFence_Long_F",[29.0566,7.83398,-0.229279],134.575,1,0,[-2.84189,-9.26286],"","",true,false], 
	["Land_BagFence_Long_F",[29.0654,-10.9043,-0.0473175],180,1,0,[-4.95322,-1.91632],"","",true,false], 
	["Land_BagFence_Long_F",[31.1162,2.14111,-0.0847168],133.049,1,0,[1.07275,-4.84046],"","",true,false], 
	["Land_BagFence_Round_F",[30.8613,-0.887207,-0.0810852],89.1895,1,0,[-2.58655,-4.23418],"","",true,false], 
	["Land_BagFence_Long_F",[30.9121,-4.61621,-0.082901],222.047,1,0,[-2.54335,-3.22017],"","",true,false], 
	["Land_BagFence_Long_F",[31.1475,9.91113,-0.172394],135.272,1,0,[-0.680695,-7.26982],"","",true,false], 
	["Land_BagFence_Long_F",[32.0078,-10.9146,-0.0161285],180,1,0,[-8.71752,-0.695584],"","",true,false], 
	["Land_BagFence_Round_F",[34.875,2.60693,-0.141098],178.997,1,0,[7.27004,-5.80916],"","",true,false], 
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[35.1787,-1.11279,-0.0185242],267.528,1,0,[2.70742,4.15807],"","",true,false], 
	["Land_BagFence_Round_F",[35.041,-5.04492,0.0513306],0,1,0,[2.21426,2.52128],"","",true,false], 
	["CamoNet_OPFOR_Curator_F",[34.8965,-11.9204,-0.0158844],178.988,1,0,[-8.72819,-0.540375],"","",true,false], 
	["Land_BagFence_Long_F",[34.9551,-13.2866,-0.0161438],180,1,0,[-8.71752,-0.695584],"","",true,false], 
	["Land_BagFence_Round_F",[38.8672,-1.23535,0.182465],270.225,1,0,[1.74196,7.37614],"","",true,false], 
	["Land_BagFence_Long_F",[38.6055,2.2251,0.103867],222.325,1,0,[6.64168,3.67469],"","",true,false], 
	["Land_BagFence_Long_F",[37.8291,-10.9341,-0.142548],180,1,0,[-13.4235,-8.03649],"","",true,false], 
	["Land_BagFence_Long_F",[39.4434,-4.78418,0.0483551],132.578,1,0,[-6.90769,4.9182],"","",true,false], 
	["Land_BagFence_Long_F",[38.5117,9.97754,0.0702057],222.137,1,0,[4.28617,2.53954],"","",true,false], 
	["Land_BagFence_Long_F",[40.6484,7.96729,0.0702057],222.137,1,0,[4.28617,2.53954],"","",true,false], 
	["Land_BagFence_Long_F",[40.6523,-10.9453,-0.17099],180,1,0,[-13.4235,-8.03649],"","",true,false], 
	["Land_BagFence_Long_F",[42.7939,5.96045,0.0702057],222.137,1,0,[4.28617,2.53954],"","",true,false], 
	["CamoNet_OPFOR_Curator_F",[43.8701,4.92383,-0.0112305],42.1371,1,0,[-4.28617,-2.53954],"","",true,false], 
	["Land_BagFence_Long_F",[44.8652,3.9502,-0.0168152],222.214,1,0,[12.5713,-4.1848],"","",true,false], 
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[43.7568,-12.5303,0.0369415],161.614,1,0,[-15.1426,-3.19791],"","",true,false], 
	["Land_BagFence_Long_F",[45.2754,-9.68994,0.015625],139.494,1,0,[-10.4751,0.419334],"","",true,false], 
	["Land_BagFence_Round_F",[44.3682,-13.9038,0.024826],334.254,1,0,[15.4457,1.34636],"","",true,false], 
	["Land_BagFence_Long_F",[46.9668,2.0625,-0.0931702],221.93,1,0,[6.74361,-3.87845],"","",true,false], 
	["Land_BagFence_Long_F",[47.5781,-7.76904,0.0294952],139.494,1,0,[-10.4751,0.419334],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[1.61426,8.94629,0.000518799],94.7313,1,0.00982795,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[-3.53516,10.1841,0.00471497],317.34,1,0,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[1.70996,12.5879,0],130.877,1,0,[],"","",true,false]
];
[_dict, "Skopos", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Skopos", "center", _center] call DICT_fnc_set;
[_dict, "Skopos", "objects", _objects] call DICT_fnc_set;

_center = [7883.29,14628.7,0];
_objects = [
	["Land_HBarrier_3_F",[1.95264,0.369141,0.266205],90.4703,1,0,[],"","",true,false],
	["Land_HBarrier_3_F",[1.45068,3.40527,0.00354004],82.6909,1,0,[],"","",true,false],
	["Land_HBarrier_3_F",[1.97461,-2.96387,0.0446167],85.6134,1,0,[],"","",true,false],
	["Land_HBarrier_3_F",[4.24756,-6.28223,0.148651],172.174,1,0,[],"","",true,false],
	[["CSAT", "self_aa"] call AS_fnc_getEntity,[7.79785,-2.6084,-0.0805359],160.172,1,0,[],"","",true,false],
	["Land_HBarrier_1_F",[5.51367,-6.2041,0.00564575],0,1,0,[],"","",true,false],
	["Land_HBarrier_1_F",[6.75879,-6.22754,0.00564575],0,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[10.8828,2.80664,-0.132202],84.9037,1,0,[],"","",true,false],
	["Land_HBarrier_3_F",[11.3687,-4.9707,-0.0600586],269.407,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[6.78369,-10.0615,0.0556946],357.299,1,0,[],"","",true,false],
	["Land_HBarrier_3_F",[11.3403,-6.24512,0.0623474],90.6667,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-7.59521,-11.959,-0.213745],302.883,1,0,[],"","",true,false],
	[["CSAT", "self_aa"] call AS_fnc_getEntity,[-10.2705,-10.4375,-0.0065918],206.975,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-12.7358,-8.89844,0.186371],107.351,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-3.51904,15.0527,-0.0301208],36.4158,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-14.2305,7.66895,-0.023407],39.6549,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-0.317871,16.0244,-0.0209045],283.469,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-10.1616,-13.2275,0.0903625],2.67459,1,0,[],"","",true,false],
	[["CSAT", "self_aa"] call AS_fnc_getEntity,[-12.4941,10.7744,-0.111389],307.636,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-9.77246,13.4336,0.0517273],212.609,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[-2.48975,16.4404,-0.0637817],359.987,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-12.5127,-11.6875,0.255127],61.8115,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[15.7051,-6.46484,-0.0715332],154.878,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[15.9443,-8.58496,-0.0295715],11.8532,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[10.6294,14.8604,-0.0822449],133.201,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-2.87256,18.7266,0.0564575],162.299,1,0,[],"","",true,false],
	[["CSAT", "self_aa"] call AS_fnc_getEntity,[13.4976,12.8945,-0.120026],32.7453,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[17.9507,-7.09082,0.187531],270.587,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-15.6572,12.4707,-0.0234985],123.773,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[16.8521,10.6699,0.0686646],303.688,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-20.8423,3.3125,-0.0811157],277.828,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[15.9214,15.9453,0.0166931],213.267,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-22.5742,1.79395,-0.0829163],32.9549,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-22.668,4.51563,0.0150757],144.698,1,0,[],"","",true,false],
	["Land_Razorwire_F",[19.4292,13.6885,0.48822],233.639,1,0,[],"","",true,false],
	["Land_Razorwire_F",[-25.5449,6.30957,-0.0306702],94.4101,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[10.0767,-5.84961,0.000457764],79.1409,1,0.106246,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[-10.1396,-2.51465,0.0481567],168.38,1,0,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[0.0429688,2.5625,0.0172424],0,1,0,[],"","",true,false]
];
[_dict, "AgiaStemma", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AgiaStemma", "center", _center] call DICT_fnc_set;
[_dict, "AgiaStemma", "objects", _objects] call DICT_fnc_set;

_center = [23697.4,24259.1,0];
_objects = [
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[-9.03711,-3.94336,-0.0341187],58.2242,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-8.56445,-9.75391,0.19117],329.01,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-14.0508,-0.783203,0.138481],329.022,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[9.46094,-10.8438,-0.0700684],146.186,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-9.69531,-10.2324,-0.124252],149.287,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[11.8535,-11.4492,0.0914993],240.189,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[9.29883,-13.6211,-0.0190659],105.47,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-18.9102,-3.6582,0.0935516],328.973,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-3.5918,-17.1777,-0.0283508],81.3982,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[-15.8867,-8.01172,-0.0460815],240.769,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[7.94141,-16.0664,-0.0813828],62.13,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[11.4863,-14.3242,-0.0844269],105.834,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[-5.48633,-17.9785,-0.0319519],169.841,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-3.4375,-18.998,-0.030098],86.6933,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[10.3184,-16.8613,0.0244827],330.067,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-7.41992,-18.0566,-0.00623322],81.2201,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-7.17188,-19.4727,-0.0235062],170.744,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[9.41211,18.7109,-0.100784],89.044,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[11.1641,17.7051,0.00553131],312.97,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[11.1055,20.2441,-0.104851],220.939,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[6.94531,-25.3008,-0.0933228],149.11,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[9.12305,-26.1387,-0.0105438],287.738,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[6.83008,-27.1055,0.062088],19.9116,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-10.0918,31.7285,-0.0999832],320.862,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-29.1035,-16.6934,-0.0705185],227.534,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-12.2676,31.7715,0.0026474],82.3252,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-29.4375,-18.8789,-0.167015],4.13961,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-10.6387,33.6641,0.00915527],174.3,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-30.959,-16.8828,0.0165024],96.316,1,0,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[2.88477,5.125,0.0275421],176.475,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[-0.0605469,7.80469,0.00138092],308.867,1,0.0097848,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[5.87695,6.05078,0],0,1,0,[],"","",true,false]
];
[_dict, "AgiosAndreas", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AgiosAndreas", "center", _center] call DICT_fnc_set;
[_dict, "AgiosAndreas", "objects", _objects] call DICT_fnc_set;

_center = [7832.41,17992.4,0];
_objects = [
	["Land_HBarrier_5_F",[1.35938,-8.60742,0.0195923],220.769,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-7.41943,5.94531,-0.117035],28.1752,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[7.80322,6.37109,-0.0213165],64.8249,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-5.98975,9.04883,-0.147034],28.1084,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-8.89697,6.94336,-0.0258179],214.599,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[10.2397,5.00391,0.21283],200.243,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-7.91162,8.14063,-0.0396423],302.172,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[2.18701,-9.46289,0.203278],41.6226,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-7.23682,9.75,-0.0337219],300.958,1,0,[],"","",true,false],
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[-4.07959,-11.2656,-0.00253296],310.125,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[8.78027,8.66016,0.240005],156.911,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[10.9019,6.96289,-0.0450897],199.846,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[13.0112,4.41992,0.0261383],334.629,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[-14.7285,0.246094,0.0121307],132.97,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[13.8008,6.75,-0.0345459],240.751,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[1.89502,-15.9609,0.0283966],131.973,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-5.38965,-16.5527,-0.013916],221.204,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[17.0981,-5.04688,-0.151154],268.015,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[17.1245,-6.47461,-0.0713348],180.695,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-1.13867,-20.2871,-0.00389099],221.204,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[18.8398,-5.14453,-0.161438],178.664,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[20.5195,-4.68945,-0.1539],268.107,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[20.4102,-6.4668,0.00474548],94.4599,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[25.8477,0.640625,-0.0767975],137.089,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[26.2012,-1.04102,-0.00421143],359.741,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[27.9331,0.652344,-0.0539551],266.55,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-10.9141,-34.2227,-0.0776672],189.415,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-9.48926,-35.7637,0.0237122],319.503,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-11.9243,-35.4023,0.0532532],52.188,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[30.48,21.6914,-0.0359802],56.106,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[32.3999,22,-0.0479279],278.635,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[30.981,24.0313,-0.148621],186.96,1,0,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[17.3281,15.8633,-0.00765991],152.264,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[17.3076,20.5371,0.000579834],0.00223059,1,0.00984257,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[25.064,21.9336,0],0,1,0,[],"","",true,false]
];
[_dict, "AgiosMinas", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "AgiosMinas", "center", _center] call DICT_fnc_set;
[_dict, "AgiosMinas", "objects", _objects] call DICT_fnc_set;

_center = [7852.7,16664.4,0];
_objects = [
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[5.31201,0.671875,-0.0928345],264.214,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[-5.93799,0.666016,-0.00299072],86.4737,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[8.09863,-4.38281,-0.0711823],174.754,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[7.10742,6.05273,0.093277],174.754,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[8.28857,5.99609,0.134552],355.079,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[13.7188,-3.91992,-0.111725],174.76,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[12.8228,1.33398,0.015625],86.2006,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-10.231,-11.8594,-0.0144043],308.103,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[-11.6938,-11.3906,-0.144073],218.973,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-13.0547,-9.91016,-0.0939331],308.24,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-1.70654,16.7637,-0.113617],359.139,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-11.4419,-13.1328,-0.0231171],134.688,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-13.9551,-11.0215,-0.0462189],221.033,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-0.855469,17.8535,0.0924072],224.145,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-3.36475,17.8535,-0.0200195],131.196,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[21.688,3.67773,-0.0109558],120.348,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[22.8213,1.07227,-0.0389557],79.5806,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[22.6475,-1.69531,0.083313],36.1704,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-22.0132,-7.18359,-0.0919647],343.643,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-22.9595,-5.12891,-0.0215607],211.354,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[24.1426,4.17773,-0.0110168],214.248,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-24.1807,-5.84375,-0.062027],75.383,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[25.1377,-1.36719,0.00608826],304.149,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[25.0771,1.43164,0.0269318],79.9452,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[26.9902,-10.6387,-0.0621796],125.087,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[27.6226,-12.1523,-0.0466156],349.475,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[29.0923,-10.0664,-0.147552],257.556,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[32.0679,8.24609,-0.0402069],173.022,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[31.4106,11.6211,-0.0401917],173.022,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[32.4355,9.9082,-0.0219574],87.0615,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[33.4932,8.40234,-0.0202332],85.5658,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[33.2012,11.6719,-0.0062561],359.512,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[-14.1016,0.214844,0.000167847],256.936,1,0.00921631,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[-10.2456,-1.97461,-0.0253296],146.33,1,0,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[10.0068,11.7695,0],0,1,0,[],"","",true,false]
];
[_dict, "Amoni", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Amoni", "center", _center] call DICT_fnc_set;
[_dict, "Amoni", "objects", _objects] call DICT_fnc_set;

_center = [17742.7,9890.29,0];
_objects = [
	["Land_HBarrier_Big_F",[-6.04688,-1.85352,0.0193329],96.2587,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[4.25781,6.20801,0.0032196],329.817,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[9.85156,-2.77539,0.0224304],329.317,1,0,[],"","",true,false],
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[9.87891,3.35742,-0.0560608],236.817,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[7.86328,-11.4893,-0.107452],253.631,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[11.0234,-10.1855,-0.151413],252.596,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-6.11719,13.8643,-0.101883],56.489,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[9.49023,-11.9385,0.141861],156.8,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[8.29297,-12.8271,-0.0439758],163.336,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[11.4473,10.5791,0.010788],329.657,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[11.4219,-11.9063,0.209686],78.6726,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-3.34961,15.8867,-0.0147858],57.2131,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-6.90234,15.4561,0.0330658],242.896,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-5.58789,16.0273,-0.014389],324.945,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-4.08984,17.1162,0.0836792],330.938,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[17.2871,1.81641,0.0290527],328.277,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[17.1055,8.06836,0.0383606],59.5113,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-24.2949,-1.89063,-0.054245],248.599,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-24.6563,-3.85742,-0.162933],21.0934,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-25.5762,-1.47559,-0.0413208],113.004,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[24.998,12.7266,0.147522],15.7801,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[22.3496,17.3789,0.163956],99.841,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[24.2539,15.2344,0.127991],59.6308,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[27.2148,13.8994,-0.0359344],283.784,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[24.4219,18.6904,0.466461],193.425,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[26.2227,16.5371,0.261765],61.0122,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[43.4082,26.4238,-0.0737457],62.6585,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[45.125,26.0469,0.264404],286.589,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[43.9141,28.293,-0.0462494],194.297,1,0,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[-8.89063,-5.47754,0],0,1,0,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[-10.6504,-1.37598,0.0430145],4.03134,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[-9.78125,-6.90332,0.0202942],57.2098,1,0.0115505,[],"","",true,false]
];
[_dict, "Didymos", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Didymos", "center", _center] call DICT_fnc_set;
[_dict, "Didymos", "objects", _objects] call DICT_fnc_set;

_center = [4775.84,17719.7,0];
_objects = [
	["Land_BagFence_Round_F",[-0.902832,5.14453,0.139877],349.48,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-2.88281,6.6875,0.167206],81.4454,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[1.04199,7.15234,0.000900269],125.247,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[-0.746094,8.42578,-0.0504761],124.848,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[2.33008,9.74805,0.0345459],259.482,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[0.287598,11.1035,0.0575867],165.616,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[14.5068,-15.2148,-0.223618],220.597,1,0,[],"","",true,false],
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[9.59131,-17.6035,-0.00680542],309.994,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-1.60498,20.373,-0.085495],338.465,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-3.26123,20.7813,-0.036911],110.69,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-0.880371,21.7344,-0.00325012],202.685,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[7.75244,-23.1777,-0.228348],220.789,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[15.3325,-16.1816,0.254395],40.8661,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[15.126,-22.6621,0.0188751],132.213,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[12.0068,-26.918,-0.224899],220.805,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-28.7563,4.25195,-0.00570679],8.29157,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-28.499,7.67969,0.0271759],8.29157,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-29.6631,6.02734,-0.0368195],275.656,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-30.4912,4.67773,0.0756378],194.766,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-29.9121,7.90625,0.111069],281.429,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[13.9097,-31.1074,-0.0895844],260.047,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[15.6187,-30.9277,-0.136185],170.738,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[17.2383,-30.2871,-0.0917053],259.926,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[14.1343,-32.5234,-0.0570831],172.714,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[17.3765,-32.0703,-0.0269012],86.3921,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[25.0874,-30.9648,-0.095871],122.567,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[0.966797,-40.2871,-0.0666809],271.828,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[4.38184,-40.0898,-0.108353],271.324,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[27.2695,-30.4629,-0.153595],254.662,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[2.44189,-41.2012,-0.0153961],177.196,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[25.8896,-32.6113,0.0851593],347.138,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[0.930664,-41.707,-0.000671387],183.358,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[4.19189,-41.8613,0.114288],97.671,1,0,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[-3.28369,13.0566,0],0,1,0,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[11.002,8.77148,0.014679],8.91439,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[8.11621,5.2207,0.000488281],54.3764,1,0.00991255,[],"","",true,false]
];
[_dict, "Kira", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Kira", "center", _center] call DICT_fnc_set;
[_dict, "Kira", "objects", _objects] call DICT_fnc_set;

_center = [9215.07,19279.4,0];
_objects = [
	["Land_BagFence_Round_F",[10.1738,0.925781,0.25592],66.9754,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[11.251,3.17578,0.0469666],161.264,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[12.958,0.226563,0.00619507],26.3412,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[14.0059,2.26758,0.17923],26.9886,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[15.0303,-1.55078,0.13797],343.204,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[16.2715,0.632813,-0.0473633],250.902,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-14.6465,9.84375,-0.0027771],330.505,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-15.8105,9.37305,-0.00811768],150.831,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-16.5449,-10.5293,3.05176e-005],202.685,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-15.5205,-13.1289,-0.0174255],290.861,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-17.457,-12.3613,-0.112274],176.463,1,0,[],"","",true,false],
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[-15.0801,15.2344,-0.0490112],60.0282,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-18.917,-11.4746,0.00372314],110.664,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-17.8965,-14.0645,-0.00158691],22.8823,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[5.17188,23.7754,-0.100067],61.927,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[6.90039,23.5039,0.0726929],286.098,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[-21.9004,11.7813,0.0010376],242.265,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[5.59863,25.8887,0.00839233],194.116,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-19.8896,18.9434,-0.0113525],330.501,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-24.8174,16.2051,-0.0739136],330.519,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-13.0459,33.7344,-0.0898438],338.361,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-14.7305,34.0957,-0.0391846],110.685,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-12.3516,35.0547,0.0246887],202.685,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-6.62402,-36.3691,-0.017395],288.872,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-5.42871,-37.5664,-0.00808716],199.151,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[-3.39746,-37.8457,-0.0828552],199.462,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-1.7207,-38.0938,-0.0371399],288.879,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-7.10645,-37.7188,-0.0032959],201.452,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[36.3916,-13.2148,-0.0795288],122.189,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-2.45703,-39.7266,-0.0197144],115.38,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[36.7969,-15.0371,0.207642],345.993,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[38.123,-12.8594,-0.0719604],253.959,1,0,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[-12.1191,-4.69922,0],0,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[-15.876,-5.02734,3.05176e-005],13.8785,1,0.00985034,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[-20.7744,-2.45117,-0.0109253],242.949,1,0,[],"","",true,false]
];
[_dict, "Pyrsos", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Pyrsos", "center", _center] call DICT_fnc_set;
[_dict, "Pyrsos", "objects", _objects] call DICT_fnc_set;

_center = [9213.28,11463.2,0];
_objects = [
	["Land_HBarrier_Big_F",[-1.64063,-7.24121,0],356.835,1,0,[],"","",true,false],
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[-1.35938,8.79199,-0.0558701],177.55,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[3.99219,11.6377,0.00183105],85.0784,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-6.45605,10.6494,0.000152588],85.0784,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[3.56152,17.2803,0],85.0784,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-6.38867,11.9023,0.000457764],265.402,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[-1.66699,16.4551,0.00175476],356.835,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-3.85742,22.6172,0.00888824],34.9574,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[1.56641,23.0938,0.0225601],310.848,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[10.082,-21.2197,-0.0571747],166.87,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[-1.18848,23.4795,-0.0384293],354.207,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[9.1377,-22.6309,-0.0326691],31.1353,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[11.623,-22.0439,0.0504227],299.06,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-4.16016,25.0615,-0.00130463],128.919,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[1.44434,25.6025,0.0166397],218.827,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[-1.3457,25.7686,-0.000999451],354.622,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[31.1572,1.12598,-0.0663757],173.54,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[30.6133,6.3252,-0.00325775],173.555,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[31.4258,5.01758,-0.13208],84.0392,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[31.8467,3.11035,-0.0355072],84.1712,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[32.582,1.26855,-0.0166245],86.4865,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[32.4014,6.36035,0.142151],0.0222149,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-0.0996094,38.6133,0.105827],93.1404,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[5.08496,38.2871,-0.000999451],93.1404,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-30.4297,24.1865,-0.0869064],326.635,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[1.41895,38.9414,-0.0702286],3.67325,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[3.38867,38.9932,0.00167847],3.24935,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-29.998,25.668,-0.00130463],190.857,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[5.18164,39.7178,-0.000999451],5.67507,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-32.1279,24.2559,-0.00341797],98.8365,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[0.164063,40.3848,0.108017],279.637,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[26.9414,30.5859,0.00406647],56.9956,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[29.5957,30.0078,0.0276947],324.978,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[28.9111,31.6201,-0.0975037],39.4702,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[27.458,33.124,0.022316],141.982,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[30.1064,32.6504,-0.0427017],234.247,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-54.0332,-16.7705,0.0967331],341.046,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-52.3271,-21.6172,0.114868],340.635,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-54.002,-18.5977,0.0522308],250.711,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[-53.3838,-20.6738,-0.00646973],252.792,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-55.3945,-17.2197,0.0576553],253.333,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-54.0674,-22.0273,0.037941],167.231,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-75.3594,-11.8398,0.0259094],251.278,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-77.0947,-12.6895,-0.268158],23.9885,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-77.8691,-10.377,-0.108109],112.627,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[23.9219,11.2559,0.00012207],144.769,1,0.00983477,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[26.5801,10.8018,0],130.877,1,0,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[20.4854,15.3213,-0.0112839],13.8512,1,0,[],"","",true,false]
];
[_dict, "Riga", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Riga", "center", _center] call DICT_fnc_set;
[_dict, "Riga", "objects", _objects] call DICT_fnc_set;

_center = [6528.61,21627,0];
_objects = [
	["Land_HBarrier_Big_F",[5.31445,0.896484,-0.000732422],275.082,1,0,[],"","",true,false],
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[-7.12646,1.21875,0.0325012],95.5878,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-9.65186,-3.41406,0.227844],3.18661,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-9.19482,7.04688,0.435791],3.12925,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-10.7998,-3.11719,0.0835571],183.547,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[-14.7583,7.47266,0.0948792],3.21044,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[-14.7051,2.18164,-0.000762939],274.853,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-9.56934,13.9922,-0.122559],95.087,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-9.48242,15.4063,-0.0803528],5.63424,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-11.1553,14.8105,-0.0447388],0.381093,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[17.8188,-4.58789,0.0525818],134.558,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[17.8223,-7.30273,0.0760803],42.5716,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[-13.1431,14.7207,-0.148895],3.58366,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[19.1421,-6.12109,-0.0855408],117.08,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-14.0679,-14.7617,-0.146637],301.128,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-14.6953,14.3164,-0.0243225],93.7128,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-20.3335,2.06641,0.021637],306.513,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[20.4121,-4.55664,-0.0374146],219.595,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-14.4312,16.0859,0.103058],280.131,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[20.5698,-7.25977,-0.0494385],311.594,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[-21.0576,4.63281,-0.0133972],266.15,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-17.1401,-13.2207,-0.0826111],301.128,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-15.1187,-16.1875,0.079895],127.385,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-16.2104,-14.9004,0.0392151],208.793,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-20.5894,7.48438,-0.00656128],222.898,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-22.7852,1.8418,0.25296],40.8121,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-17.8828,-14.4258,0.0336609],214.92,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[-23.3984,4.625,0.106903],266.582,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-23.1387,7.4082,-0.1297],130.811,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-35.3613,5.1543,-0.0903015],264.788,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[25.3604,-25.1914,-0.0616455],289.151,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-36.1406,3.66211,-0.118958],37.0657,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[24.9214,-26.4766,0.00912476],202.505,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-36.4043,6.17188,0.0132751],129.159,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[27.022,-25.9336,-0.161133],199.888,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[28.6909,-26.0781,-0.0839844],289.422,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[27.9521,-27.6836,0.071167],115.735,1,0,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[-15.3115,-7.46094,-0.0145264],279.136,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[-17.9111,-4.33398,0.00161743],319.506,1,0,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[-20.52,-3.80078,0],130.877,1,0,[],"","",true,false]
];
[_dict, "Synneforos", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Synneforos", "center", _center] call DICT_fnc_set;
[_dict, "Synneforos", "objects", _objects] call DICT_fnc_set;

_center = [4954.2,21856.5,0];
_objects = [
["Land_HBarrier_5_F",[17.1958,2.87109,-0.181183],231.923,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[20.7339,-1.64258,-0.0022583],232.227,1,0,[],"","",true,false],
	[["CSAT", "track_aa"] call AS_fnc_getEntity,[20.2227,8.07813,-0.055603],321.664,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[22.6162,-7.54102,0.0464478],129.973,1,0,[],"","",true,false],
	["Land_HBarrier_Big_F",[24.6426,1.85547,-0.000610352],143.915,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[22.812,-10.0879,0.0744629],38.0276,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[24.1064,-8.66016,-0.0745544],265.743,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[25.3418,-7.35547,0.00296021],218.734,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[25.4697,9.30078,0.0308838],232.246,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[25.4883,-9.93164,-0.0601807],310.332,1,0,[],"","",true,false],
	["Land_HBarrier_5_F",[26.1113,8.21289,-0.0480652],52.5492,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[8.90527,-27.9492,-0.0448303],270.915,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[10.6099,-28.1543,-0.019165],177.652,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[12.3105,-27.7637,-0.0838013],270.83,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[8.86133,-29.3828,-0.0301208],183.493,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[12.1123,-29.5449,-0.0765076],97.3565,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-16.3369,36.3398,-0.071228],103.572,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-17.7344,36.6465,-0.11676],191.753,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[-17.2964,38.1328,-0.13913],101.556,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-15.5625,39.5293,0.0682678],18.1914,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-17.2705,40.0508,-0.0849915],191.753,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-34.7827,35.4824,-0.110107],310.834,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-36.0815,34.2559,-0.0544739],137.287,1,0,[],"","",true,false],
	[["CSAT", "static_at"] call AS_fnc_getEntity,[-36.1826,36.3477,-0.125916],222.578,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[-38.4829,36.5137,0.0189819],224.711,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[-37.5269,37.5762,-0.147583],310.517,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[56.7241,-8.55078,-0.0898743],182.815,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[57.1069,-10.457,-0.0308533],89.3368,1,0,[],"","",true,false],
	["Land_BagFence_Short_F",[56.7876,-12.082,-0.133972],182.727,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[58.4951,-8.88281,0.0310364],9.20862,1,0,[],"","",true,false],
	["Land_BagFence_Corner_F",[58.2168,-12.1719,-0.0727234],95.2658,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-55.7725,19.6465,0.110474],247.294,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-56.813,17.4199,0.104523],341.242,1,0,[],"","",true,false],
	[["CSAT", "static_mortar"] call AS_fnc_getEntity,[-58.6455,20.3984,-0.036438],206.534,1,0,[],"","",true,false],
	["Land_BagFence_Long_F",[-59.5684,18.3281,0.0489197],206.943,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-15.4634,61.6445,0.0336304],286.523,1,0,[],"","",true,false],
	[["CSAT", "static_mg"] call AS_fnc_getEntity,[-17.124,61.9551,-0.0612183],61.6532,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-60.5981,22.1543,0.131287],163.175,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-61.8369,19.9609,0.0597839],71.1357,1,0,[],"","",true,false],
	["Land_BagFence_Round_F",[-16.6831,63.8828,-0.276123],193.864,1,0,[],"","",true,false],
	[["CSAT", "flag"] call AS_fnc_getEntity,[-47.1118,8.46484,0],0,1,0,[],"","",true,false],
	[["CSAT", "trucks"] call AS_fnc_getEntity,[-38.3887,-2.56055,0.107788],1.47981,1,0,[],"","",true,false],
	[["CSAT", "box"] call AS_fnc_getEntity,[-39.5176,-7.61914,0.00512695],327.907,1,0.00893501,[],"","",true,false]
];
[_dict, "Thronos", call DICT_fnc_create] call DICT_fnc_set;
[_dict, "Thronos", "center", _center] call DICT_fnc_set;
[_dict, "Thronos", "objects", _objects] call DICT_fnc_set;