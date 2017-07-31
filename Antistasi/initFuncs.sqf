/*
File that initializes functions. This should only initialize functions and variables, not call them.
At this point you cannot use variables from initVar.
*/
call compile preProcessFileLineNumbers "statSave\saveFuncs.sqf";
call compile preProcessFileLineNumbers "statSave\dialogs.sqf";

call compile preProcessFileLineNumbers "dialogs.sqf";

call compile preProcessFileLineNumbers "AAFarsenal.sqf";
call compile preProcessFileLineNumbers "FIArecruitment.sqf";

call compile preProcessFileLineNumbers "location.sqf";

AS_fnc_setDefaultSkill = compile preProcessFileLineNumbers "CREATE\setDefaultSkill.sqf";
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

AS_fnc_updateAll = compile preProcessFileLineNumbers "fnc_updateAll.sqf";
AS_fnc_initPlayer = compile preProcessFileLineNumbers "fnc_initPlayer.sqf";

AS_fnc_dismissFIAgarrison = compile preProcessFileLineNumbers "REINF\dismissFIAgarrison.sqf";

AS_fnc_createAirAttack = compile preProcessFileLineNumbers "CREATE\fnc_createAirAttack.sqf";
as_fnc_createlandattack = compile preProcessFileLineNumbers "CREATE\fnc_createLandAttack.sqf";
AS_fnc_initVehicle = compile preProcessFileLineNumbers "fnc_initVehicle.sqf";

AS_fnc_abandonFIALocation = compile preProcessFileLineNumbers "fnc_abandonFIALocation.sqf";
AS_fnc_renameFIAcamp = compile preProcessFileLineNumbers "fnc_renameFIAcamp.sqf";

AS_fnc_initPetros = compile preProcessFileLineNumbers "fnc_initPetros.sqf";
AS_fnc_HQdeploy = compile preProcessFileLineNumbers "fnc_HQdeploy.sqf";
AS_fnc_HQbuild = compile preProcessFileLineNumbers "fnc_HQbuild.sqf";
AS_fnc_HQselect = compile preProcessFileLineNumbers "fnc_HQselect.sqf";
AS_fnc_HQmove = compile preProcessFileLineNumbers "fnc_HQmove.sqf";
AS_fnc_HQaddObject = compile preprocessFileLineNumbers "fnc_HQaddObject.sqf";

AS_fnc_AAFattackScore = compile preProcessFileLineNumbers "Functions\fnc_AAFattackScore.sqf";
AS_fnc_wait_or_fail = compile preProcessFileLineNumbers "Functions\fnc_wait_or_fail.sqf";

AS_fnc_changePersistentVehicles = compile preProcessFileLineNumbers "Functions\fnc_changePersistentVehicles.sqf";

// everything related with minefields is here
AS_fnc_addMinefield = compile preProcessFileLineNumbers "Functions\fnc_addMinefield.sqf";
AS_fnc_deployAAFminefield = compile preProcessFileLineNumbers "Functions\fnc_deployAAFminefield.sqf";
AS_fnc_deployFIAminefield = compile preProcessFileLineNumbers "Functions\fnc_deployFIAminefield.sqf";
AS_missionFIAminefield = compile preProcessFileLineNumbers "Missions\FIAminefield.sqf";
AS_fnc_createMinefield = compile preProcessFileLineNumbers "CREATE\minefield.sqf";

// auxiliars to missions
call compile preProcessFileLineNumbers "Missions\mission.sqf";
AS_fnc_oneStepMission = compile preProcessFileLineNumbers "Missions\fnc_oneStepMission.sqf";
AS_fnc_cleanResources = compile preProcessFileLineNumbers "Missions\fnc_cleanResources.sqf";
// missions
AS_mis_assassinate = compile preProcessFileLineNumbers "Missions\assassinate.sqf";
AS_mis_convoy = compile preProcessFileLineNumbers "Missions\convoy.sqf";
AS_mis_conquer = compile preProcessFileLineNumbers "Missions\conquer.sqf";
AS_mis_natoCAS = compile preProcessFileLineNumbers "Missions\natoCAS.sqf";
AS_mis_natoArmor = compile preProcessFileLineNumbers "Missions\natoArmor.sqf";
AS_mis_natoArtillery = compile preProcessFileLineNumbers "Missions\natoArtillery.sqf";
AS_mis_natoAmmo = compile preProcessFileLineNumbers "Missions\natoAmmo.sqf";
AS_mis_natoCA = compile preProcessFileLineNumbers "Missions\natoCA.sqf";
AS_mis_natoUAV = compile preProcessFileLineNumbers "Missions\natoUAV.sqf";
AS_mis_natoRoadblock = compile preProcessFileLineNumbers "Missions\natoRoadblock.sqf";
AS_mis_natoQRF = compile preProcessFileLineNumbers "Missions\natoQRF.sqf";
AS_mis_black_market = compile preProcessFileLineNumbers "Missions\black_market.sqf";
AS_mis_establishFIALocation = compile preProcessFileLineNumbers "Missions\establishFIALocation.sqf";
AS_mis_repair_antenna = compile preProcessFileLineNumbers "Missions\repair_antenna.sqf";
ASS_Traidor = compile preProcessFileLineNumbers "Missions\ASS_Traidor.sqf";
RES_Prisioneros = compile preProcessFileLineNumbers "Missions\RES_Prisioneros.sqf";
RES_Refugiados = compile preProcessFileLineNumbers "Missions\RES_Refugiados.sqf";
LOG_Bank = compile preProcessFileLineNumbers "Missions\LOG_Bank.sqf";
LOG_Suministros = compile preProcessFileLineNumbers "Missions\LOG_Suministros.sqf";
LOG_Ammo = compile preProcessFileLineNumbers "Missions\LOG_Ammo.sqf";
LOG_Medical = compile preProcessFileLineNumbers "Missions\LOG_Medical.sqf";
DES_Vehicle = compile preProcessFileLineNumbers "Missions\DES_Vehicle.sqf";
DES_Heli = compile preProcessFileLineNumbers "Missions\DES_Heli.sqf";
DES_Antena = compile preProcessFileLineNumbers "Missions\DES_Antena.sqf";
PR_Pamphlet = compile preProcessFileLineNumbers "Missions\PR_Pamphlet.sqf";
PR_Brainwash = compile preProcessFileLineNumbers "Missions\PR_Brainwash.sqf";
DEF_Camp = compile preProcessFileLineNumbers "Missions\DEF_Camp.sqf";
CSATpunish = compile preProcessFileLineNumbers "Missions\CSATpunish.sqf";

AS_fnc_shuffle = compile preProcessFileLineNumbers "Functions\fnc_shuffle.sqf";
AS_fnc_antennaKilledEH = compile preProcessFileLineNumbers "Functions\fnc_antennaKilledEH.sqf";
hasRadio = compile preProcessFileLineNumbers "AI\hasRadio.sqf";
accionArsenal = compile preProcessFileLineNumbers "Municion\accionArsenal.sqf";
powerCheck = compile preProcessFileLineNumbers "powerCheck.sqf";
AAFKilledEH = compile preProcessFileLineNumbers "AI\AAFKilledEH.sqf";
handleDamageAAF = compile preProcessFileLineNumbers "Revive\handleDamageAAF.sqf";
civVEHinit = compile preProcessFileLineNumbers "CREATE\civVEHinit.sqf";
smokeCoverAuto = compile preProcessFileLineNumbers "AI\smokeCoverAuto.sqf";
landThreatEval = compile preProcessFileLineNumbers "AI\landThreatEval.sqf";
mortarPos = compile preProcessFileLineNumbers "CREATE\mortarPos.sqf";
isMember = compile preProcessFileLineNumbers "orgPlayers\isMember.sqf";
vaciar = compile preProcessFileLineNumbers "Municion\vaciar.sqf";
artySupport = compile preProcessFileLineNumbers "AI\artySupport.sqf";
teclas = compile preProcessFileLineNumbers "teclas.sqf";
distanceUnits = compile preProcessFileLineNumbers "distanceUnits.sqf";
munitionTransfer = compile preProcessFileLineNumbers "Municion\munitionTransfer.sqf";
AS_fnc_getLocationName = compile preProcessFileLineNumbers "fnc_getLocationName.sqf";
undercover = compile preProcessFileLineNumbers "undercover.sqf";
puertasLand = compile preProcessFileLineNumbers "AI\puertasLand.sqf";
AAthreatEval = compile preProcessFileLineNumbers "AI\AAthreatEval.sqf";
mortyAI = compile preProcessFileLineNumbers "AI\mortyAI.sqf";
surrenderAction = compile preProcessFileLineNumbers "AI\surrenderAction.sqf";
guardDog = compile preProcessFileLineNumbers "AI\guardDog.sqf";
VEHdespawner = compile preProcessFileLineNumbers "CREATE\VEHdespawner.sqf";
findSafeRoadToUnload = compile preProcessFileLineNumbers "AI\findSafeRoadToUnload.sqf";
garageVehicle = compile preProcessFileLineNumbers "garageVehicle.sqf";
garage = compile preProcessFileLineNumbers "garage.sqf";
ranksMP = compile preProcessFileLineNumbers "OrgPlayers\ranksMP.sqf";
undercoverAI = compile preProcessFileLineNumbers "AI\undercoverAI.sqf";
memberAdd = compile preProcessFileLineNumbers "OrgPlayers\memberAdd.sqf";
donateMoney = compile preProcessFileLineNumbers "OrgPlayers\donateMoney.sqf";
stavrosSteal = compile preProcessFileLineNumbers "OrgPlayers\stavrosSteal.sqf";
resourcesPlayer = compile preProcessFileLineNumbers "OrgPlayers\resourcesPlayer.sqf";
numericRank = compile preProcessFileLineNumbers "numericRank.sqf";
inconsciente = compile preProcessFileLineNumbers "Revive\inconsciente.sqf";
respawn = compile preProcessFileLineNumbers "Revive\respawn.sqf";
handleDamage = compile preProcessFileLineNumbers "Revive\handleDamage.sqf";
initRevive = compile preProcessFileLineNumbers "Revive\initRevive.sqf";
pedirAyuda = compile preProcessFileLineNumbers "AI\pedirAyuda.sqf";
ayudar = compile preProcessFileLineNumbers "AI\ayudar.sqf";
cubrirConHumo = compile preProcessFileLineNumbers "AI\cubrirConHumo.sqf";
autoRearm = compile preProcessFileLineNumbers "AI\autoRearm.sqf";
destroyCheck = compile preProcessFileLineNumbers "destroyCheck.sqf";
garrisonInfo = compile preProcessFileLineNumbers "garrisonInfo.sqf";
FIAvehiclePrice = compile preProcessFileLineNumbers "FIAvehiclePrice.sqf";
resourcesAAF = compile preProcessFileLineNumbers "resourcesAAF.sqf";
VANTinfo = compile preProcessFileLineNumbers "AI\VANTinfo.sqf";
recruitFIAgarrison = compile preProcessFileLineNumbers "REINF\recruitFIAgarrison.sqf";
isFrontline = compile preProcessFileLineNumbers "isFrontline.sqf";
AS_fnc_changeSecondsforAAFattack = compile preProcessFileLineNumbers "Functions\fnc_changeSecondsforAAFattack.sqf";
destroyCity = compile preProcessFileLineNumbers "destroyCity.sqf";
FIAradio = compile preProcessFileLineNumbers "FIAradio.sqf";
deleteControles = compile preProcessFileLineNumbers "deleteControles.sqf";
cleanserVeh = compile preProcessFileLineNumbers "CREATE\cleanserVeh.sqf";
citiesToCivPatrol = compile preProcessFileLineNumbers "citiesToCivPatrol.sqf";
AS_fnc_fillCrateNATO = compile preProcessFileLineNumbers "Municion\fillCrateNATO.sqf";
puestoDialog = compile preProcessFileLineNumbers "puestoDialog.sqf";
onPlayerDisconnect = compile preProcessFileLineNumbers "onPlayerDisconnect.sqf";
playerScoreAdd = compile preProcessFileLineNumbers "orgPlayers\playerScoreAdd.sqf";
assignStavros = compile preProcessFileLineNumbers "orgPlayers\assignStavros.sqf";
stavrosInit = compile preProcessFileLineNumbers "orgPlayers\stavrosInit.sqf";
castigo = compile preProcessFileLineNumbers "castigo.sqf";
fpsChange = compile preProcessFileLineNumbers "fpsChange.sqf";
AS_fnc_initUnitFIA = compile preProcessFileLineNumbers "fnc_initUnitFIA.sqf";
AS_fnc_initUnitAAF = compile preProcessFileLineNumbers "fnc_initUnitAAF.sqf";
AS_fnc_initUnitCIV = compile preProcessFileLineNumbers "fnc_initUnitCIV.sqf";
postmortem = compile preProcessFileLineNumbers "REINF\postmortem.sqf";
commsMP = compile preProcessFileLineNumbers "commsMP.sqf";
radioCheck = compile preProcessFileLineNumbers "radioCheck.sqf";
sellVehicle = compile preProcessFileLineNumbers "sellVehicle.sqf";
resourceCheckSkipTime = compile preProcessFileLineNumbers "resourcecheckSkipTime.sqf";

ataqueHQ = compile preProcessFileLineNumbers "Missions\ataqueHQ.sqf";
localizar = compile preProcessFileLineNumbers "localizar.sqf";
AS_fnc_fillCrateAAF = compile preProcessFileLineNumbers "Municion\fillCrateAAF.sqf";
flagaction = compile preProcessFileLineNumbers "flagaction.sqf";
resourcesFIA = compile preProcessFileLineNumbers "resourcesFIA.sqf";
AS_fnc_changeForeignSupport = compile preProcessFileLineNumbers "fnc_changeForeignSupport.sqf";
createCIV = compile preProcessFileLineNumbers "CREATE\createCIV.sqf";
AS_fnc_populateMilBuildings = compile preProcessFileLineNumbers "CREATE\populateMilBuildings.sqf";
AS_fnc_createFIAgarrison = compile preProcessFileLineNumbers "CREATE\createFIAgarrison.sqf";
AS_fnc_createFIAgeneric = compile preProcessFileLineNumbers "CREATE\createFIAgeneric.sqf";
AS_fnc_createFIA_built_location = compile preProcessFileLineNumbers "CREATE\createFIA_built_location.sqf";
createNATObases = compile preProcessFileLineNumbers "CREATE\createNATObases.sqf";
createNATOaerop = compile preProcessFileLineNumbers "CREATE\createNATOaerop.sqf";
recruitFIAinfantry = compile preProcessFileLineNumbers "REINF\recruitFIAinfantry.sqf";
recruitFIAsquad = compile preProcessFileLineNumbers "REINF\recruitFIAsquad.sqf";
buyFIAveh = compile preProcessFileLineNumbers "REINF\buyFIAveh.sqf";
FIAskillAdd = compile preProcessFileLineNumbers "REINF\FIAskillAdd.sqf";
CSATinit = compile preProcessFileLineNumbers "CREATE\CSATinit.sqf";
NATOinit = compile preProcessFileLineNumbers "CREATE\NATOinit.sqf";
NATOinitCA = compile preProcessFileLineNumbers "CREATE\NATOinitCA.sqf";
AS_fnc_createJournalist = compile preProcessFileLineNumbers "CREATE\createJournalist.sqf";
patrolCA = compile preProcessFileLineNumbers "CREATE\patrolCA.sqf";
combinedCA = compile preProcessFileLineNumbers "CREATE\combinedCA.sqf";
AAFeconomics = compile preProcessFileLineNumbers "AAFeconomics.sqf";
findBasesForCA = compile preProcessFileLineNumbers "findBasesForCA.sqf";
findBasesForConvoy = compile preProcessFileLineNumbers "findBasesForConvoy.sqf";
findAirportsForCA = compile preProcessFileLineNumbers "findAirportsForCA.sqf";
ataqueAAF = compile preProcessFileLineNumbers "ataqueAAF.sqf";
citySupportChange = compile preProcessFileLineNumbers "citySupportChange.sqf";
AS_fnc_spawnLoop = compile preProcessFileLineNumbers "spawnLoop.sqf";
inmuneConvoy = compile preProcessFileLineNumbers "AI\inmuneConvoy.sqf";
smokeCover = compile preProcessFileLineNumbers "AI\smokeCover.sqf";
fastropeAAF = compile preProcessFileLineNumbers "AI\fastropeAAF.sqf";
fastropeCSAT = compile preProcessFileLineNumbers "AI\fastropeCSAT.sqf";
fastropeNATO = compile preProcessFileLineNumbers "AI\fastropeNATO.sqf";
airdrop = compile preProcessFileLineNumbers "AI\airdrop.sqf";
airstrike = compile preProcessFileLineNumbers "AI\airstrike.sqf";
artilleria = compile preProcessFileLineNumbers "AI\artilleria.sqf";
artilleriaNATO = compile preProcessFileLineNumbers "AI\artilleriaNATO.sqf";
dismountFIA = compile preProcessFileLineNumbers "AI\dismountFIA.sqf";
powerReorg = compile preProcessFileLineNumbers "powerReorg.sqf";
apagon = compile preProcessFileLineNumbers "apagon.sqf";
mrkWIN = compile preProcessFileLineNumbers "mrkWIN.sqf";
mrkLOOSE = compile preProcessFileLineNumbers "mrkLOOSE.sqf";
/*
Generics
*/
createAirbase= compile preProcessFileLineNumbers "CREATE\createAirbase.sqf";
createBase = compile preProcessFileLineNumbers "CREATE\createBase.sqf";
createCity = compile preProcessFileLineNumbers "CREATE\createCity.sqf";
createOutpost = compile preProcessFileLineNumbers "CREATE\createOutpost.sqf";
createOutpostAA = compile preProcessFileLineNumbers "CREATE\createOutpostAA.sqf";
AS_fnc_createAAFgeneric = compile preProcessFileLineNumbers "CREATE\createAAFgeneric.sqf";
createRoadblock = compile preProcessFileLineNumbers "CREATE\createRoadblock.sqf";
createWatchpost = compile preProcessFileLineNumbers "CREATE\createWatchpost.sqf";
createAAsite = compile preProcessFileLineNumbers "CREATE\createAAsite.sqf";
genRoadPatrol = compile preProcessFileLineNumbers "CREATE\genRoadPatrol.sqf";

unlockVehicle = compile preProcessFileLineNumbers "unlockVehicle.sqf";
AS_fnc_fastTravel = compile preProcessFileLineNumbers "fnc_fastTravel.sqf";
heal = compile preProcessFileLineNumbers "heal.sqf";
emptyCrate = compile preProcessFileLineNumbers "Municion\emptyCrate.sqf";
createNATOpuesto = compile preProcessFileLineNumbers "CREATE\createNATOpuesto.sqf";
expandGroup = compile preProcessFileLineNumbers "CREATE\expandGroup.sqf";
enemyQRF = compile preprocessFileLineNumbers "CREATE\enemyQRF.sqf";
compNATORoadblock = compile preprocessFileLineNumbers "Compositions\cmpNATO_RB.sqf";
buyGear = compile preProcessFileLineNumbers "Municion\buyGear.sqf";
pBarMP = compile preProcessFileLineNumbers "pBarMP.sqf";
createConv = compile preProcessFileLineNumbers "createConv.sqf";
misReqCiv = compile preProcessFileLineNumbers "Missions\misReqCiv.sqf";
misReqMil = compile preProcessFileLineNumbers "Missions\misReqMil.sqf";
jamLRRadio = compile preProcessFileLineNumbers "jamLRRadio.sqf";
refuel = compile preProcessFileLineNumbers "refuel.sqf";
suspendTransfer = compile preProcessFileLineNumbers "Municion\suspendTransfer.sqf";
attackWaves = compile preprocessFileLineNumbers "Scripts\attackWaves.sqf";
teleport = compile preprocessFileLineNumbers "teleport.sqf";

rankCheck = compile preprocessFileLineNumbers "Scripts\rankCheck.sqf";
skillAdjustments = compile preprocessFileLineNumbers "Scripts\skillAdjustments.sqf";
localSupport = compile preprocessFileLineNumbers "Scripts\localSupport.sqf";
