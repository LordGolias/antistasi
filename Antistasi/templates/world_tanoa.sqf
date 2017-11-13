
// Exclusions because they are not connected to main island
[200, 200, ["Ipota", "Tuvanaka", "Belfort", "Nani", "Balavu", "Leqa", "Muaceba", "Tavu", "Laikoro", "Namuvaka", "Rautake",
            "Savaka", "Katkoula", "Lailai", "Yanukka", "Cerebu", "Koumac"]] call AS_location_fnc_addCities;

seaMarkers = ["seaPatrol","seaPatrol_1","seaPatrol_2","seaPatrol_3","seaPatrol_4","seaPatrol_5","seaPatrol_6","seaPatrol_7","seaPatrol_8","seaPatrol_9","seaPatrol_10","seaPatrol_11","seaPatrol_12","seaPatrol_13","seaPatrol_14","seaPatrol_15","seaPatrol_16","seaPatrol_17","seaPatrol_18","seaPatrol_19","seaPatrol_20","seaPatrol_21","seaPatrol_22","seaPatrol_23","seaPatrol_24","seaPatrol_25","seaPatrol_26","seaPatrol_27"];
{_x setMarkerAlpha 0} forEach seaMarkers;

AS_antenasTypes = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F","Land_Communication_F"];
// list below obtained with script in comments in world_altis.sqf
AS_antenasPos_alive = [[6617.95,7853.57,0.200073],[7486.67,9651.9,1.52588e-005],[6005.47,10420.9,0.20298],[4701.6,3165.23,0.0633469],[11008.8,4211.16,-0.00154114],[2437.25,7224.06,0.0264893],[10114.3,11743.1,9.15527e-005],[10949.8,11517.3,0.14209],[12889.2,8578.86,0.228729],[11153.3,11435.2,0.210876],[2682.94,2592.64,-0.000686646],[2690.54,12323,0.0372467],[2965.33,13087.1,0.191544],[13775.8,10976.8,0.170441]];

AS_bankPositions = [];
