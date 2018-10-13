private _enemies_around = false;

if (count ("aaf_attack" call AS_mission_fnc_active_missions) != 0) exitWith {
	hint "You cannot rest while FIA is under attack";
};
if (count ("aaf_attack_hq" call AS_mission_fnc_active_missions) != 0) exitWith {
	hint "You cannot rest while FIA HQ is under attack";
};

{
	if ((side _x != ("FIA" call AS_fnc_getFactionSide)) and {[500,_x,"BLUFORSpawn", "boolean"] call AS_fnc_unitsAtDistance}) exitWith {_enemies_around = true};
} forEach allUnits;
if (_enemies_around) exitWith {hint "You cannot rest with enemies near our units"};

private _all_around = false;
private _posHQ = getMarkerPos "FIA_HQ";
{
	if (_x distance _posHQ > 200) exitWith {_all_around = true};
} forEach (allPlayers - (entities "HeadlessClient_F"));

if _all_around exitWith {hint "All players must be around the HQ to rest"};

[[], "AS_fnc_skipTime"] call BIS_fnc_MP;
