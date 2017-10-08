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
"static_aa", "static_at", "static_mg", "static_mg_low", "static_mortar",
"tanks", "boats", "trucks", "apcs",
"helis_transport", "helis_armed", "planes",
"uavs_attack",
"flag"
];

private _roles = ["civilian", "anti_state", "state", "foreign"];
private _attributes = [
	["units", "vehicles"],
	["flag"],
	_common_attributes + ["cars_armed", "truck_ammo", "truck_repair", "teamsAA", "patrols"],
	_common_attributes + ["traitor", "cars_transport", "uavs_small", "artillery1", "artillery2", "other_vehicles", "helis_attack", "recon_squad", "recon_team"]
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
					diag_log format ["[AS] Error: Attribute '%1' not defined for faction '%2' for role '%3'", _x, _faction, "civilian"];
					// remove this role from the faction to avoid errors
					[AS_entities, _faction, "roles", _faction_roles - [_role]] call DICT_fnc_setLocal;
				};
			} forEach _mandatory_attributes;
		};
	} forEach allVariables AS_entities;
} forEach _roles;
