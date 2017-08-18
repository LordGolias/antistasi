/*
This file runs on every machine (server+client) and initializes different
variables.
Variables that are published, like
	- those that use `publicVariable`
	- those that use `setVariable [...,...,true]`
must be initialized only in the server (using `if (isServer)`).
*/
#include "macros.hpp"

// todo: remove this variable
antistasiVersion = "v 1.7 -- modded";

servidoresOficiales = [
	"Antistasi Official EU",
	"Antistasi Official EU - TEST",
	"Antistasi:Altis Official"
];

// Whether the autoHeal system is activated for this client.
autoHeal = false;

// Ordered ranks used to rank players
AS_ranks = [
	"PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"
];
AS_rank_abbreviations = [
	"PRV", "CPL", "SGT", "LT", "CPT", "MAJ", "COL"
];

// UPSMON is used for all kinds of AI patrolling. We initialize it here
// so any client can spawn patrols.
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";

// Defines lists of available items and properties used to select best items.
// todo: move this to a shared LOGIC object and initialize it once on the server.
// reasoning: this is expensive and should be made only by a single machine.
call compile preprocessFileLineNumbers "initItems.sqf";
call compile preprocessFileLineNumbers "templates\basicLists.sqf";

// Identifies mods.
hayRHS = false;
hayACE = false;

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
	// Lists of items used by ACE medical system. These are used
	// below to define what factions use and what is unlocked
	AS_aceBasicMedical = [
		"ACE_fieldDressing", "ACE_bloodIV_250", "ACE_bloodIV_500",
		"ACE_bloodIV", "ACE_epinephrine", "ACE_morphine", "ACE_bodyBag"
	];

	AS_aceAdvMedical = [
		"ACE_salineIV_250", "ACE_salineIV_500", "ACE_salineIV",
		"ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_plasmaIV",
		"ACE_packingBandage", "ACE_elasticBandage",
		"ACE_quikclot", "ACE_tourniquet", "ACE_atropine","ACE_adenosine",
		"ACE_personalAidKit", "ACE_surgicalKit"
	];
};

// todo: do not rely on AS_allWeapons to check for mods.
if ("rhs_weap_akms" in AS_allWeapons) then {
	hayRHS = true;
};

// todo: do not rely on AS_allWeapons to check for mods.
hasCUP = false;
if ("CUP_arifle_AKS74U" in AS_allWeapons) then {
	hasCUP = true;
};

// This is needed to find the sounds of dog's barking, so it is in every client
missionPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;

// Templates below modify server-side content so the server has to initialize
// some things at this point.
if (isServer) then {
	// Initializes unlocked stuff. These are modified by templates and ACE and
	// are published by the server in the end of this script
	unlockedWeapons = [];
	unlockedMagazines = [];
	unlockedBackpacks = [];
	unlockedItems = [
		"Binocular",
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"FirstAidKit",
		"Medikit"
	];

	// add content to the unlocked items depending on the ACE.
	if (hayACE) then {
		call compile preprocessFileLineNumbers "initACE.sqf";
	};

	// This variable stores what vehicles the AAF can spawn and for how much.
	AS_AAFArsenal = (createGroup sideLogic) createUnit ["LOGIC",[0, 0, 0] , [], 0, ""];
	publicVariable "AS_AAFArsenal";
	call AS_fnc_AAFarsenal_init;  // sets default prices and other variables.

	// Stores everything related to what units and squads the FIA can recruit (and costs)
	AS_FIArecruitment = (createGroup sideLogic) createUnit ["LOGIC",[0, 0, 0] , [], 0, ""];
	publicVariable "AS_FIArecruitment";
	AS_data_allCosts = (createGroup sideLogic) createUnit ["LOGIC",[0, 0, 0] , [], 0, ""];
	publicVariable "AS_data_allCosts";
};

call compile preprocessFileLineNumbers "templates\FIA.sqf";

// todo: improve statics in general.
allStatMGs = 		["B_HMG_01_high_F"];
allStatATs = 		["B_static_AT_F"];
allStatAAs = 		["B_static_AA_F"];
allStatMortars = 	["B_G_Mortar_01_F"];

// This processes the templates and adds variables accordingly.
// The templates use `if(isServer)` when the variables are server-sided.
// For clients, they only initialize non-public globals.
call {
	if (hayRHS) exitWith {
		call compile preprocessFileLineNumbers "templates\AAF_RHS.sqf";
		call compile preprocessFileLineNumbers "templates\CSAT_RHS.sqf";
		call compile preprocessFileLineNumbers "templates\NATO_RHS.sqf";
		call compile preprocessFileLineNumbers "templates\FIA_RHS.sqf";
	};
	if hasCUP exitWith {
		call compile preprocessFileLineNumbers "templates\AAF_CUP.sqf";
		call compile preprocessFileLineNumbers "templates\CSAT_CUP.sqf";
		call compile preprocessFileLineNumbers "templates\NATO_CUP.sqf";
		call compile preprocessFileLineNumbers "templates\FIA_CUP.sqf";
	};
	// fallback to the default template
	call compile preprocessFileLineNumbers "templates\AAF.sqf";
	call compile preprocessFileLineNumbers "templates\CSAT.sqf";
	call compile preprocessFileLineNumbers "templates\NATO.sqf";
};

// Initializes all AAF/NATO/CSAT items (e.g. weapons, mags) from the global variables
// in the templates above. Only non-public globals defined.
call compile preprocessFileLineNumbers "initItemsSides.sqf";

// Compositions used to spawn camps, etc. Only non-public globals defined.
call compile preprocessFileLineNumbers "Compositions\campList.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpMTN.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpOP.sqf";
call compile preprocessFileLineNumbers "Compositions\FIA_RB.sqf";

/////////////////////////////////////////////////////////////////////////
/////////////////////// CLIENT INIT FINISHES HERE ///////////////////////
/////////////////////////////////////////////////////////////////////////
if (!isServer) exitWith {};
/////////////////////////////////////////////////////////////////////////
///////////////////////////// SERVER ONLY ///////////////////////////////
/////////////////////////////////////////////////////////////////////////

// Below this point, everything defined only belongs to the server

// create container to store missions
["mission", true] call AS_fnc_container_add;

// Picks the stuff defined for FIA above and merges it in a single interface
call compile preprocessFileLineNumbers "initFIA.sqf";

// todo: re-add support for TFAR. This is probably needed by it.
lrRadio = "";

// number of patrols currently spawned. In the future, this should be a client variable
// as clients will be able to spawn stuff.
AAFpatrols = 0;

// Names of camps used when the camp is spawned.
campNames = ["Spaulding","Wagstaff","Firefly","Loophole","Quale","Driftwood","Flywheel","Grunion","Kornblow","Chicolini","Pinky",
			"Fieramosca","Bulldozer","Bambino","Pedersoli"];

// todo: improve this.
expCrate = ""; // dealer's crate

// todo: have a menu to switch this behaviour
switchCom = false;  // Game will not auto assign Commander position to the highest ranked player
publicVariable "switchCom";

///////////////////////// PERSISTENTS /////////////////////////

// AS_Pset(a,b) is a macro to `(AS_persistent setVariable (a,b,true))`.
// P from persistent as these variables are saved persistently.

// List of locations that are being patrolled.
AS_Pset("patrollingLocations", []);
AS_Pset("patrollingPositions", []);

// These are default values for the start.
AS_Pset("hr",8); //initial HR value
AS_Pset("resourcesFIA",1000); //Initial FIA money pool value

AS_Pset("resourcesAAF",0); //Initial AAF resources
AS_Pset("skillFIA",0); //Initial skill level of FIA
AS_Pset("skillAAF",0); //Initial skill level of AAF
AS_Pset("NATOsupport",5); //Initial NATO support
AS_Pset("CSATsupport",5); //Initial CSAT support

AS_Pset("secondsForAAFattack",600);  // The time for the attack script to be run
AS_Pset("destroyedLocations", []); // Locations that are destroyed (can be repaired)
AS_Pset("vehicles", []);  // list of vehicles that are saved in the map

// list of positions where closest building is destroyed.
// The buildings that belong to this are in `AS_destroyable_buildings`.
AS_Pset("destroyedBuildings", []);

// todo: make this random
private _vehs = [
	"C_Van_01_transport_F","C_Offroad_01_F","C_Offroad_01_F",
	"B_G_Quadbike_01_F","B_G_Quadbike_01_F","B_G_Quadbike_01_F"
];
AS_Pset("vehiclesInGarage", _vehs);

// These are game options that are saved.
AS_Pset("civPerc",0.05); //initial % civ spawn rate
AS_Pset("spawnDistance",1200); //initial spawn distance. Less than 1Km makes parked vehicles spawn in your nose while you approach.
AS_Pset("minimumFPS",15); //initial minimum FPS. This value can be changed in a menu.
AS_Pset("cleantime",20*60); // time to delete dead bodies and vehicles.
AS_Pset("minAISkill",0.6); // The minimum skill of the AAF/FIA AI (at lowest skill level)
AS_Pset("maxAISkill",0.9); // The maximum skill of the AAF/FIA AI (at highest skill level)

// AS_Sset(a,b) is a macro to `(server setVariable (a,b,true))`.
// S of [s]hared. These variables are not saved persistently.
AS_Sset("revealFromRadio",false);

// Used to make a transfer to `caja` atomic
AS_Sset("lockTransfer", false);

// This sets whether the CSAT can attack or not. The FIA has an option to block
// attacks by jamming radio signals (close to flags with towers)
AS_Sset("blockCSAT", false);

// list of vehicles (objects) that can no longer be used while undercover
AS_Sset("reportedVehs", []);

// todo: this option is not being saved, so it is irrelevant. Consider removing.
AS_Sset("enableWpnProf",false); // class-based weapon proficiences, MP only

AS_spawnLoopTime = 1; // seconds between each check of spawn/despawn locations (expensive loop).

// Pricing values for soldiers, vehicles of AAF
{AS_data_allCosts setVariable [_x,100,true]} forEach infList_regular;
{AS_data_allCosts setVariable [_x,150,true]} forEach infList_auto;
{AS_data_allCosts setVariable [_x,150,true]} forEach infList_crew;
{AS_data_allCosts setVariable [_x,150,true]} forEach infList_pilots;
{AS_data_allCosts setVariable [_x,200,true]} forEach infList_special;
{AS_data_allCosts setVariable [_x,200,true]} forEach infList_NCO;
{AS_data_allCosts setVariable [_x,200,true]} forEach infList_sniper;
{AS_data_allCosts setVariable [_x,300,true]} forEach infList_officers;

//TFAR detection and config.
hayTFAR = false;
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    hayTFAR = true;
    unlockedItems = unlockedItems + ["tf_anprc152", "ItemRadio"];
    tf_no_auto_long_range_radio = true; publicVariable "tf_no_auto_long_range_radio";//set to false and players will start with LR radio, uncomment the last line of so.
	//tf_give_personal_radio_to_regular_soldier = false;
	tf_west_radio_code = "";publicVariable "tf_west_radio_code";//to make enemy vehicles usable as LR radio
	tf_east_radio_code = tf_west_radio_code; publicVariable "tf_east_radio_code"; //to make enemy vehicles usable as LR radio
	tf_guer_radio_code = tf_west_radio_code; publicVariable "tf_guer_radio_code";//to make enemy vehicles usable as LR radio
	tf_same_sw_frequencies_for_side = true; publicVariable "tf_same_sw_frequencies_for_side";
	tf_same_lr_frequencies_for_side = true; publicVariable "tf_same_lr_frequencies_for_side";
    //unlockedBackpacks pushBack "tf_rt1523g_sage";//uncomment this if you are adding LR radios for players
};
publicVariable "hayTFAR";

// todo: document this (texture mod detection?)
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
publicVariable "FIA_texturedVehicles";
publicVariable "FIA_texturedVehicleConfigs";

call AS_fnc_initPetros;
call AS_fnc_HQdeploy;


// The max skill that AAF or FIA can have (BE_module).
AS_maxSkill = 20;
publicVariable "AS_maxSkill";

// BE_modul handles all the permissions e.g. to build roadblocks, skill, etc.
#include "Scripts\BE_modul.sqf"
[] call fnc_BE_initialize;

publicVariable "unlockedWeapons";
publicVariable "unlockedItems";
publicVariable "unlockedBackpacks";
publicVariable "unlockedMagazines";

[] spawn AS_fnc_mission_updateAvailable;
