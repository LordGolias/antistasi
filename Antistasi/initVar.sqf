//Antistasi var settings
//If some setting can be modified it will be commented with a // after it.
//Make changes at your own risk!!
//You do not have enough balls to make any modification and after making a Bug report because something is wrong. You don't wanna be there. Believe me.
//Not commented lines cannot be changed.
//Don't touch them.
antistasiVersion = "v 1.7 -- modded";

servidoresOficiales = ["Antistasi Official EU","Antistasi Official EU - TEST", "Antistasi:Altis Official"];//this is for author's fine tune the official servers. If I get you including your server in this variable, I will create a special variable for your server. Understand?

cleantime = 900;//time to delete dead bodies, vehicles etc..
distanciaSPWN = 1200;//initial spawn distance. Less than 1Km makes parked vehicles spawn in your nose while you approach.
AS_spawnLoopTime = 0.5; // seconds between each check of spawn/despawn locations (expensive loop).

AS_minAISkill = 0.6; // The minimum skill of the AI.
AS_maxAISkill = 0.9; // The maximum skill of the AI.
musicON = true;
civPerc = 0.2;//initial % civ spawn rate

// todo: have a menu to switch this behaviour
switchCom = false;  // Game will not auto assign Commander position to the highest ranked player

// we set the maker on petros so the HQ position is correct in new games.
"respawn_west" setMarkerPos (position petros);
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

call compile preprocessFileLineNumbers "initItems.sqf";

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

// populate AAF items with relevant meds.
if (hayACE) then {
    if (ace_medical_level == 0) then {
        AAFItems append ["FirstAidKit","Medikit"];
    };
    if (ace_medical_level >= 1) then {
        AAFItems append AS_aceBasicMedical;
    };
    if (ace_medical_level == 2) then {
        AAFItems append AS_aceAdvMedical;
    };
} else {
    AAFItems append ["FirstAidKit","Medikit"];
};

// deprecated variables, used to maintain compatibility
vehAAFAT = enemyMotorpool;
planesAAF = indAirForce;
soldadosAAF = infList_sniper + infList_NCO + infList_special + infList_auto + infList_regular + infList_crew + infList_pilots;
//------------------ /unit module ------------------//

#include "Compositions\spawnPositions.sqf"
#include "Functions\clientFunctions.sqf"
#include "Functions\gearFunctions.sqf"
call compile preprocessFileLineNumbers "Lists\gearList.sqf";
call compile preprocessFileLineNumbers "Lists\basicLists.sqf";

if (!isServer and hasInterface) exitWith {};

// Compositions used to spawn camps, etc.
call compile preprocessFileLineNumbers "Compositions\campList.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpMTN.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpOP.sqf";
call compile preprocessFileLineNumbers "Compositions\FIA_RB.sqf";


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
{AS_data_allCosts setVariable [_x,50,true]} forEach ["B_G_Soldier_F","B_G_Soldier_lite_F","b_g_soldier_unarmed_f"];
{AS_data_allCosts setVariable [_x,100,true]} forEach ["B_G_Soldier_AR_F","B_G_medic_F","B_G_engineer_F","B_G_Soldier_exp_F","B_G_Soldier_GL_F","B_G_Soldier_TL_F","B_G_Soldier_A_F"];
{AS_data_allCosts setVariable [_x,150,true]} forEach ["B_G_Soldier_M_F","B_G_Soldier_LAT_F","B_G_Soldier_SL_F","B_G_officer_F","B_G_Sharpshooter_F","Soldier_AA"];
{AS_data_allCosts setVariable [_x,100,true]} forEach ["I_crew_F","O_crew_F","C_man_1"];
{AS_data_allCosts setVariable [_x,100,true]} forEach infList_regular;
{AS_data_allCosts setVariable [_x,150,true]} forEach infList_auto;
{AS_data_allCosts setVariable [_x,150,true]} forEach infList_crew;
{AS_data_allCosts setVariable [_x,150,true]} forEach infList_pilots;
{AS_data_allCosts setVariable [_x,200,true]} forEach infList_special;
{AS_data_allCosts setVariable [_x,200,true]} forEach infList_NCO;
{AS_data_allCosts setVariable [_x,200,true]} forEach infList_sniper;

AS_data_allCosts setVariable ["C_Offroad_01_F",300,true];//200
AS_data_allCosts setVariable ["C_Van_01_transport_F",600,true];//600
AS_data_allCosts setVariable ["C_Heli_Light_01_civil_F",12000,true];//12000
AS_data_allCosts setVariable ["B_G_Quadbike_01_F",50,true];//50
AS_data_allCosts setVariable ["B_G_Offroad_01_F",200,true];//200
AS_data_allCosts setVariable ["B_G_Van_01_transport_F",450,true];//300
AS_data_allCosts setVariable ["B_G_Offroad_01_armed_F",700,true];//700
{AS_data_allCosts setVariable [_x,400,true]} forEach ["B_HMG_01_high_F","B_G_Boat_Transport_01_F","B_G_Offroad_01_repair_F"];//400
{AS_data_allCosts setVariable [_x,800,true]} forEach ["B_G_Mortar_01_F","B_static_AT_F","B_static_AA_F"];//800

AS_data_allCosts setVariable [vfs select 0,300,true];
AS_data_allCosts setVariable [vfs select 1,600,true];//600
AS_data_allCosts setVariable [vfs select 2,6000,true];//12000
AS_data_allCosts setVariable [vfs select 3,50,true];//50
AS_data_allCosts setVariable [vfs select 4,200,true];//200
AS_data_allCosts setVariable [vfs select 5,450,true];//300
AS_data_allCosts setVariable [vfs select 6,700,true];//700
AS_data_allCosts setVariable [vfs select 7,400,true];//700
AS_data_allCosts setVariable [vfs select 8,800,true];
AS_data_allCosts setVariable [vfs select 9,800,true];
AS_data_allCosts setVariable [vfs select 10,800,true];

if (hayRHS) then {
	AS_data_allCosts setVariable [vfs select 2,6000,true];
	AS_data_allCosts setVariable [vfs select 11,5000,true];
	AS_data_allCosts setVariable [vfs select 12,600,true];
	AS_data_allCosts setVariable [vehTruckAA, 800, true];
	AS_data_allCosts setVariable [vehTruckAA, 800, true];
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

call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";

publicVariable "switchCom";

publicVariable "unlockedWeapons";
publicVariable "unlockedItems";
publicVariable "unlockedBackpacks";
publicVariable "unlockedMagazines";
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
