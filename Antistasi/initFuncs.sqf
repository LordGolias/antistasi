/*
File that initializes functions. This should only initialize functions and variables, not call them.
At this point you cannot use variables from initVar.
*/
call compile preProcessFileLineNumbers "persistency\functions.sqf";
call compile PreprocessFileLineNumbers "persistency\core.sqf";
call compile preProcessFileLineNumbers "persistency\dialogs.sqf";

call compile preProcessFileLineNumbers "dialogs.sqf";

call compile preProcessFileLineNumbers "AAFarsenal.sqf";
call compile preProcessFileLineNumbers "FIAarsenal.sqf";
call compile preProcessFileLineNumbers "FIArecruitment.sqf";

call compile preProcessFileLineNumbers "dictionary.sqf";
call compile preProcessFileLineNumbers "location.sqf";
call compile preProcessFileLineNumbers "players.sqf";

call compile preProcessFileLineNumbers "spawn.sqf";
AS_fnc_spawnToggle = compile preProcessFileLineNumbers "spawnToggle.sqf";
AS_fnc_spawnUpdate = compile preProcessFileLineNumbers "spawnUpdate.sqf";

AS_fnc_resourcesToggle = compile preProcessFileLineNumbers "resourcesToggle.sqf";
AS_fnc_resourcesUpdate = compile preProcessFileLineNumbers "resourcesUpdate.sqf";

call compile preprocessFileLineNumbers "Functions\clientFunctions.sqf";
call compile preprocessFileLineNumbers "Functions\QRFfunctions.sqf";
call compile preprocessFileLineNumbers "features\controlAI.sqf";

AS_fnc_setDefaultSkill = compile preProcessFileLineNumbers "fnc_setDefaultSkill.sqf";
AS_fnc_getWeaponItemsCargo = compile preProcessFileLineNumbers "municion\getWeaponItemsCargo.sqf";
AS_fnc_getBestEquipment = compile preProcessFileLineNumbers "municion\getBestEquipment.sqf";
AS_fnc_equipUnit = compile preProcessFileLineNumbers "municion\equipUnit.sqf";
AS_fnc_getUnitArsenal = compile preProcessFileLineNumbers "municion\getUnitArsenal.sqf";
AS_fnc_getBoxArsenal = compile preProcessFileLineNumbers "municion\getBoxArsenal.sqf";
AS_fnc_getBestItem = compile preProcessFileLineNumbers "municion\getBestItem.sqf";
AS_fnc_getBestWeapon = compile preProcessFileLineNumbers "municion\getBestWeapon.sqf";
AS_fnc_getBestMagazines = compile preProcessFileLineNumbers "municion\getBestMagazines.sqf";
AS_fnc_listToCargoList = compile preProcessFileLineNumbers "municion\listToCargoList.sqf";
AS_fnc_mergeCargoLists = compile preProcessFileLineNumbers "municion\mergeCargoLists.sqf";
AS_fnc_populateBox = compile preProcessFileLineNumbers "municion\populateBox.sqf";
AS_fnc_getTotalCargo = compile preProcessFileLineNumbers "municion\fnc_getTotalCargo.sqf";
AS_fnc_emptyUnit = compile preProcessFileLineNumbers "municion\emptyUnit.sqf";

call compile preProcessFileLineNumbers "templates\medicUnitBackpack.sqf";

AS_fnc_initPlayer = compile preProcessFileLineNumbers "fnc_initPlayer.sqf";

AS_fnc_dismissFIAgarrison = compile preProcessFileLineNumbers "REINF\dismissFIAgarrison.sqf";

AS_fnc_createAirAttack = compile preProcessFileLineNumbers "CREATE\fnc_createAirAttack.sqf";
as_fnc_createlandattack = compile preProcessFileLineNumbers "CREATE\fnc_createLandAttack.sqf";
AS_fnc_initVehicle = compile preProcessFileLineNumbers "fnc_initVehicle.sqf";
AS_fnc_initVehicleCiv = compile preProcessFileLineNumbers "fnc_initVehicleCiv.sqf";

AS_fnc_HQselect = compile preProcessFileLineNumbers "fnc_HQselect.sqf";

AS_fnc_AAFattackScore = compile preProcessFileLineNumbers "Functions\fnc_AAFattackScore.sqf";
AS_fnc_wait_or_fail = compile preProcessFileLineNumbers "Functions\fnc_wait_or_fail.sqf";

AS_fnc_deployFIAminefield = compile preProcessFileLineNumbers "Functions\fnc_deployFIAminefield.sqf";

// auxiliars to missions
call compile preProcessFileLineNumbers "Missions\mission.sqf";
call compile preProcessFileLineNumbers "Missions\outcomes.sqf";
AS_fnc_oneStepMission = compile preProcessFileLineNumbers "Missions\fnc_oneStepMission.sqf";
AS_fnc_cleanResources = compile preProcessFileLineNumbers "Missions\fnc_cleanResources.sqf";
// missions
call compile preProcessFileLineNumbers "Missions\assassinate.sqf";
call compile preProcessFileLineNumbers "Missions\convoy.sqf";
call compile preProcessFileLineNumbers "Missions\conquer.sqf";
call compile preProcessFileLineNumbers "Missions\natoCAS.sqf";
call compile preProcessFileLineNumbers "Missions\natoArmor.sqf";
call compile preProcessFileLineNumbers "Missions\natoArtillery.sqf";
call compile preProcessFileLineNumbers "Missions\natoAmmo.sqf";
call compile preProcessFileLineNumbers "Missions\natoAttack.sqf";
call compile preProcessFileLineNumbers "Missions\natoUAV.sqf";
call compile preProcessFileLineNumbers "Missions\natoRoadblock.sqf";
call compile preProcessFileLineNumbers "Missions\natoQRF.sqf";
call compile preProcessFileLineNumbers "Missions\black_market.sqf";
call compile preProcessFileLineNumbers "Missions\establishFIALocation.sqf";
call compile preProcessFileLineNumbers "Missions\establishFIAminefield.sqf";
call compile preProcessFileLineNumbers "Missions\repair_antenna.sqf";
call compile preProcessFileLineNumbers "Missions\kill_traitor.sqf";
call compile preProcessFileLineNumbers "Missions\rescue.sqf";
call compile preProcessFileLineNumbers "Missions\rob_bank.sqf";
call compile preProcessFileLineNumbers "Missions\send_meds.sqf";
call compile preProcessFileLineNumbers "Missions\stealAmmo.sqf";
call compile preProcessFileLineNumbers "Missions\help_meds.sqf";
call compile preProcessFileLineNumbers "Missions\destroy_vehicle.sqf";
call compile preProcessFileLineNumbers "Missions\destroy_helicopter.sqf";
call compile preProcessFileLineNumbers "Missions\destroy_antenna.sqf";
call compile preProcessFileLineNumbers "Missions\pamphlets.sqf";
call compile preProcessFileLineNumbers "Missions\broadcast.sqf";
call compile preProcessFileLineNumbers "Missions\defend_camp.sqf";
call compile preProcessFileLineNumbers "Missions\defend_city.sqf";
call compile preProcessFileLineNumbers "Missions\defend_location.sqf";
call compile preProcessFileLineNumbers "Missions\defend_hq.sqf";


AS_fnc_setCommander = compile preProcessFileLineNumbers "orgPlayers\fnc_setCommander.sqf";

AS_fnc_shuffle = compile preProcessFileLineNumbers "Functions\fnc_shuffle.sqf";
AS_fnc_antennaKilledEH = compile preProcessFileLineNumbers "Functions\fnc_antennaKilledEH.sqf";
hasRadio = compile preProcessFileLineNumbers "AI\hasRadio.sqf";
powerCheck = compile preProcessFileLineNumbers "powerCheck.sqf";
AAFKilledEH = compile preProcessFileLineNumbers "AI\AAFKilledEH.sqf";
smokeCoverAuto = compile preProcessFileLineNumbers "AI\smokeCoverAuto.sqf";
landThreatEval = compile preProcessFileLineNumbers "AI\landThreatEval.sqf";
mortarPos = compile preProcessFileLineNumbers "CREATE\mortarPos.sqf";
artySupport = compile preProcessFileLineNumbers "AI\artySupport.sqf";
teclas = compile preProcessFileLineNumbers "teclas.sqf";
AS_fnc_unitsAtDistance = compile preProcessFileLineNumbers "fnc_unitsAtDistance.sqf";
AS_fnc_transferToBox = compile preProcessFileLineNumbers "Municion\fnc_transferToBox.sqf";
AS_fnc_getLocationName = compile preProcessFileLineNumbers "fnc_getLocationName.sqf";
undercover = compile preProcessFileLineNumbers "undercover.sqf";
puertasLand = compile preProcessFileLineNumbers "AI\puertasLand.sqf";
AAthreatEval = compile preProcessFileLineNumbers "AI\AAthreatEval.sqf";
mortyAI = compile preProcessFileLineNumbers "AI\mortyAI.sqf";
surrenderAction = compile preProcessFileLineNumbers "AI\surrenderAction.sqf";
guardDog = compile preProcessFileLineNumbers "AI\guardDog.sqf";
vehicle_despawn = compile preProcessFileLineNumbers "Scripts\vehicle_despawn.sqf";
findSafeRoadToUnload = compile preProcessFileLineNumbers "AI\findSafeRoadToUnload.sqf";
garageVehicle = compile preProcessFileLineNumbers "garageVehicle.sqf";
garage = compile preProcessFileLineNumbers "garage.sqf";
undercoverAI = compile preProcessFileLineNumbers "AI\undercoverAI.sqf";
resourcesPlayer = compile preProcessFileLineNumbers "OrgPlayers\resourcesPlayer.sqf";

// Revive system
respawn = compile preProcessFileLineNumbers "Revive\respawn.sqf";
handleDamage = compile preProcessFileLineNumbers "Revive\handleDamage.sqf";
handleDamageACE = compile preProcessFileLineNumbers "Revive\handleDamageACE.sqf";
call compile preProcessFileLineNumbers "Revive\medical.sqf";

cubrirConHumo = compile preProcessFileLineNumbers "AI\cubrirConHumo.sqf";
autoRearm = compile preProcessFileLineNumbers "AI\autoRearm.sqf";
destroyCheck = compile preProcessFileLineNumbers "destroyCheck.sqf";
garrisonInfo = compile preProcessFileLineNumbers "garrisonInfo.sqf";
FIAvehiclePrice = compile preProcessFileLineNumbers "FIAvehiclePrice.sqf";
VANTinfo = compile preProcessFileLineNumbers "AI\VANTinfo.sqf";
recruitFIAgarrison = compile preProcessFileLineNumbers "REINF\recruitFIAgarrison.sqf";
isFrontline = compile preProcessFileLineNumbers "isFrontline.sqf";
citiesToCivPatrol = compile preProcessFileLineNumbers "citiesToCivPatrol.sqf";
AS_fnc_fillCrateNATO = compile preProcessFileLineNumbers "Municion\fillCrateNATO.sqf";
castigo = compile preProcessFileLineNumbers "castigo.sqf";

AS_fnc_initUnitFIA = compile preProcessFileLineNumbers "fnc_initUnitFIA.sqf";
AS_fnc_initUnitAAF = compile preProcessFileLineNumbers "fnc_initUnitAAF.sqf";
AS_fnc_initUnitCIV = compile preProcessFileLineNumbers "fnc_initUnitCIV.sqf";
AS_fnc_initUnitNATO = compile preProcessFileLineNumbers "fnc_initUnitNATO.sqf";
AS_fnc_initUnitCSAT = compile preProcessFileLineNumbers "fnc_initUnitCSAT.sqf";
postmortem = compile preProcessFileLineNumbers "REINF\postmortem.sqf";
commsMP = compile preProcessFileLineNumbers "commsMP.sqf";
radioCheck = compile preProcessFileLineNumbers "radioCheck.sqf";
sellVehicle = compile preProcessFileLineNumbers "sellVehicle.sqf";
resourceCheckSkipTime = compile preProcessFileLineNumbers "resourcecheckSkipTime.sqf";

localizar = compile preProcessFileLineNumbers "localizar.sqf";
AS_fnc_fillCrateAAF = compile preProcessFileLineNumbers "Municion\fillCrateAAF.sqf";
AS_fnc_addAction = compile preProcessFileLineNumbers "actions\fnc_addAction.sqf";
AS_fnc_populateMilBuildings = compile preProcessFileLineNumbers "fnc_populateMilBuildings.sqf";
AS_fnc_createFIAgarrison = compile preProcessFileLineNumbers "fnc_createFIAgarrison.sqf";

recruitFIAinfantry = compile preProcessFileLineNumbers "REINF\recruitFIAinfantry.sqf";
recruitFIAsquad = compile preProcessFileLineNumbers "REINF\recruitFIAsquad.sqf";
buyFIAveh = compile preProcessFileLineNumbers "REINF\buyFIAveh.sqf";
FIAskillAdd = compile preProcessFileLineNumbers "REINF\FIAskillAdd.sqf";
AS_fnc_createJournalist = compile preProcessFileLineNumbers "CREATE\createJournalist.sqf";
findBasesForCA = compile preProcessFileLineNumbers "findBasesForCA.sqf";
findBasesForConvoy = compile preProcessFileLineNumbers "findBasesForConvoy.sqf";
findAirportsForCA = compile preProcessFileLineNumbers "findAirportsForCA.sqf";

inmuneConvoy = compile preProcessFileLineNumbers "AI\inmuneConvoy.sqf";
smokeCover = compile preProcessFileLineNumbers "AI\smokeCover.sqf";
airdrop = compile preProcessFileLineNumbers "AI\airdrop.sqf";
airstrike = compile preProcessFileLineNumbers "AI\airstrike.sqf";
artilleria = compile preProcessFileLineNumbers "AI\artilleria.sqf";
artilleriaNATO = compile preProcessFileLineNumbers "AI\artilleriaNATO.sqf";
dismountFIA = compile preProcessFileLineNumbers "AI\dismountFIA.sqf";
AS_fnc_changeStreetLights = compile preProcessFileLineNumbers "fnc_changeStreetLights.sqf";

// Spawn locations
call compile preProcessFileLineNumbers "CREATE\auxiliar_spawn_location.sqf";
call compile preProcessFileLineNumbers "CREATE\createFIAairfield.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFairfield.sqf";
call compile preProcessFileLineNumbers "CREATE\createFIAbase.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFbase.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFcity.sqf";
call compile preProcessFileLineNumbers "CREATE\createFIAgeneric.sqf";
call compile preProcessFileLineNumbers "CREATE\createFIAbuilt_location.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFoutpost.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFoutpostAA.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFgeneric.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFroadblock.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFhill.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFhillAA.sqf";
call compile preProcessFileLineNumbers "CREATE\createMinefield.sqf";
call compile preProcessFileLineNumbers "CREATE\createCIVcity.sqf";

// spawn of AAF actions
call compile preProcessFileLineNumbers "CREATE\createAAFpatrol.sqf";
call compile preProcessFileLineNumbers "CREATE\createAAFroadPatrol.sqf";
patrolCA = compile preProcessFileLineNumbers "CREATE\patrolCA.sqf";
ataqueAAF = compile preProcessFileLineNumbers "ataqueAAF.sqf";

AS_fnc_availableSeats = compile preProcessFileLineNumbers "Functions\fnc_availableSeats.sqf";
AS_fnc_createGroup = compile preProcessFileLineNumbers "Functions\fnc_createGroup.sqf";
AS_fnc_groupCfgToComposition = compile preProcessFileLineNumbers "Functions\fnc_groupCfgToComposition.sqf";

unlockVehicle = compile preProcessFileLineNumbers "unlockVehicle.sqf";
AS_fnc_fastTravel = compile preProcessFileLineNumbers "fnc_fastTravel.sqf";
emptyCrate = compile preProcessFileLineNumbers "Municion\emptyCrate.sqf";
createNATOpuesto = compile preProcessFileLineNumbers "CREATE\createNATOpuesto.sqf";
enemyQRF = compile preprocessFileLineNumbers "CREATE\enemyQRF.sqf";
compNATORoadblock = compile preprocessFileLineNumbers "Compositions\cmpNATO_RB.sqf";
pBarMP = compile preProcessFileLineNumbers "pBarMP.sqf";
attackWaves = compile preprocessFileLineNumbers "Scripts\attackWaves.sqf";
teleport = compile preprocessFileLineNumbers "teleport.sqf";

rankCheck = compile preprocessFileLineNumbers "Scripts\rankCheck.sqf";

#include "Scripts\SHK_Fastrope.sqf"
