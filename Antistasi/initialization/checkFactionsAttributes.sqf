{
	private _faction = _x;
	{
		if not ([AS_entities, _faction, _x] call DICT_fnc_exists) then {
			diag_log format ["[AS] Error: Attribute '%1' not defined for faction '%2'", _x, _faction];
		};
	} forEach ["name", "side", "roles"];
} forEach allVariables AS_entities;

private _common_attributes = [
"gunner", "crew", "pilot", "officer",
"cfgGroups", "teams", "squads",
"static_aa", "static_at", "static_mg", "static_mortar",
"tanks", "boats", "trucks", "apcs",
"helis_transport", "helis_armed", "planes",
"uavs_attack",
"flag", "box"
];

private _anti_state_attributes = [
"flag",
"googles", "uniforms", "helmets", "vests",
"vans",
"static_aa", "static_at", "static_mg", "static_mortar",
"soldier", "crew", "survivor", "engineer", "medic",
"squads", "squads_custom", "team_at", "team_sniper", "team_patrol",
"land_vehicles", "water_vehicles", "air_vehicles",
"costs"
];

private _roles = ["civilian", "anti_state", "state", "foreign"];
private _attributes = [
	["units", "vehicles"],
	_anti_state_attributes,
	_common_attributes + ["cars_armed", "truck_ammo", "truck_repair", "teamsAA", "patrols", "ap_mines", "at_mines"],
	_common_attributes + ["traitor", "cars_transport", "uavs_small", "artillery1", "artillery2", "other_vehicles", "static_mg_low", "helis_attack", "recon_squad", "recon_team"]
];

{
	private _role = _x;
	private _mandatory_attributes = _attributes select _forEachIndex;
	{
		private _faction = _x;
		private _faction_roles = AS_entities getVariable _faction getVariable "roles";
		if (_role in _faction_roles) then {
			{
				if not ([AS_entities, _faction, _x] call DICT_fnc_exists) then {
					diag_log format ["[AS] Error: Attribute '%1' not defined for faction '%2' for role '%3'", _x, _faction, _role];
					// remove this role from the faction to avoid errors
					[AS_entities, _faction, "roles", _faction_roles - [_role]] call DICT_fnc_set;
				};

			} forEach _mandatory_attributes;
		};
	} forEach allVariables AS_entities;
} forEach _roles;

// check that all costs are defined
private _role = "anti_state";
{
	private _faction = _x;
	private _faction_roles = AS_entities getVariable _faction getVariable "roles";
	if (_role in _faction_roles) then {
		private _vehicles_with_cost = allVariables ([AS_entities, _faction, "costs"] call DICT_fnc_get);
		private _mandatory_costs = [];
		{
			_mandatory_costs pushBack (toLower _x);
		} forEach ([AS_entities, _faction, "land_vehicles"] call DICT_fnc_get);

		if (count (_mandatory_costs - _vehicles_with_cost) != 0) then {
			diag_log format ["[AS] Error: The costs '%1' are not defined for faction '%2' for role '%3'", _mandatory_costs - _vehicles_with_cost, _faction, _role];
			// remove this role from the faction to avoid errors
			[AS_entities, _faction, "roles", _faction_roles - [_role]] call DICT_fnc_set;
		};
	};
} forEach allVariables AS_entities;
