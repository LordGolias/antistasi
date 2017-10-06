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
	private _type = _x;
	{
		private _value = [_x, _type] call AS_fnc_getEntity;
		if isNil "_value" then {
			diag_log format ["[AS] Error: Type of unit '%1' not defined for '%2'", _type, _x];
		};
	} forEach ["CSAT", "NATO"];
} forEach ["gunner", "crew", "pilot", "cfgGroups",
		   "mbts", "trucks", "apcs", "artillery1", "artillery2", "other_vehicles",
		   "helis_land", "helis_fastrope", "helis_paradrop", "helis_attack", "helis_armed", "planes"
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

// FIA
unlockedItems = unlockedItems + AS_FIAuniforms +
	AS_FIAuniforms_undercover + AS_FIAhelmets_undercover +
	AS_FIAvests_undercover + AS_FIAgoogles_undercover;

// Contains "Infantry Squad", "Infantry Team", etc.
AS_allFIASquadTypes = [];
for "_i" from 0 to (count AS_FIAsquadsMapping) - 1 step 2 do {
    AS_allFIASquadTypes pushBackUnique (AS_FIAsquadsMapping select (_i + 1));
};
AS_allFIASquadTypes append AS_FIACustomSquad_types;

// Contains "Rifleman", "Grenadier", etc.
AS_allFIAUnitTypes = [];
AS_allFIASoldierClasses = [];
for "_i" from 0 to (count AS_FIAsoldiersMapping) - 1 step 2 do {
    AS_allFIAUnitTypes pushBackUnique (AS_FIAsoldiersMapping select (_i + 1));
    AS_allFIASoldierClasses pushBackUnique (AS_FIAsoldiersMapping select _i);
};
AS_allFIARecruitableSoldiers = AS_allFIAUnitTypes - ["Crew", "Survivor"];

AS_FIAvehicles_all = (AS_FIAvehicles getVariable "land_vehicles") +
	(AS_FIAvehicles getVariable "air_vehicles") +
	(AS_FIAvehicles getVariable "water_vehicles");

civHeli = (AS_FIAvehicles getVariable "air_vehicles") select 0;

// todo: remove this variable by making the boat-buying a list of boats
boatFIA = (AS_FIAvehicles getVariable "water_vehicles") select 0;
