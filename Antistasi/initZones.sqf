//usage: place on the map markers covering the areas where you want the AAF operate, and put names depending on if they are powerplants,resources, bases etc.. The marker must cover the whole operative area, it's buildings etc.. (for example in an airport, you must cover more than just the runway, you have to cover the service buildings etc..)
//markers cannot have more than 500 mts size on any side or you may find "insta spawn in your nose" effects.
//do not do it on cities and hills, as the mission will do it automatically
//the naming convention must be as the following arrays, for example: first power plant is "power", second is "power_1" thir is "power_2" after you finish with whatever number.
//of course all the editor placed objects (petros, flag, respawn marker etc..) have to be ported to the new island
//deletion of a marker in the array will require deletion of the corresponding marker in the editor
//only touch the commented arrays

forcedSpawn = [];
ciudades = [];
colinas = [];
colinasAA = ["Agela","Agia Stemma","Agios Andreas","Agios Minas","Amoni","Didymos","Kira","Pyrsos","Riga","Skopos","Synneforos","Thronos"];
power = ["power","power_1","power_2","power_3","power_5","power_6","power_8","power_9","power_10"];//powerplants "power_4", has been changed by "factory_5"
bases = ["base","base_1","base_2","base_3","base_4","base_5","base_6","base_7","base_9","base_10","base_11","base_12"];//bases: if the island uses Arma 3 vanilla buildings, they will get popukated, if not, or no static weapons, or heavy modification
aeropuertos = ["airport","airport_1","airport_2","airport_3","airport_4","airport_5"];//airports
recursos = ["resource","resource_1","resource_2","resource_3","resource_4","resource_5","resource_6","resource_7"];//economic resources
fabricas = ["factory","factory_1","factory_2","factory_3","factory_4","factory_5"];//factories
puestos = ["puesto","puesto_1","puesto_2","puesto_3","puesto_4","puesto_5","puesto_6","puesto_7","puesto_8","puesto_9","puesto_10","puesto_11","puesto_12","puesto_13","puesto_14","puesto_15","puesto_16","puesto_17","puesto_18","puesto_19","puesto_20","puesto_21","puesto_22","puesto_23","puesto_24","puesto_25","puesto_26","puesto_27"];//any small zone with mil buildings
puestosAA = ["puesto_1","puesto_2","puesto_6","puesto_17","puesto_23","puesto_27"];
puertos = ["puerto","puerto_1","puerto_2","puerto_3","puerto_4"];//seaports, adding a lot will affect economics, 5 is ok
controles = ["control","control_1","control_2","control_3","control_4","control_5","control_6","control_7","control_8","control_9","control_10","control_11","control_12","control_13","control_14","control_15","control_16","control_17","control_18","control_19","control_20"];//use this for points where you want a roadblock (logic/strategic points, such as crossroads, airport or bases entrances etc..) game will add some more automatically
seaMarkers = ["seaPatrol","seaPatrol_1","seaPatrol_2","seaPatrol_3","seaPatrol_4","seaPatrol_5","seaPatrol_6","seaPatrol_7","seaPatrol_8","seaPatrol_9","seaPatrol_10","seaPatrol_11","seaPatrol_12","seaPatrol_13","seaPatrol_14","seaPatrol_15","seaPatrol_16","seaPatrol_17","seaPatrol_18","seaPatrol_19","seaPatrol_20","seaPatrol_21","seaPatrol_22","seaPatrol_23","seaPatrol_24","seaPatrol_25","seaPatrol_26","seaPatrol_27"];
puestosFIA = [];
puestosNATO = [];
campsFIA = [];
mrkFIA = ["FIA_HQ"];
garrison setVariable ["FIA_HQ",[],true];
mrkAAF = [];
destroyedCities = [];

marcadores = power + bases + aeropuertos + recursos + fabricas + puestos + puertos + controles + ["FIA_HQ"];
{_x setMarkerAlpha 0;
spawner setVariable [_x,false,true];
} forEach marcadores;
{_x setMarkerAlpha 0} forEach seaMarkers;
private ["_sizeX","_sizeY","_size"];

{
//_nombre = text _x;
_nombre = [text _x, true] call fn_location;
if ((_nombre != "") and (_nombre != "sagonisi") and (_nombre != "hill12")) then//sagonisi is blacklisted in Altis for some reason. If your island has a city in a small island you should blacklist it (road patrols will try to reach it)
    {
    _sizeX = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (text _x) >> "radiusA");
    _sizeY = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (text _x) >> "radiusB");
    if (_sizeX > _sizeY) then {_size = _sizeX} else {_size = _sizeY};
    _pos = getPos _x;
    if (_size < 200) then {_size = 200};
    _roads = [];
    _numCiv = 0;
    if (worldName != "Altis") then//If Altis, data is picked from a DB in initVar.sqf, if not, is built on the fly.
        {
        _numCiv = (count (nearestObjects [_pos, ["house"], _size]));
        _roadsProv = _pos nearRoads _size;
        //_roads = [];
        {
        _roadcon = roadsConnectedto _x;
        if (count _roadcon == 2) then
            {
            _roads pushBack (getPosATL _x);
            };
        } forEach _roadsProv;
        carreteras setVariable [_nombre,_roads];
        }
    else
        {
        _roads = carreteras getVariable _nombre;
        _numCiv = server getVariable _nombre;
        if (isNil "_numCiv") then {hint format ["A mi no me sale en %1",_nombre]};
        if (typeName _numCiv != typeName 0) then {hint format ["Datos erróneos en %1. Son del tipo %2",_nombre, typeName _numCiv]};
        //if (isNil "_roads") then {hint format ["A mi no me sale en %1",_nombre]};
        };
    _numVeh = round (_numCiv / 3);
    _nroads = count _roads;
    _nearRoadsFinalSorted = [_roads, [], { _pos distance _x }, "ASCEND"] call BIS_fnc_sortBy;
    _pos = _nearRoadsFinalSorted select 0;
    _mrk = createmarker [format ["%1", _nombre], _pos];
    _mrk setMarkerSize [_size, _size];
    _mrk setMarkerShape "RECTANGLE";
    _mrk setMarkerBrush "SOLID";
    _mrk setMarkerColor "ColorGUER";
    _mrk setMarkerText _nombre;
    _mrk setMarkerAlpha 0;
    ciudades pushBack _nombre;
    spawner setVariable [_nombre,false,true];
    _dmrk = createMarker [format ["Dum%1",_nombre], _pos];
    _dmrk setMarkerShape "ICON";
    _dmrk setMarkerType "loc_Cross";
    _dmrk setMarkerColor "ColorGUER";
    if (_nroads < _numVeh) then {_numVeh = _nroads};

    [_nombre, [_numCiv, _numVeh, initialPrestigeOPFOR, initialPrestigeBLUFOR]] call AS_fnc_initCity;
    };
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","CityCenter"], 25000]);

{
_nombre = text _x;
if ((_nombre != "") and (_nombre != "Magos")) then//Magos is blacklisted can't remember why, blacklist any hill you desire here
    {
    _sizeX = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (text _x) >> "radiusA");
    _sizeY = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (text _x) >> "radiusB");
    if (_sizeX > _sizeY) then {_size = _sizeX} else {_size = _sizeY};
    _pos = getPos _x;
    if (_size < 10) then {_size = 50};

    _mrk = createmarker [format ["%1", _nombre], _pos];
    _mrk setMarkerSize [_size, _size];
    _mrk setMarkerShape "ELLIPSE";
    _mrk setMarkerBrush "SOLID";
    _mrk setMarkerColor "ColorRed";
    _mrk setMarkerText _nombre;
    colinas pushBack _nombre;
    spawner setVariable [_nombre,false,true];
    _mrk setMarkerAlpha 0;
    };
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Hill"], 25000]);

marcadores = marcadores + colinas + ciudades;
//esto de abajo hay que hacerlo con foreach particulares sin if, en lugar de un foreach general
planesAAFmax = count aeropuertos;
helisAAFmax = 2* (count aeropuertos);
tanksAAFmax = count bases;
APCAAFmax = 2* (count bases);

_fnc_marker = {
    params ["_loc", "_type", "_text"];

    _pos = getMarkerPos _loc;
    _dmrk = createMarker [format ["Dum%1",_loc], _pos];
    _dmrk setMarkerShape "ICON";
    _dmrk setMarkerColor "ColorGUER";
    [_loc] call crearControles;
    garrison setVariable [_loc,[],true];
    _dmrk setMarkerType _type;
    _dmrk setMarkerText _text;
};

{
    [_x, "loc_power", "Power Plant"] call _fnc_marker;
} forEach power;

{
    [_x, "flag_AAF", "AAF Airport"] call _fnc_marker;
    server setVariable [_x,dateToNumber date,true];
} forEach aeropuertos;

{
    [_x, "flag_AAF", "AAF Base"] call _fnc_marker;
    server setVariable [_x,dateToNumber date,true];
} forEach bases;

{
    [_x, "loc_rock", "Resources"] call _fnc_marker;
} forEach recursos;

{
    [_x, "u_installation", "Factory"] call _fnc_marker;
} forEach fabricas;

{
    [_x, "loc_bunker", "AAF AA OP"] call _fnc_marker;
} forEach puestosAA;

{
    [_x, "loc_bunker", "AAF Outpost"] call _fnc_marker;
} forEach puestos;

{
    [_x, "b_naval", "Sea Port"] call _fnc_marker;
} forEach puertos;

mrkAAF = marcadores - ["FIA_HQ"];
publicVariable "mrkAAF";
publicVariable "mrkFIA";
publicVariable "marcadores";
publicVariable "ciudades";
publicVariable "colinas";
publicVariable "colinasAA";
publicVariable "power";
publicVariable "bases";
publicVariable "aeropuertos";
publicVariable "recursos";
publicVariable "fabricas";
publicVariable "puestos";
publicVariable "puestosAA";
publicVariable "controles";
publicVariable "puertos";
publicVariable "destroyedCities";
publicVariable "forcedSpawn";
publicVariable "puestosFIA";
publicVariable "seaMarkers";
publicVariable "campsFIA";
publicVariable "puestosNATO";
/*
planesAAFcurrent = planesAAFmax;
helisAAFcurrent = helisAAFmax;
APCAAFcurrent = APCAAFmax;
tanksAAFcurrent= tanksAAFmax;
*/

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
for "_i" from 0 to (count posbancos - 1) do
    {
    _bancoProv = nearestObjects [posbancos select _i,["Land_Offices_01_V1_F"], 25];
    if (count _bancoProv > 0) then
        {
        _banco = _bancoProv select 0;
        bancos = bancos + [_banco];
        };
    };
//the following is the console code snippet I use to pick positions of any kind of building. You may do this for gas stations, banks, radios etc.. markerPos "Base_4" is because it's in the middle of the island, and inside the array you may find the type of building I am searching for. Paste the result in a txt and add it to the corresponding arrays.
/*
pepe = nearestObjects [markerPos "base_4", ["Land_Offices_01_V1_F"], 16000];
pospepe = [];
{pospepe = pospepe + getPos _x} forEach pepe;
copytoclipboard str pospepe;
*/
if (isMultiplayer) then {[[petros,"hint","Zones Init Completed"],"commsMP"] call BIS_fnc_MP;}