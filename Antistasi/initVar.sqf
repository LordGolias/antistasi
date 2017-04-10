#include "macros.hpp"
//Antistasi var settings
//If some setting can be modified it will be commented with a // after it.
//Make changes at your own risk!!
//You do not have enough balls to make any modification and after making a Bug report because something is wrong. You don't wanna be there. Believe me.
//Not commented lines cannot be changed.
//Don't touch them.
antistasiVersion = "v 1.7 -- modded";

servidoresOficiales = ["Antistasi Official EU","Antistasi Official EU - TEST", "Antistasi:Altis Official"];//this is for author's fine tune the official servers. If I get you including your server in this variable, I will create a special variable for your server. Understand?

// AS_Pset(a,b) is a macro to `(AS_persistent setVariable (a,b,true))`. It is just easier to write.

// These are options for the initial situation.
AS_Pset("hr",8); //initial HR value
AS_Pset("resourcesFIA",1000); //Initial FIA money pool value

AS_Pset("resourcesAAF",0); //Initial AAF resources
AS_Pset("skillFIA",0); //Initial skill level of FIA
AS_Pset("skillAAF",0); //Initial skill level of AAF
AS_Pset("prestigeNATO",5); //Initial Prestige NATO
AS_Pset("prestigeCSAT",5); //Initial Prestige CSAT

// These are game options that are saved.
AS_Pset("civPerc",0.05); //initial % civ spawn rate
AS_Pset("enableFTold",false); // extended fast travel mode
AS_Pset("spawnDistance",1200); //initial spawn distance. Less than 1Km makes parked vehicles spawn in your nose while you approach.
AS_Pset("minimumFPS",15); //initial minimum FPS. This value can be changed in a menu.
AS_Pset("cleantime",20*60); // time to delete dead bodies and vehicles.
AS_Pset("minAISkill",0.6); // The minimum skill of the AAF/FIA AI (at lowest skill level)
AS_Pset("maxAISkill",0.9); // The maximum skill of the AAF/FIA AI (at highest skill level)

AS_spawnLoopTime = 0.5; // seconds between each check of spawn/despawn locations (expensive loop).
musicON = true;
// todo: have a menu to switch this behaviour
switchCom = false;  // Game will not auto assign Commander position to the highest ranked player

// we set the maker on petros so the HQ position is correct in new games.
"respawn_west" setMarkerPos (position petros);
"FIA_HQ" setMarkerPos (position petros);
//minefieldMrk = [];
//destroyedCities = [];
autoHeal = false;
allowPlayerRecruit = true;
AAFpatrols = 0;//0

savingClient = false;
incomeRep = false;

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

///////////////////////// INITIALIZE UNITS /////////////////////////
call AS_fnc_AAFarsenal_init;

// all statics, used to calculate defensive strength when spawning attacks -- templates add OPFOR statics
allStatMGs = 		["B_HMG_01_high_F"];
allStatATs = 		["B_static_AT_F"];
allStatAAs = 		["B_static_AA_F"];
allStatMortars = 	["B_G_Mortar_01_F"];

side_blue = west; // <<<<<< player side, always, at all times, no exceptions
side_green = independent;
side_red = east;

lrRadio = "";

// Initialisation of units and gear
if (hayRHS) then {
	call compile preprocessFileLineNumbers "templates\RHS.sqf";
	call compile preprocessFileLineNumbers "templates\VMF.sqf";
}
else {
	call compile preprocessFileLineNumbers "templates\AAF.sqf";
	call compile preprocessFileLineNumbers "templates\CSAT.sqf";
};

if (hayUSAF) then {
	call compile preprocessFileLineNumbers "templates\USAF.sqf";
}
else {
	call compile preprocessFileLineNumbers "templates\NATO.sqf";
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
soldadosAAF = infList_sniper + infList_NCO + infList_special + infList_auto + infList_regular + infList_crew + infList_pilots;

call compile preprocessFileLineNumbers "templates\FIA.sqf";

//------------------ /unit module ------------------//

#include "Compositions\spawnPositions.sqf"
#include "Functions\clientFunctions.sqf"
#include "Functions\gearFunctions.sqf"
call compile preprocessFileLineNumbers "templates\basicLists.sqf";

if (!isServer and hasInterface) exitWith {};

// Compositions used to spawn camps, etc.
call compile preprocessFileLineNumbers "Compositions\campList.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpMTN.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpOP.sqf";
call compile preprocessFileLineNumbers "Compositions\FIA_RB.sqf";


AAFpatrols = 0;//0
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

AS_data_allCosts setVariable [vehFIA select 0,300,true];
AS_data_allCosts setVariable [vehFIA select 1,600,true];//600
AS_data_allCosts setVariable [vehFIA select 2,6000,true];//12000
AS_data_allCosts setVariable [vehFIA select 3,50,true];//50
AS_data_allCosts setVariable [vehFIA select 4,200,true];//200
AS_data_allCosts setVariable [vehFIA select 5,450,true];//300
AS_data_allCosts setVariable [vehFIA select 6,700,true];//700
AS_data_allCosts setVariable [vehFIA select 7,400,true];//700
AS_data_allCosts setVariable [vehFIA select 8,800,true];
AS_data_allCosts setVariable [vehFIA select 9,800,true];
AS_data_allCosts setVariable [vehFIA select 10,800,true];

if (hayRHS) then {
	AS_data_allCosts setVariable [vehFIA select 2,6000,true];
	AS_data_allCosts setVariable [vehFIA select 11,5000,true];
	AS_data_allCosts setVariable [vehFIA select 12,600,true];
	AS_data_allCosts setVariable [vehTruckAA, 800, true];
	AS_data_allCosts setVariable [vehTruckAA, 800, true];
};

// todo: this option is not being saved, so it is irrelevant. Consider removing.
server setVariable ["enableWpnProf",false,true]; // class-based weapon proficiences, MP only

staticsToSave = []; publicVariable "staticsToSave";

initialPrestigeOPFOR = 50; //Initial % support for AAF on each city
if (not cadetMode) then {initialPrestigeOPFOR = 75}; //if you play on vet, this is the number
initialPrestigeBLUFOR = 0; //Initial % FIA support on each city

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
publicVariable "misiones";
publicVariable "revelar";
publicVariable "FIA_texturedVehicles";
publicVariable "FIA_texturedVehicleConfigs";
publicVariable "hayBE";
publicVariable "FIA_WP_list";
publicVariable "FIA_RB_list";
