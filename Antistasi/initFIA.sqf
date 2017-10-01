#include "macros.hpp"
AS_SERVER_ONLY("initFIA.sqf");

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

// publish these variables to all clients.
publicVariable "AS_allFIASquadTypes";
publicVariable "AS_allFIAUnitTypes";
publicVariable "AS_allFIASoldierClasses";
publicVariable "AS_allFIARecruitableSoldiers";
publicVariable "AS_FIAvehicles_all";
publicVariable "civHeli";
publicVariable "boatFIA";
