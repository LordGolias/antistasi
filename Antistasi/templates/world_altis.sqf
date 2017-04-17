
// sagonisi and hill12 are excluded for an unknown reason.
// todo: document why these are excluded.
[200, 200, ["sagonisi","hill12"]] call AS_fnc_location_addCities;

// These have to be names of hills in the map
private _hills = ["Agela","Agia Stemma","Agios Andreas","Agios Minas","Amoni","Didymos","Kira","Pyrsos","Riga","Skopos","Synneforos","Thronos"];
// 1st param is the min size of the hill, used e.g. to detect when it is cleared. The marker is re-sized to be of this size.
// 2nd param is list of excluded hills. Magos is excluded because there is a base there.
// 3rd param is a list of hill names that are spawned without AA. (i.e. type "hill")
[50, ["Magos"], _hills] call AS_fnc_location_addHills;

// These have to be marker names.
control_points = ["control","control_1","control_2","control_3","control_4","control_5","control_6","control_7","control_8","control_9","control_10","control_11","control_12","control_13","control_14","control_15","control_16","control_17","control_18","control_19","control_20"];//use this for points where you want a roadblock (logic/strategic points, such as crossroads, airport or bases entrances etc..) game will add some more automatically
seaMarkers = ["seaPatrol","seaPatrol_1","seaPatrol_2","seaPatrol_3","seaPatrol_4","seaPatrol_5","seaPatrol_6","seaPatrol_7","seaPatrol_8","seaPatrol_9","seaPatrol_10","seaPatrol_11","seaPatrol_12","seaPatrol_13","seaPatrol_14","seaPatrol_15","seaPatrol_16","seaPatrol_17","seaPatrol_18","seaPatrol_19","seaPatrol_20","seaPatrol_21","seaPatrol_22","seaPatrol_23","seaPatrol_24","seaPatrol_25","seaPatrol_26","seaPatrol_27"];
{_x setMarkerAlpha 0} forEach seaMarkers;

{[_x, "roadblock"] call AS_fnc_location_add} forEach control_points;

// military buildings, intact and destroyed
listMilBld = ["Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F","Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F","Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F","Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V3_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F","Land_HelipadSquare_F","Land_Cargo_Tower_V1_ruins_F","Land_Cargo_Tower_V2_ruins_F","Land_Cargo_Tower_V3_ruins_F"];

// buildings for outposts/bases
listbld = ["Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F","Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F","Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F"];

// these are the lamps that are shut-off when the city loses power.
lamptypes = [
    "Lamps_Base_F",
    "PowerLines_base_F",
    "Land_LampDecor_F",
    "Land_LampHalogen_F",
    "Land_LampHarbour_F",
    "Land_LampShabby_F",
    "Land_NavigLight",
    "Land_runway_edgelight",
    "Land_PowerPoleWooden_L_F"
];

posAntenas = [[16085.1,16998,7.08781],[14451.5,16338,0.000358582],[15346.7,15894,-3.62396e-005],[9496.2,19318.5,0.601898],[20944.9,19280.9,0.201118],[17856.7,11734.1,0.863045],[20642.7,20107.7,0.236603],[9222.87,19249.1,0.0348206],[18709.3,10222.5,0.716034],[6840.97,16163.4,0.0137177],[19319.8,9717.04,0.215622],[19351.9,9693.04,0.639175],[10316.6,8703.94,0.0508728],[8268.76,10051.6,0.0100708],[4583.61,15401.1,0.262543],[4555.65,15383.2,0.0271606],[4263.82,20664.1,-0.0102234],[26274.6,22188.1,0.0139847],[26455.4,22166.3,0.0223694]];//those are predefined Radio Tower positions, to avoid a heavy search of the tower config types all around the island which may take a few minutes. You will have to build your own data base with RT positions.
antenas = [];
mrkAntenas = [];

for "_i" from 0 to (count posantenas - 1) do
    {
    _antenaProv = nearestObjects [posantenas select _i,["Land_TTowerBig_1_F","Land_TTowerBig_2_F","Land_Communication_F"], 25];
    if (count _antenaProv > 0) then
        {
        _antena = _antenaProv select 0;
        antenas = antenas + [_antena];
        _mrkfin = createMarker [format ["Ant%1", _i], posantenas select _i];
        _mrkfin setMarkerShape "ICON";
        _mrkfin setMarkerType "loc_Transmitter";
        _mrkfin setMarkerColor "ColorBlack";
        _mrkfin setMarkerText "Radio Tower";
        mrkAntenas = mrkAntenas + [_mrkfin];
        _antena addEventHandler ["Killed",
            {
            _antena = _this select 0;
            _mrk = [mrkAntenas, _antena] call BIS_fnc_nearestPosition;
            antenas = antenas - [_antena]; antenasmuertas = antenasmuertas + [getPos _antena]; deleteMarker _mrk;
            if (hayBE) then {["cl_loc"] remoteExec ["fnc_BE_XP", 2]};
            [["TaskSucceeded", ["", "Radio Tower Destroyed"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
            }
        ];
        };
    };
publicVariable "antenas";
antenasmuertas = [];

posbancos = [[16633.3,12807,-0.635017],[3717.34,13391.2,-0.164862],[3692.49,13158.3,-0.0462093],[3664.31,12826.5,-0.379545]];//same as RT for Bank buildings, select the biggest buildings in your island, and make a DB with their positions.
bancos = [];
for "_i" from 0 to (count posbancos - 1) do {
    _bancoProv = nearestObjects [posbancos select _i,["Land_Offices_01_V1_F"], 25];
    if (count _bancoProv > 0) then {
        _banco = _bancoProv select 0;
        bancos = bancos + [_banco];
    };
};
//the following is the console code snippet I use to pick positions of any kind of building. You may do this for gas stations, banks, radios etc.. markerPos "Base_4" is because it's in the middle of the island, and inside the array you may find the type of building I am searching for. Paste the result in a txt and add it to the corresponding arrays.
/*
pepe = nearestObjects [markerPos "base_4", ["Land_Offices_01_V1_F"], 16000];
pospepe = [];
{pospepe = pospepe + [getPos _x]} forEach pepe;
copytoclipboard str pospepe;
*/
