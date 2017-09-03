
// sagonisi and hill12 are excluded for an unknown reason.
// todo: document why these are excluded.
[200, 200, ["sagonisi","hill12"]] call AS_fnc_location_addCities;

// These have to be names of hills in the map
private _hillsAA = ["Agela","Agia Stemma","Agios Andreas","Agios Minas","Amoni","Didymos","Kira","Pyrsos","Riga","Skopos","Synneforos","Thronos"];
// 1st param is the min size of the hill, used e.g. to detect when it is cleared. The marker is re-sized to be of this size.
// 2nd param is list of excluded hills. Magos is excluded because there is a base there.
// 3rd param is a list of hill names that are spawned with AA. (i.e. type "hillAA")
[50, ["Magos"], _hillsAA] call AS_fnc_location_addHills;

// These have to be marker names.
seaMarkers = ["seaPatrol","seaPatrol_1","seaPatrol_2","seaPatrol_3","seaPatrol_4","seaPatrol_5","seaPatrol_6","seaPatrol_7","seaPatrol_8","seaPatrol_9","seaPatrol_10","seaPatrol_11","seaPatrol_12","seaPatrol_13","seaPatrol_14","seaPatrol_15","seaPatrol_16","seaPatrol_17","seaPatrol_18","seaPatrol_19","seaPatrol_20","seaPatrol_21","seaPatrol_22","seaPatrol_23","seaPatrol_24","seaPatrol_25","seaPatrol_26","seaPatrol_27"];
{_x setMarkerAlpha 0} forEach seaMarkers;

// you can modify AS_antenasTypes

AS_antenasTypes = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F","Land_Communication_F"];
AS_antenasPos_alive = [[16085.1,16998,7.08781],[14451.5,16338,0.000358582],[15346.7,15894,-3.62396e-005],[9496.2,19318.5,0.601898],[20944.9,19280.9,0.201118],[17856.7,11734.1,0.863045],[20642.7,20107.7,0.236603],[9222.87,19249.1,0.0348206],[18709.3,10222.5,0.716034],[6840.97,16163.4,0.0137177],[19319.8,9717.04,0.215622],[19351.9,9693.04,0.639175],[10316.6,8703.94,0.0508728],[8268.76,10051.6,0.0100708],[4583.61,15401.1,0.262543],[4555.65,15383.2,0.0271606],[4263.82,20664.1,-0.0102234],[26274.6,22188.1,0.0139847],[26455.4,22166.3,0.0223694]];

AS_bankPositions = [[16633.3,12807,-0.635017],[3717.34,13391.2,-0.164862],[3692.49,13158.3,-0.0462093],[3664.31,12826.5,-0.379545]];//same as RT for Bank buildings, select the biggest buildings in your island, and make a DB with their positions.
/*
private _center = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
private _buildings = nearestObjects [_center,AS_antenasTypes, 16000];
private _positions = [];
{_positions pushBack (getPos _x)} forEach _buildings;
copytoclipboard str _positions;
*/
