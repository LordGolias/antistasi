// maps standard classes to unit types.
// See functions below to see how it is used.
AS_FIAsoldiersMapping = [
    "B_G_Soldier_F", "Rifleman",
    "B_G_Soldier_GL_F", "Grenadier",
    "B_G_medic_F", "Medic",
    "B_G_Soldier_AR_F", "Autorifleman",
    "B_G_Soldier_SL_F", "Squad Leader",
    "B_G_officer_F", "Rifleman",
    "B_G_Soldier_TL_F", "Rifleman",
    "B_G_Soldier_LAT_F", "AT Specialist",
    "B_G_Soldier_M_F", "Sniper",
    "B_G_engineer_F", "Repair Specialist",
    "B_G_Soldier_LAT_F", "AA Specialist",  // AA specialist is spawned as B_G_Soldier_LAT_F
    "B_G_Soldier_exp_F", "Explosives Specialist",
    "B_G_Soldier_A_F", "Ammo Bearer",
    "B_G_Soldier_lite_F", "Crew",
    "B_G_Survivor_F", "Survivor"
];

// maps standard classes to squad names.
AS_FIAsquadsMapping = [
    "IRG_InfSquad", "Infantry Squad",
    "IRG_InfTeam", "Infantry Team",
    "IRG_InfTeam_AT", "AT Team",
    "IRG_SniperTeam_M", "Sniper Team",
    "IRG_InfSentry", "Sentry Team"
];

// The cost of each unit type.
AS_data_allCosts setVariable ["Crew", 50, true];
AS_data_allCosts setVariable ["Ammo Bearer", 50, true];
AS_data_allCosts setVariable ["Rifleman", 50, true];
AS_data_allCosts setVariable ["Grenadier", 100, true];
AS_data_allCosts setVariable ["Autorifleman", 100, true];
AS_data_allCosts setVariable ["Medic", 300, true];
AS_data_allCosts setVariable ["Squad Leader", 100, true];
AS_data_allCosts setVariable ["Repair Specialist", 200, true];
AS_data_allCosts setVariable ["Explosives Specialist", 300, true];
AS_data_allCosts setVariable ["AT Specialist", 200, true];
AS_data_allCosts setVariable ["AA Specialist", 300, true];
AS_data_allCosts setVariable ["Sniper", 100, true];

// unit class -> unit type
AS_fnc_getFIAUnitNameType = {
    params ["_name"];

    private _index = AS_FIAsoldiersMapping find _name;
    private _class = "Rifleman";
    if (_index == -1) then {
        diag_log format ["[AS] ERROR: unit class '%1' is not in the templates/FIA.sqf. Using type '%2'.",_name,_class];
    } else {
        _class = AS_FIAsoldiersMapping select (_index + 1);
    };
    _class
};

// unit -> unit type
AS_fnc_getFIAUnitType = {
    params ["_unit"];
    [typeOf _unit] call AS_fnc_getFIAUnitNameType
};

// unit type -> unit class
AS_fnc_getFIAUnitClass = {
    params ["_type"];
    private _index = AS_FIAsoldiersMapping find _type;
    private _class = "B_G_Soldier_F";
    if (_index == -1) then {
        diag_log format ["[AS] ERROR: unit type '%1' is not in the templates/FIA.sqf. Using unit class '%2'.",_type,_class];
    } else {
        _class = AS_FIAsoldiersMapping select (_index - 1);
    };
    _class
};

// squad class -> squad type
AS_fnc_getFIASquadNameType = {
    params ["_name"];

    private _index = AS_FIAsquadsMapping find _name;
    private _class = "Infantry Squad";
    if (_index == -1) then {
        diag_log format ["[AS] ERROR: squad class '%1' is not in the templates/FIA.sqf. Using type '%2'.",_name,_class];
    } else {
        _class = AS_FIAsquadsMapping select (_index + 1);
    };
    _class
};

// squad type -> squad class
AS_fnc_getFIASquadClass = {
    params ["_type"];
    private _index = AS_FIAsquadsMapping find _type;
    private _class = "IRG_InfSquad";
    if (_index == -1) then {
        diag_log format ["[AS] ERROR: squad type '%1' is not in the templates/FIA.sqf. Using class '%2'.",_type,_class];
    } else {
        _class = AS_FIAsquadsMapping select (_index - 1);
    };
    _class
};

// squad type -> squad config (needed for BIS_Fnc_spawnGroup)
AS_fnc_getFIASquadConfig = {
    params ["_type"];
    configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> ([_type] call AS_fnc_getFIASquadClass)
};

// Returns [cost,HR] of the squad type.
AS_fnc_getFIASquadCost = {
    params ["_type"];
    private _config = [_type] call AS_fnc_getFIASquadConfig;

    private _cost = 0;
    private _hr = 0;
    for "_i" from 0 to (count _config) - 1 do {
    	_item = _config select _i;
    	if (isClass _item) then {
            private _unitName = [getText(_item >> "vehicle")] call AS_fnc_getFIAUnitNameType;
            _coste = _coste + (AS_data_allCosts getVariable _unitName);
            _hr = _hr + 1;
    	};
    };
    [_cost, _hr]
};

// Contains "Rifleman", "Grenadier", etc.
AS_allFIAUnitTypes = [];
AS_allFIASoldierClasses = [];
for "_i" from 0 to (count AS_FIAsoldiersMapping) - 1 step 2 do {
    AS_allFIAUnitTypes pushBackUnique (AS_FIAsoldiersMapping select (_i + 1));
    AS_allFIASoldierClasses pushBackUnique (AS_FIAsoldiersMapping select _i);
};
AS_allFIARecruitableSoldiers = AS_allFIAUnitTypes - ["Crew", "Survivor"];


// Contains "Infantry Squad", "Infantry Team", etc.
AS_allFIASquadTypes = [];
for "_i" from 0 to (count AS_FIAsquadsMapping) - 1 step 2 do {
    AS_allFIASquadTypes pushBackUnique (AS_FIAsquadsMapping select (_i + 1));
};
// squads that require custom initialization
AS_allFIACustomSquadTypes = ["Mobile AA","Mobile AT","Mobile Mortar"];

AS_fnc_FIAmobileToPiece = {
    params ["_squad"];
    if (_squad == "Mobile AA") exitWith {"B_static_AA_F"};
    if (_squad == "Mobile AT") exitWith {"B_static_AT_F"};
    if (_squad == "Mobile Mortar") exitWith {"B_G_Mortar_01_F"};
    ""
};

AS_allFIASquadTypes = AS_allFIASquadTypes + AS_allFIACustomSquadTypes;
