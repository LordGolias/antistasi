/*
This file is run on every machine (server+client) and initializes different
variables.
*/

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

// Initializes unlocked items.
unlockedItems = [
	"Binocular",
	"ItemMap",
	"ItemGPS",
	"ItemRadio",
	"ItemWatch",
	"ItemCompass",
	"FirstAidKit",
	"Medikit"
];

if hayACE then {
	// Must be called after unlockedItems is defined
	call compile preprocessFileLineNumbers "initACE.sqf";
};

if isServer then {
    AS_server_config = [hayACE, hayRHS, hasCUP];
	publicVariable "AS_server_config";
} else {
	waitUntil {not isNil "AS_server_config"};
	if not ([hayACE, hayRHS, hasCUP] isEqualTo AS_server_config) then {
		// Not the same configuration. Disconnect
		["invalidConfiguration", false, false, false, false] call BIS_fnc_endMission;
	};
};

AS_entities = createSimpleObject ["Static", [0, 0, 0]];

// fallback to the default template
private _dict = call compile preprocessFileLineNumbers "templates\CIV.sqf";
AS_entities setVariable ["CIV", _dict];
_dict = call compile preprocessFileLineNumbers "templates\AAF.sqf";
AS_entities setVariable ["AAF", _dict];
_dict = call compile preprocessFileLineNumbers "templates\CSAT.sqf";
AS_entities setVariable ["CSAT", _dict];
_dict = call compile preprocessFileLineNumbers "templates\NATO.sqf";
AS_entities setVariable ["NATO", _dict];
_dict = call compile preprocessFileLineNumbers "templates\FIA_WEST.sqf";
AS_entities setVariable ["FIA_WEST", _dict];
_dict = call compile preprocessFileLineNumbers "templates\FIA_EAST.sqf";
AS_entities setVariable ["FIA_EAST", _dict];

if hayRHS then {
	_dict = call compile preprocessFileLineNumbers "templates\AAF_RHS.sqf";
	AS_entities setVariable ["RHS_AAF", _dict];
	_dict = call compile preprocessFileLineNumbers "templates\CSAT_RHS.sqf";
	AS_entities setVariable ["RHS_AAF", _dict];
	_dict = call compile preprocessFileLineNumbers "templates\NATO_RHS.sqf";
	AS_entities setVariable ["RHS_NATO", _dict];
	_dict = call compile preprocessFileLineNumbers "templates\FIA_WEST_RHS.sqf";
	AS_entities setVariable ["RHS_FIA_WEST", _dict];
	_dict = call compile preprocessFileLineNumbers "templates\FIA_EAST_RHS.sqf";
	AS_entities setVariable ["RHS_FIA_EAST", _dict];
};
if hasCUP then {
	_dict = call compile preprocessFileLineNumbers "templates\AAF_CUP.sqf";
	AS_entities setVariable ["CUP_AAF", _dict];
	_dict = call compile preprocessFileLineNumbers "templates\CSAT_CUP.sqf";
	AS_entities setVariable ["CUP_CSAT", _dict];
	_dict = call compile preprocessFileLineNumbers "templates\NATO_CUP.sqf";
	AS_entities setVariable ["CUP_NATO", _dict];
	_dict = call compile preprocessFileLineNumbers "templates\FIA_WEST_CUP.sqf";
	AS_entities setVariable ["CUP_FIA_WEST", _dict];
	_dict = call compile preprocessFileLineNumbers "templates\FIA_EAST_CUP.sqf";
	AS_entities setVariable ["CUP_FIA_EAST", _dict];
};

call compile preprocessFileLineNumbers "initialization\checkFactionsAttributes.sqf"
