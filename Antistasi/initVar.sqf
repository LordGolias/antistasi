//Antistasi var settings
//If some setting can be modified it will be commented with a // after it.
//Make changes at your own risk!!
//You do not have enough balls to make any modification and after making a Bug report because something is wrong. You don't wanna be there. Believe me.
//Not commented lines cannot be changed.
//Don't touch them.
antistasiVersion = "v 1.7 -- modded";

servidoresOficiales = ["Antistasi Official EU","Antistasi Official EU - TEST", "Antistasi:Altis Official"];//this is for author's fine tune the official servers. If I get you including your server in this variable, I will create a special variable for your server. Understand?

debug = false;//debug variable, not useful for everything..

cleantime = 900;//time to delete dead bodies, vehicles etc..
distanciaSPWN = 1200;//initial spawn distance. Less than 1Km makes parked vehicles spawn in your nose while you approach.
AS_spawnLoopTime = 0.5; // seconds between each check of spawn/despawn locations (expensive loop).

AS_minAISkill = 0.6; // The minimum skill of the AI.
AS_maxAISkill = 0.9; // The maximum skill of the AI.
musicON = true;
civPerc = 0.2;//initial % civ spawn rate
posHQ = getMarkerPos "respawn_west";
//minefieldMrk = [];
minimoFPS = 15;//initial FPS minimum.
//destroyedCities = [];
autoHeal = false;
allowPlayerRecruit = true;
AAFpatrols = 0;//0
planesAAFcurrent = 0;
helisAAFcurrent = 0;
APCAAFcurrent = 0;
tanksAAFcurrent= 0;
savingClient = false;
incomeRep = false;
closeMarkersUpdating = 0;

//All weapons, MOD ones included, will be added to this arrays, but it's useless without integration, as if those weapons don't spawn, players won't be able to collect them, and after, unlock them in the arsenal.
allMagazines = [];
_cfgmagazines = configFile >> "cfgmagazines";
for "_i" from 0 to (count _cfgMagazines) -1 do
	{
	_magazine = _cfgMagazines select _i;
	if (isClass _magazine) then
		{
		_nombre = configName (_magazine);
		allMagazines pushBack _nombre;
		};
	};

mlaunchers = [];
rlaunchers = [];

_allPrimaryWeapons = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 1 } } )
" configClasses ( configFile >> "cfgWeapons" );

_allHandGuns = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 2 } } )
" configClasses ( configFile >> "cfgWeapons" );

_allLaunchers = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 4 } } )
" configClasses ( configFile >> "cfgWeapons" );

_allAccessories = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 131072 } } )
" configClasses ( configFile >> "cfgWeapons" );

_allBackpacks = "(
getNumber ( _x >> ""scope"" ) == 2  
&& {
getNumber ( _x >> ""isbackpack"" ) isEqualTo 1  
&& {
getNumber ( _x >> ""maximumLoad"" ) != 0 
}})" configClasses ( configFile >> "cfgVehicles");

_itemFilter = " 
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2 
    && 
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon"" 
    && 
    { getNumber ( _x >> ""type"" ) isEqualTo 131072 
    && 
    { getNumber ( _x >> ""ItemInfo"" >> ""type"" ) isEqualTo %1 
    } } }) 
";

_allItems = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 4096
})" configClasses ( configFile >> "cfgWeapons" );

_allNVG = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 4096 && {
getText ( _x >> ""simulation"" ) isEqualTo ""NVGoggles""
}})" configClasses ( configFile >> "cfgWeapons" );

_allBinoculars = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 4096 && {
getText ( _x >> ""simulation"" ) isEqualTo ""Binocular""
}})" configClasses ( configFile >> "cfgWeapons" );

_allLDesignators = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 4096 && {
getText ( _x >> ""simulation"" ) isEqualTo ""weapon""
}})" configClasses ( configFile >> "cfgWeapons" );

AS_allItems = [];
{
	AS_allItems pushBack (configName _x);
} forEach _allItems;

AS_allNVG = [];
{
	AS_allNVG pushBack (configName _x);
} forEach _allNVG;

AS_allBinoculars = [];
{
	AS_allBinoculars pushBack (configName _x);
} forEach _allBinoculars + _allLDesignators;

AS_allOptics = [];
AS_allOpticsAttrs = [];
_allOptics = (format [_itemFilter, 201]) configClasses ( configFile >> "cfgWeapons" );
{
	_name = configName _x;
	AS_allOptics pushBack _name;
    _zoomMin = 10000;
    _zoomMax = 0;
    {
        _o_zoomMin = getNumber (_x >> "opticsZoomMin");
        _o_zoomMax = getNumber (_x >> "opticsZoomMax");
        if (_zoomMin > _o_zoomMin) then {_zoomMin = _o_zoomMin;};
        if (_zoomMax < _o_zoomMax) then {_zoomMax = _o_zoomMax;};
    } forEach ("true" configClasses (_x >> "ItemInfo" >> "OpticsModes"));

	AS_allOpticsAttrs pushBack [_zoomMin, _zoomMax];
} forEach _allOptics;

AS_allUAVs = [];
{
	AS_allUAVs pushBack (configName _x);
} forEach ((format [_itemFilter, 621]) configClasses ( configFile >> "cfgWeapons" ));

AS_allMounts = [];
{
	AS_allMounts pushBack (configName _x);
} forEach ((format [_itemFilter, 301]) configClasses ( configFile >> "cfgWeapons" ));

AS_allBipods = [];
_allBipods = (format [_itemFilter, 302]) configClasses ( configFile >> "cfgWeapons" );
{
	AS_allBipods pushBack (configName _x);
} forEach _allBipods;

AS_allMuzzles = [];
_allMuzles = (format [_itemFilter, 101]) configClasses ( configFile >> "cfgWeapons" );
{
	AS_allMuzzles pushBack (configName _x);
} forEach _allMuzles;

// all vests. Used to identify vests that can be used by FIA soldiers.
AS_allVests = [];
AS_allVestsAttrs = [];
_allVests = (format [_itemFilter, 701]) configClasses ( configFile >> "cfgWeapons" );
{
	_name = configName _x;
	AS_allVests pushBack _name;
	_weight = (getNumber (configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "mass"));
	_armor = (getNumber (configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "armor"));
	AS_allVestsAttrs pushBack [_weight, _armor];
} forEach _allVests;

// all helmets. Used to compute the best helmet to be used by FIA soldiers.
AS_allHelmets = [];
AS_allHelmetsAttrs = [];
_allHelmets = (format [_itemFilter, 605]) configClasses ( configFile >> "cfgWeapons" );
{
	_name = configName _x;
	AS_allHelmets pushBack _name;
	_weight = (getNumber (configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "mass"));
	_armor = (getNumber (configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "armor"));
	AS_allHelmetsAttrs pushBack [_weight, _armor];
} forEach _allHelmets;

// all backpacks. Used to compute the best backpack to be used by FIA soldiers.
AS_allBackpacks = [];
AS_allBackpacksAttrs = [];
{
	_name = configName _x;
	AS_allBackpacks pushBack _name;
	_weight = (getNumber (configFile >> "CfgVehicles" >> _name >> "mass"));
	_load = (getNumber (configFile >> "CfgVehicles" >> _name >> "maximumLoad"));
	AS_allBackpacksAttrs pushBack [_weight, _load];
} forEach _allBackpacks;

// All relevant assessories
AS_allAssessories = AS_allBipods + AS_allOptics + AS_allMuzzles + AS_allMounts + AS_allUAVs + AS_allNVG + AS_allBinoculars + (AS_allItems - AS_allNVG - AS_allBinoculars);

private _allUniforms = [];
{
	_allUniforms pushBack (configName _x);
} forEach ((format [_itemFilter, 801]) configClasses ( configFile >> "cfgWeapons" ));

// Assessories that are not reachable in the game.
AS_allOtherAssessories = [];
{
    AS_allOtherAssessories pushBack (configName _x);
} forEach _allAccessories;
AS_allOtherAssessories = AS_allOtherAssessories - (AS_allAssessories + _allUniforms + AS_allVests + AS_allHelmets + AS_allBackpacks);


AS_allMagazines = [];
{
	AS_allMagazines pushBackUnique configName _x;
} forEach ("(getText ( _x >> ""simulation"" ) isEqualTo ""ProxyMagazines"")" configClasses ( configFile >> "CfgMagazines" ));


/*
AssaultRifle
BombLauncher
Cannon
GrenadeLauncher
Handgun
Launcher
MachineGun
Magazine
MissileLauncher
Mortar
RocketLauncher
Shotgun
Throw
Rifle
SubmachineGun
SniperRifle
*/
AS_weapons = [
	[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]
];

AS_allWeapons = [];
AS_allWeaponsAttrs = [];
{
	_name = configName _x;
	_name = [_name] call BIS_fnc_baseWeapon;
	if (not(_name in AS_allWeapons)) then {
		AS_allWeapons pushBack _name;
		_weight = (getNumber (configFile >> "CfgWeapons" >> _name >> "WeaponSlotsInfo" >> "mass"));
		_magazines = (getArray (configFile >> "CfgWeapons" >> _name >> "magazines"));
		_bull_weight = (getNumber (configFile >> "CfgMagazines" >> (_magazines select 0) >> "mass"));
		_bull_speed = (getNumber (configFile >> "CfgMagazines" >> (_magazines select 0) >> "initSpeed"));

		if (isNil "_bull_weight") then {
			_bull_weight = 0;
		};
		if (isNil "_bull_speed") then {
			_bull_speed = 0;
		};

		AS_allWeaponsAttrs pushBack [_weight, _bull_weight*_bull_speed/100*_bull_speed/100, _magazines];

		_weaponType = ([_name] call BIS_fnc_itemType) select 1;

		switch (_weaponType) do {
            case "AssaultRifle": {
                // a sub-optimal fix to not put snipers in this bucket.
                if (_name select [0, 6] != "srifle") then {
                    (AS_weapons select 0) pushBack _name;
                } else {
                    (AS_weapons select 15) pushBack _name;
                };
            };
			case "BombLauncher": {(AS_weapons select 1) pushBack _name};
			case "Cannon": {(AS_weapons select 2) pushBack _name};
			case "GrenadeLauncher": {(AS_weapons select 3) pushBack _name};
			case "Handgun": {(AS_weapons select 4) pushBack _name};
			case "Launcher": {(AS_weapons select 5) pushBack _name};
			case "MachineGun": {(AS_weapons select 6) pushBack _name};
			case "Magazine": {(AS_weapons select 7) pushBack _name};
			case "MissileLauncher": {(AS_weapons select 8) pushBack _name};
			case "Mortar": {(AS_weapons select 9) pushBack _name};
			case "RocketLauncher": {(AS_weapons select 10) pushBack _name};
			case "Shotgun": {(AS_weapons select 11) pushBack _name};
			case "Throw": {(AS_weapons select 12) pushBack _name};
			case "Rifle": {(AS_weapons select 13) pushBack _name};
			case "SubmachineGun": {(AS_weapons select 14) pushBack _name};
			case "SniperRifle": {(AS_weapons select 15) pushBack _name};
		};
	};
} forEach _allPrimaryWeapons + _allHandGuns + _allLaunchers;

// default unlocked items.
call compile preprocessFileLineNumbers "initUnlocked.sqf";

/////////////////////// Mods detection ///////////////////////
hayRHS = false;
hayUSAF = false;
hayGREF = false;
hayACE = false;
hayBE = false;

hayACEhearing = false;
hayACEMedical = false;
if (!isNil "ace_common_settingFeedbackIcons") then {
	hayACE = true;
	if (isClass (configFile >> "CfgSounds" >> "ACE_EarRinging_Weak")) then {
		hayACEhearing = true;
	};
	if (isClass (ConfigFile >> "CfgSounds" >> "ACE_heartbeat_fast_3") and
        (ace_medical_level != 0)) then {
		hayACEMedical = true;
	};

    // modifies unlockedItems
    call compile preprocessFileLineNumbers "initACE.sqf";
};

//rhs detection and integration
if ("rhs_weap_akms" in AS_allWeapons) then {
	hayRHS = true;
};
if ("rhs_weap_m4a1_d" in AS_allWeapons) then {
	hayUSAF = true;
};

missionPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;

//------------------ unit module ------------------//


// all statics, used to calculate defensive strength when spawning attacks -- templates add OPFOR statics
allStatMGs = 		["B_HMG_01_high_F"];
allStatATs = 		["B_static_AT_F"];
allStatAAs = 		["B_static_AA_F"];
allStatMortars = 	["B_G_Mortar_01_F"];

side_blue = west; // <<<<<< player side, always, at all times, no exceptions
side_green = independent;
side_red = east;

lrRadio = "";

vfs = [];

// Initialisation of units and gear
vehFIA = [];
if (hayRHS) then {
	call compile preprocessFileLineNumbers "CREATE\templateRHS.sqf";
	call compile preprocessFileLineNumbers "CREATE\templateVMF.sqf";
}
else {
	call compile preprocessFileLineNumbers "CREATE\templateAAF.sqf";
	call compile preprocessFileLineNumbers "CREATE\templateOPFOR_CSAT.sqf";
};

if (hayUSAF) then {
	call compile preprocessFileLineNumbers "CREATE\templateUSAF.sqf";
}
else {
	call compile preprocessFileLineNumbers "CREATE\templateNATO.sqf";
};

// deprecated variables, used to maintain compatibility
vehAAFAT = enemyMotorpool;
planesAAF = indAirForce;
soldadosAAF = infList_sniper + infList_NCO + infList_special + infList_auto + infList_regular + infList_crew + infList_pilots;
//------------------ /unit module ------------------//

#include "Compositions\spawnPositions.sqf"
#include "Functions\clientFunctions.sqf"
#include "Functions\gearFunctions.sqf"

if (!isServer and hasInterface) exitWith {};

AAFpatrols = 0;//0
skillAAF = 0;
AS_maxSkill = 20;
smallCAmrk = [];
smallCApos = [];

// camps
campsFIA = [];
campList = [];
campNames = ["Camp Spaulding","Camp Wagstaff","Camp Firefly","Camp Loophole","Camp Quale","Camp Driftwood","Camp Flywheel","Camp Grunion","Camp Kornblow","Camp Chicolini","Camp Pinky",
			"Camp Fieramosca","Camp Bulldozer","Camp Bambino","Camp Pedersoli"];
usedCN = [];
cName = "";
cList = false;

// roadblocks and watchposts
FIA_RB_list = [];
FIA_WP_list = [];

expCrate = ""; // Devin's crate

// load functions required by the server and headless clients
#include "Functions\serverFunctions.sqf"
#include "Functions\QRFfunctions.sqf"
#include "Functions\maintenance.sqf"

if (!isServer) exitWith {};

server setVariable ["milActive", 0, true];
server setVariable ["civActive", 0, true];
server setVariable ["expActive", false, true];
server setVariable ["blockCSAT", false, true];
server setVariable ["jTime", 0, true];

server setVariable ["lockTransfer", false, true];

//Pricing values for soldiers, vehicles
{server setVariable [_x,50,true]} forEach ["B_G_Soldier_F","B_G_Soldier_lite_F","b_g_soldier_unarmed_f"];
{server setVariable [_x,100,true]} forEach ["B_G_Soldier_AR_F","B_G_medic_F","B_G_engineer_F","B_G_Soldier_exp_F","B_G_Soldier_GL_F","B_G_Soldier_TL_F","B_G_Soldier_A_F"];
{server setVariable [_x,150,true]} forEach ["B_G_Soldier_M_F","B_G_Soldier_LAT_F","B_G_Soldier_SL_F","B_G_officer_F","B_G_Sharpshooter_F","Soldier_AA"];
{server setVariable [_x,100,true]} forEach ["I_crew_F","O_crew_F","C_man_1"];
{server setVariable [_x,100,true]} forEach infList_regular;
{server setVariable [_x,150,true]} forEach infList_auto;
{server setVariable [_x,150,true]} forEach infList_crew;
{server setVariable [_x,150,true]} forEach infList_pilots;
{server setVariable [_x,200,true]} forEach infList_special;
{server setVariable [_x,200,true]} forEach infList_NCO;
{server setVariable [_x,200,true]} forEach infList_sniper;

server setVariable ["C_Offroad_01_F",300,true];//200
server setVariable ["C_Van_01_transport_F",600,true];//600
server setVariable ["C_Heli_Light_01_civil_F",12000,true];//12000
server setVariable ["B_G_Quadbike_01_F",50,true];//50
server setVariable ["B_G_Offroad_01_F",200,true];//200
server setVariable ["B_G_Van_01_transport_F",450,true];//300
server setVariable ["B_G_Offroad_01_armed_F",700,true];//700
{server setVariable [_x,400,true]} forEach ["B_HMG_01_high_F","B_G_Boat_Transport_01_F","B_G_Offroad_01_repair_F"];//400
{server setVariable [_x,800,true]} forEach ["B_G_Mortar_01_F","B_static_AT_F","B_static_AA_F"];//800

server setVariable [vfs select 0,300,true];
server setVariable [vfs select 1,600,true];//600
server setVariable [vfs select 2,6000,true];//12000
server setVariable [vfs select 3,50,true];//50
server setVariable [vfs select 4,200,true];//200
server setVariable [vfs select 5,450,true];//300
server setVariable [vfs select 6,700,true];//700
server setVariable [vfs select 7,400,true];//700
server setVariable [vfs select 8,800,true];
server setVariable [vfs select 9,800,true];
server setVariable [vfs select 10,800,true];

if (hayRHS) then {
	server setVariable [vfs select 2,6000,true];
	server setVariable [vfs select 11,5000,true];
	server setVariable [vfs select 12,600,true];
	server setVariable [vehTruckAA, 800, true];
};

server setVariable ["hr",8,true];//initial HR value
server setVariable ["resourcesFIA",1000,true];//Initial FIA money pool value
server setVariable ["resourcesAAF",0,true];//Initial AAF resources
server setVariable ["skillFIA",0,true];//Initial skill level for FIA soldiers
server setVariable ["prestigeNATO",5,true];//Initial Prestige NATO
server setVariable ["prestigeCSAT",5,true];//Initial Prestige CSAT

server setVariable ["enableFTold",false,true]; // extended fast travel mode
server setVariable ["enableMemAcc",false,true]; // simplified arsenal access

// todo: this option is not being saved, so it is irrelevant. Consider removing.
server setVariable ["enableWpnProf",false,true]; // class-based weapon proficiences, MP only

server setVariable ["easyMode",false,true]; // higher income
server setVariable ["hardMode",false,true];
server setVariable ["testMode",false,true];

staticsToSave = []; publicVariable "staticsToSave";

initialPrestigeOPFOR = 50; //Initial % support for AAF on each city
if (not cadetMode) then {initialPrestigeOPFOR = 75}; //if you play on vet, this is the number
initialPrestigeBLUFOR = 0; //Initial % FIA support on each city

planesAAFmax = 0;
helisAAFmax = 0;
APCAAFmax = 0;
tanksAAFmax = 0;
cuentaCA = 600;//600
prestigeIsChanging = false;
cityIsSupportChanging = false;
resourcesIsChanging = false;
savingServer = false;
misiones = [];
revelar = false;

vehInGarage = ["C_Van_01_transport_F","C_Offroad_01_F","C_Offroad_01_F","B_G_Quadbike_01_F","B_G_Quadbike_01_F","B_G_Quadbike_01_F"]; // initial motorpool
destroyedBuildings = []; publicVariable "destroyedBuildings";
reportedVehs = [];
hayTFAR = false;
//TFAR detection and config.
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then
    {
    hayTFAR = true;
    unlockedItems = unlockedItems + ["tf_anprc152", "ItemRadio"];//making this items Arsenal available.
    tf_no_auto_long_range_radio = true; publicVariable "tf_no_auto_long_range_radio";//set to false and players will start with LR radio, uncomment the last line of so.
	//tf_give_personal_radio_to_regular_soldier = false;
	tf_west_radio_code = "";publicVariable "tf_west_radio_code";//to make enemy vehicles usable as LR radio
	tf_east_radio_code = tf_west_radio_code; publicVariable "tf_east_radio_code"; //to make enemy vehicles usable as LR radio
	tf_guer_radio_code = tf_west_radio_code; publicVariable "tf_guer_radio_code";//to make enemy vehicles usable as LR radio
	tf_same_sw_frequencies_for_side = true; publicVariable "tf_same_sw_frequencies_for_side";
	tf_same_lr_frequencies_for_side = true; publicVariable "tf_same_lr_frequencies_for_side";
    //unlockedBackpacks pushBack "tf_rt1523g_sage";//uncomment this if you are adding LR radios for players
    };

// texture mod detection
FIA_texturedVehicles = [];
FIA_texturedVehicleConfigs = [];
_allVehicles = configFile >> "CfgVehicles";
for "_i" from 0 to (count _allVehicles - 1) do {
    _vehicle = _allVehicles select _i;
    if (toUpper (configName _vehicle) find "DGC_FIAVEH" >= 0) then {
    	FIA_texturedVehicles pushBackUnique (configName _vehicle);
    	FIA_texturedVehicleConfigs pushBackUnique _vehicle;
    };
};

#include "Scripts\BE_modul.sqf"
[] call fnc_BE_initialize;
if !(isNil "BE_INIT") then {hayBE = true; publicVariable "hayBE"};

// texture mod detection
FIA_texturedVehicles = [];
FIA_texturedVehicleConfigs = [];
_allVehicles = configFile >> "CfgVehicles";
for "_i" from 0 to (count _allVehicles - 1) do {
    _vehicle = _allVehicles select _i;
    if (toUpper (configName _vehicle) find "DGC_FIAVEH" >= 0) then {
    	FIA_texturedVehicles pushBackUnique (configName _vehicle);
    	FIA_texturedVehicleConfigs pushBackUnique _vehicle;
    };
};

if (worldName == "Altis") then {
	{
		server setVariable [_x select 0,_x select 1]
	} forEach [
		["Therisa",154],["Zaros",371],["Poliakko",136],["Katalaki",95],["Alikampos",115],["Neochori",309],["Stavros",122],["Lakka",173],["AgiosDionysios",84],["Panochori",264],["Topolia",33],["Ekali",9],["Pyrgos",531],["Orino",45],["Neri",242],["Kore",133],["Kavala",660],["Aggelochori",395],["Koroni",32],["Gravia",291],["Anthrakia",143],["Syrta",151],["Negades",120],["Galati",151],["Telos",84],["Charkia",246],["Athira",342],["Dorida",168],["Ifestiona",48],["Chalkeia",214],["AgiosKonstantinos",39],["Abdera",89],["Panagia",91],["Nifi",24],["Rodopoli",212],["Kalithea",36],["Selakano",120],["Frini",69],["AgiosPetros",11],["Feres",92],["AgiaTriada",8],["Paros",396],["Kalochori",189],["Oreokastro",63],["Ioannina",48],["Delfinaki",29],["Sofia",179],["Molos",188]
		];
	call compile preprocessFileLineNumbers "roadsDB.sqf";
};

publicVariable "unlockedWeapons";
publicVariable "unlockedItems";
publicVariable "unlockedBackpacks";
publicVariable "unlockedMagazines";
publicVariable "miembros";
publicVariable "vehInGarage";
publicVariable "reportedVehs";
publicVariable "hayACE";
publicVariable "hayTFAR";
publicVariable "hayACEhearing";
publicVariable "hayACEMedical";
publicVariable "skillAAF";
publicVariable "misiones";
publicVariable "revelar";
publicVariable "FIA_texturedVehicles";
publicVariable "FIA_texturedVehicleConfigs";
publicVariable "hayBE";
publicVariable "FIA_WP_list";
publicVariable "FIA_RB_list";

if (isMultiplayer) then {[[petros,"hint","Variables Init Completed"],"commsMP"] call BIS_fnc_MP;};