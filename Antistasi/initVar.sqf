/*
This file runs on every machine (server+client) and initializes different
variables.
Variables that are published, like
	- those that use `publicVariable`
	- those that use `setVariable [...,...,true]`
must be initialized only in the server (using `if (isServer)`).
*/
#include "macros.hpp"

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

// Stores cost of AAF and FIA units
AS_data_allCosts = createSimpleObject ["Static", [0, 0, 0]];

// Stores data about which vehicles can be bought and at what price.
// This is a local object as the costs are immutable and can thus be initialized locally
AS_FIAvehicles = createSimpleObject ["Static", [0, 0, 0]];

// for now, this is fixed. In the future, the player will change it to play as AAF.
AS_playersSide = west;

call compile preprocessFileLineNumbers "templates\FIA.sqf";

// add content to the unlocked items depending on the ACE.
// Must be called after unlocked* is defined ("templates\FIA.sqf")
if hayACE then {
	call compile preprocessFileLineNumbers "initACE.sqf";
};

AS_entities = createSimpleObject ["Static", [0, 0, 0]];
{
	AS_entities setVariable [_x, createSimpleObject ["Static", [0, 0, 0]]];
} forEach ["CSAT", "NATO", "FIA", "AAF"];
// e.g. [AS_entities, "CSAT", "squads"] call DICT_fnc_get


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

{
	private _type = ["AAF", _x] call AS_fnc_getEntity;
	if isNil "_type" then {
		diag_log format ["[AS] Error: Type of unit '%1' not defined for AAF", _x];
	};
} forEach ["gunner", "crew", "pilot", "medic", "driver",
           "officers", "snipers", "ncos", "specials", "mgs",
		   "regulars", "crews", "pilots",
		   "cfgGroups", "patrols", "garrisons", "teamsATAA", "teams", "squads", "teamsAA", "teamsAT"
		   ];
{
	private _type = ["NATO", _x] call AS_fnc_getEntity;
	if isNil "_type" then {
		diag_log format ["[AS] Error: Type of unit '%1' not defined for NATO", _x];
	};
} forEach ["gunner", "crew", "pilot", "cfgGroups",
		   "mbts", "trucks", "apcs", "artillery1", "artillery2", "other_vehicles",
		   "helis_transport", "helis_attack", "helis_armed", "planes"
		   ];

{
	private _side = _x;
	private _vehicles = [];
	{
		_vehicles append ([_side, _x] call AS_fnc_getEntity);
	} forEach ["helis_land", "helis_fastrope", "helis_paradrop"];
	[AS_entities, _side, "helis_transport", _vehicles] call DICT_fnc_setLocal;
	{
		_vehicles append ([_side, _x] call AS_fnc_getEntity);
	} forEach ["helis_attack", "helis_armed"];
	[AS_entities, _side, "helis", _vehicles] call DICT_fnc_setLocal;
} forEach ["CSAT", "NATO"];

// computes lists of statics
{
	private _statics = [];
	private _type = _x;
	{
		private _static = [_x, _type] call AS_fnc_getEntity;
		if isNil "_static" then {
			diag_log format ["[AS] Error: Type of unit '%1' not defined for '%2'", _type, _x];
		} else {
			_statics pushBackUnique _static;
		};
	} forEach ["CSAT", "NATO", "AAF"];

	if (_type == "static_at") then {
		AS_allATstatics = +_statics;
	};
	if (_type == "static_aa") then {
		AS_allAAstatics = +_statics;
	};
	if (_type in ["static_mg", "static_mg_low"]) then {
		AS_allMGstatics = +_statics;
	};
	if (_type == "static_mortar") then {
		AS_allMortarStatics = +_statics;
	};
} forEach ["static_aa", "static_at", "static_mg", "static_mg_low", "static_mortar"];
AS_allStatics = AS_allATstatics + AS_allAAstatics + AS_allMGstatics + AS_allMortarStatics;

// set of all NATO vehicles
private _vehicles = [];
{
	_vehicles append (["NATO", _x] call AS_fnc_getEntity);
} forEach ["mbts", "trucks", "apcs", "artillery1", "artillery2", "other_vehicles", "helis_transport", "helis_attack", "helis_armed", "planes"];
[AS_entities, "NATO", "vehicles", _vehicles] call DICT_fnc_setLocal;

{AS_data_allCosts setVariable [_x,10]} forEach (["AAF", "regulars"] call AS_fnc_getEntity);
{AS_data_allCosts setVariable [_x,15]} forEach (["AAF", "mgs"] call AS_fnc_getEntity);
{AS_data_allCosts setVariable [_x,15]} forEach (["AAF", "crews"] call AS_fnc_getEntity);
{AS_data_allCosts setVariable [_x,15]} forEach (["AAF", "pilots"] call AS_fnc_getEntity);
{AS_data_allCosts setVariable [_x,20]} forEach (["AAF", "specials"] call AS_fnc_getEntity);
{AS_data_allCosts setVariable [_x,20]} forEach (["AAF", "ncos"] call AS_fnc_getEntity);
{AS_data_allCosts setVariable [_x,20]} forEach (["AAF", "snipers"] call AS_fnc_getEntity);
{AS_data_allCosts setVariable [_x,30]} forEach (["AAF", "officers"] call AS_fnc_getEntity);

// Picks the stuff defined for FIA above and merges it in a single interface
call compile preprocessFileLineNumbers "initFIA.sqf";

// Initializes all AAF/NATO/CSAT items (e.g. weapons, mags) from the global variables
// in the templates above. Only non-public globals defined.
call compile preprocessFileLineNumbers "initItemsSides.sqf";

// Compositions used to spawn camps, etc. Only non-public globals defined.
call compile preprocessFileLineNumbers "Compositions\campList.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpMTN.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpOP.sqf";
call compile preprocessFileLineNumbers "Compositions\FIA_RB.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpNATO_RB.sqf";
call compile preprocessFileLineNumbers "Compositions\cmpExp.sqf";

/////////////////////////////////////////////////////////////////////////
/////////////////////// CLIENT INIT FINISHES HERE ///////////////////////
/////////////////////////////////////////////////////////////////////////
if (!isServer) exitWith {};
/////////////////////////////////////////////////////////////////////////
///////////////////////////// SERVER ONLY ///////////////////////////////
/////////////////////////////////////////////////////////////////////////

// Below this point, everything defined only belongs to the server

// create container to store spawns
call AS_spawn_fnc_initialize;

call AS_mission_fnc_initialize;

// reguarly checks for players and stores their profiles
call AS_players_fnc_initialize;

call AS_AAFarsenal_fnc_initialize;
{
	[_x, "valid", ["AAF", _x] call AS_fnc_getEntity] call AS_AAFarsenal_fnc_set;
} forEach ["planes", "armedHelis", "transportHelis", "tanks", "apcs", "trucks", "supplies"];

// todo: re-add support for TFAR. This is probably needed by it.
lrRadio = "";

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
AS_Pset("skillAAF",4); //Initial skill level of AAF
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

// number of patrols currently spawned.
AS_Sset("AAFpatrols", 0);

// Used to make a transfer to `caja` atomic
AS_Sset("lockTransfer", false);

// This sets whether the CSAT can attack or not. The FIA has an option to block
// attacks by jamming radio signals (close to flags with towers)
AS_Sset("blockCSAT", false);

// list of vehicles (objects) that can no longer be used while undercover
AS_Sset("reportedVehs", []);

AS_Sset("AS_vehicleOrientation", 0);

AS_spawnLoopTime = 1; // seconds between each check of spawn/despawn locations (expensive loop).
AS_resourcesLoopTime = 600; // seconds between resources update

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

call AS_fnc_initPetros;
call AS_fnc_HQdeploy;


// The max skill that AAF or FIA can have (BE_module).
AS_maxSkill = 20;
publicVariable "AS_maxSkill";

// BE_modul handles all the permissions e.g. to build roadblocks, skill, etc.
#include "Scripts\BE_modul.sqf"
[] call fnc_BE_initialize;
[] spawn AS_mission_fnc_updateAvailable;
