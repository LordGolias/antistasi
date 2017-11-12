#include "../macros.hpp"
// create container to store spawns
call AS_spawn_fnc_initialize;

call AS_mission_fnc_initialize;

// reguarly checks for players and stores their profiles
call AS_players_fnc_initialize;

call AS_AAFarsenal_fnc_initialize;

// Names of camps used when the camp is spawned.
campNames = ["Spaulding","Wagstaff","Firefly","Loophole","Quale","Driftwood","Flywheel","Grunion","Kornblow","Chicolini","Pinky",
			"Fieramosca","Bulldozer","Bambino","Pedersoli"];

// todo: improve this.
expCrate = ""; // dealer's crate

AS_commander = objNull;
publicVariable "AS_commander";

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

AS_Pset("vehiclesInGarage", []);

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

// The max skill that AAF or FIA can have (BE_module).
AS_maxSkill = 20;
publicVariable "AS_maxSkill";

// BE_modul handles all the permissions e.g. to build roadblocks, skill, etc.
#include "..\Scripts\BE_modul.sqf"
