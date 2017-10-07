// check entities necessary for CSAT/NATO/AAF
{
	private _type = _x;
	{
		private _value = [_x, _type] call AS_fnc_getEntity;
		if isNil "_value" then {
			diag_log format ["[AS] Error: Type of unit '%1' not defined for '%2'", _type, _x];
		};
	} forEach ["CSAT", "NATO", "AAF"];
} forEach [
"gunner", "crew", "pilot", "officer", "traitor",
"cfgGroups", "teams", "squads",
"static_aa", "static_at", "static_mg", "static_mg_low", "static_mortar",
"tanks", "trucks", "apcs", "cars_transport", "cars_armed",
"helis_transport", "helis_armed", "planes",
"uavs_small", "uavs_attack",
"name", "flag"
];


// check entities necessary for AAF
{
	private _type = ["AAF", _x] call AS_fnc_getEntity;
	if isNil "_type" then {
		diag_log format ["[AS] Error: Type of unit '%1' not defined for AAF", _x];
	};
} forEach [
"patrols", "teamsAA",
"boats", "ammoVehicles", "repairVehicles"
];


// check entities necessary for CSAT and NATO
{
	private _type = _x;
	{
		private _value = [_x, _type] call AS_fnc_getEntity;
		if isNil "_value" then {
			diag_log format ["[AS] Error: Type of unit '%1' not defined for '%2'", _type, _x];
		};
	} forEach ["CSAT", "NATO"];
} forEach [
"artillery1", "artillery2", "other_vehicles",
"helis_attack",
"recon_squad", "recon_team"
];


// Define all helis and transport helis of CSAT and NATO
{
	private _side = _x;
	private _vehicles = [];
	{
		_vehicles append ([_side, _x] call AS_fnc_getEntity);
	} forEach ["helis_transport", "helis_attack", "helis_armed"];
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
} forEach ["tanks", "trucks", "apcs", "artillery1", "artillery2", "other_vehicles", "helis_transport", "helis_attack", "helis_armed", "planes"];
[AS_entities, "NATO", "vehicles", _vehicles] call DICT_fnc_setLocal;

// sets the costs of AAF units based on their relative cost
call {
	private _result = [];
	{
		_result pushBack [_x,(getNumber (configfile >> "cfgVehicles" >> _x >> "cost"))]
	} forEach ((["AAF", "cfgGroups"] call AS_fnc_getEntity) call AS_fnc_getAllUnits);

	// sort by cost
	_result = [_result, [], {_x select 1}, "DESC"] call BIS_fnc_sortBy;

	// assign cost based on relative cost: cheapest is 10, most expensive 30
	private _min = (_result select (count _result - 1)) select 1;
	private _max = (_result select 0) select 1;
	if (_max == _min) then {
		_min = 0;  // if all equal, all cost most expensive
	};
	{
		private _cost = _x select 1;
		_cost = 10 + 20 * (_cost - _min)/(_max - _min);
		AS_data_allCosts setVariable [_x select 0, _cost];
	} forEach _result;
};

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
