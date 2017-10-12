// Variables that are persistent to `AS_persistent`. They are saved and loaded accordingly.
// Add variables here that you want to save.
#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_init");
AS_database_persistents = [
	"NATOsupport", "CSATsupport", "resourcesAAF", "resourcesFIA", "skillFIA", "skillAAF", "hr",  // FIA attributes
	"civPerc", "spawnDistance", "minimumFPS", "cleantime",  // game options
	"secondsForAAFAttack", "destroyedLocations", "vehiclesInGarage", "destroyedBuildings",
	"antenasPos_alive", "antenasPos_dead", "vehicles", "date", "BE_module",
	"patrollingLocations", "patrollingPositions"
];

AS_database_persistents = AS_database_persistents + [
	"faction_anti_state", "faction_pro_anti_state", "faction_state", "faction_pro_state", "faction_civilian", "player_side"
];

AS_database_migrations = call DICT_fnc_create;
[AS_database_migrations, "latest", 1] call DICT_fnc_set;
[AS_database_migrations, "1", call DICT_fnc_create] call DICT_fnc_set;
[AS_database_migrations, "1", "steps", ["1", "2", "3", "4", "5", "6"]] call DICT_fnc_set;
[AS_database_migrations, "1", "1", ["AS_persistent", "faction_anti_state", "FIA_WEST"]] call DICT_fnc_set;
[AS_database_migrations, "1", "2", ["AS_persistent", "faction_pro_anti_state", "NATO"]] call DICT_fnc_set;
[AS_database_migrations, "1", "3", ["AS_persistent", "faction_state", "AAF"]] call DICT_fnc_set;
[AS_database_migrations, "1", "4", ["AS_persistent", "faction_pro_state", "CSAT"]] call DICT_fnc_set;
[AS_database_migrations, "1", "5", ["AS_persistent", "faction_civilian", "CIV"]] call DICT_fnc_set;
[AS_database_migrations, "1", "6", ["AS_persistent", "player_side", "west"]] call DICT_fnc_set;
