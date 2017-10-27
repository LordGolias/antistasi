class AS {

    class server {
        FNC_BASE(startNewGame);

        FNC(orgPlayers,setCommander);
        FNC(orgPlayers,chooseCommander);

        FNC_BASE(setEasy);
        FNC_BASE(cleanGarbage);

        FNC_BASE(abandonFIALocation);
        FNC_BASE(renameFIAcamp);
        FNC(Functions,changeSecondsforAAFattack);
        FNC_BASE(changeForeignSupport);
        FNC_BASE(changeAAFmoney);
        FNC_BASE(changeFIAmoney);
        FNC_BASE(changeCitySupport);

        FNC_BASE(resourcesToggle);
        FNC_BASE(resourcesUpdate);

        FNC_BASE(initPetros);
        FNC_BASE(rearmPetros);
        FNC_BASE(initPlayer);
        FNC_BASE(HQbuild);
        FNC_BASE(HQdeploy);
        FNC_BASE(HQmove);
        FNC_BASE(HQplace);
        FNC_BASE(HQaddObject);
        FNC_BASE(HQdeployPad);
        FNC_BASE(HQdeletePad);

        FNC(Functions,addMinefield);
        FNC(Functions,changePersistentVehicles);
        FNC(Functions,deployAAFminefield);

        FNC(fia_recruitment,recruitFIAunit);

        FNC(arsenal,collectDroppedEquipment);

        FNC_BASE(refreshArsenal);
        FNC_BASE(resetPetrosPosition);

        FNC_BASE(spendAAFmoney);
        FNC_BASE(updateAll);
        FNC_BASE(revealFromAAFRadio);

        FNC_BASE(win_location);
        FNC_BASE(lose_location);
        FNC_BASE(destroy_location);

        FNC_BASE(recomputePowerGrid);

        FNC_BASE(onPlayerDisconnect);

        FNC_BASE(showInGarageInfo);
    };

    class common {
        FNC_BASE(HQselect);
        FNC_BASE(setDefaultSkill);
        FNC_BASE(lockVehicle);
        FNC_BASE(hasRadio);
        FNC_BASE(location_isPowered);

        FNC(Functions,antennaKilledEH);
        FNC(Functions,shuffle);

        FNC_BASE(getSide);
        FNC_BASE(setSide);
        FNC_BASE(getFaction);
        FNC_BASE(getEntity);
        FNC_BASE(getAllUnits);

        FNC_BASE(getCost);

        FNC_BASE(pickGroup);
        FNC_BASE(updateProgressBar);

        FNC_BASE(spawnComposition);
        FNC_BASE(findSpawnSpots);
        FNC_BASE(roadAndDir);
        FNC_BASE(selectHillAAdata);
        FNC_BASE(spawnAAF_patrol);
        FNC_BASE(spawnAAF_patrolSquad);
        FNC_BASE(spawnAAF_roadAT);
        FNC_BASE(spawnAAF_truck);

        FNC(Scripts,spawnAttackWaves);

        FNC(Functions,AAFattackScore);
        FNC(Functions,wait_or_fail);
        FNC(Functions,deployFIAminefield);

        FNC_BASE(canFight);

        // auxiliars to missions
        FNC_BASE(oneStepMission);
        FNC_BASE(cleanResources);

        // auxiliars to FIArecruitment
        FNC(fia_recruitment,spawnFIAUnit);
        FNC(fia_recruitment,spawnFIASquad);
        FNC(fia_recruitment,getFIASquadName);
        FNC(fia_recruitment,getFIAUnitType);
        FNC(fia_recruitment,getFIAUnitClass);
        FNC(fia_recruitment,getFIASquadCost);
        FNC(fia_recruitment,getFIABestSquadVehicle);

        FNC_BASE(spawnAirAttack);
        FNC_BASE(spawnLandAttack);
        FNC_BASE(spawnCSATattack);
        FNC_BASE(spawnCSATuav);
        FNC_BASE(spawnJournalist);

        FNC_BASE(EH_AAFKilled);
        FNC_BASE(getLandThreat);
        FNC_BASE(getAirThreat);
        FNC_BASE(findMortarCreatePosition);
        FNC_BASE(callArtillerySupport);
        FNC_BASE(EH_KeyDown);
        FNC_BASE(unitsAtDistance);
        FNC_BASE(getLocationName);
        FNC_BASE(activateUndercover);
        FNC_BASE(toggleVehicleDoors);
        FNC_BASE(activateMortarCrewOnTruck);
        FNC_BASE(getSafeRoadToUnload);
        FNC_BASE(putVehicleInGarage);
        FNC_BASE(accessGarage);

        FNC(Functions,availableSeats);
        FNC(Functions,createGroup);
        FNC(Functions,groupCfgToComposition);

        FNC_BASE(EH_handleDamage);
        FNC_BASE(EH_handleDamageACE);

        FNC(AI,activateUndercoverAI);

        FNC_BASE(location_canBeDestroyed);
        FNC_BASE(location_name);
        FNC_BASE(getGarrisonAsText);
        FNC_BASE(getFIAvehiclePrice);
        FNC_BASE(location_isFrontline);
        FNC_BASE(getCitiesToCivPatrol);
        FNC_BASE(penalizePlayer);
        FNC_BASE(enemiesNearby);
        FNC_BASE(activateCleanup);
        FNC_BASE(activateVehicleCleanup);
        FNC_BASE(localCommunication);
        FNC_BASE(hasRadioCoverage);
        FNC_BASE(sellVehicle);
        FNC_BASE(skipTime);

        FNC_BASE(populateMilBuildings);
        FNC_BASE(createFIAgarrison);

        FNC_BASE(getBasesForCA);
        FNC_BASE(getBasesForConvoy);
        FNC_BASE(getAirportsForCA);

        FNC_BASE(setConvoyImmune);
        FNC_BASE(activateAirstrike);
        FNC_BASE(dropArtilleryShells);
        FNC_BASE(dropArtilleryShellsNATO);
        FNC_BASE(changeStreetLights);

        FNC(arsenal,listUniqueEquipment);
        FNC(arsenal,getWeaponItemsCargo)
        FNC(arsenal,getBestEquipment)
        FNC(arsenal,equipUnit)
        FNC(arsenal,getUnitArsenal)
        FNC(arsenal,getBoxArsenal)
        FNC(arsenal,getBestItem)
        FNC(arsenal,getBestWeapon)
        FNC(arsenal,getBestMagazines);
        FNC(arsenal,listToCargoList);
        FNC(arsenal,mergeCargoLists);
        FNC(arsenal,populateBox);
        FNC(arsenal,getTotalCargo);
        FNC(arsenal,emptyUnit);
        FNC(arsenal,transferToBox);
        FNC(arsenal,fillCrateNATO);
        FNC(arsenal,fillCrateAAF);
        FNC(arsenal,emptyCrate);
        FNC(arsenal,removeNightEquipment);

        FNC_BASE(initVehicle);
        FNC_BASE(initVehicleCiv);
        FNC_BASE(initUnitFIA);
        FNC_BASE(initUnitAAF);
        FNC_BASE(initUnitCIV);
        FNC_BASE(initUnitNATO);
        FNC_BASE(initUnitCSAT);
    };

    class withInterface {
        FNC_BASE(activatePlayerRankLoop);
        FNC_BASE(showProgressBar);
        FNC_BASE(respawnPlayer);
        FNC_BASE(spawnPlayer);
        FNC_BASE(showFoundIntel);
        FNC_BASE(fastTravel);
        FNC_BASE(unlockVehicle);
        FNC_BASE(revealToPlayer);

        FNC(actions,addAction);

        FNC(ai_control,controlsAI);
        FNC(ai_control,setAIControl);
        FNC(ai_control,dropAIcontrol);
        FNC(ai_control,safeDropAIcontrol);
        FNC(ai_control,completeDropAIcontrol);
        FNC(ai_control,controlUnit);
        FNC(ai_control,controlHCSquad);
        FNC_UI(ai_control,controlUnit);
        FNC(ai_control,EH_handleDamage_AIcontrol);

        FNC_BASE(addFIAlocation);
        FNC(fia_recruitment,recruitFIAgarrison);
        FNC(fia_recruitment,recruitFIAsquad);
        FNC(fia_recruitment,dismissFIAsquads);
        FNC(fia_recruitment,dismissFIAunits);
        FNC(fia_recruitment,dismissFIAgarrison);
        FNC(fia_recruitment,buyFIAvehicle);
        FNC(fia_recruitment,buyFIAskill);
        FNC(fia_recruitment,addSquadVehicle);
        FNC_UI(fia_recruitment,dismissSelected);

        FNC_UI(dialogs,squadVehicleStatus);
        FNC_UI(dialogs,squadVehicleDismount);

        FNC_UI(dialogs,donateMoney);
        FNC_UI(dialogs,changePersistent);
        FNC_UI(dialogs,toggleElegibility);
        FNC_UI(dialogs,showTopBar);

        FNC_UI(dialogs,natoAirstrike);

        #include "dialogs\buyVehicle\cfgFunctions.hpp"
        #include "dialogs\manageLocations\cfgFunctions.hpp"
        #include "dialogs\manageMissions\cfgFunctions.hpp"
        #include "dialogs\manageGarrisons\cfgFunctions.hpp"
        #include "dialogs\manageTraits\cfgFunctions.hpp"
        #include "dialogs\manageHQ\cfgFunctions.hpp"
        #include "dialogs\manageNATO\cfgFunctions.hpp"
        #include "dialogs\recruitUnit\cfgFunctions.hpp"
        #include "dialogs\recruitSquad\cfgFunctions.hpp"
        #include "dialogs\newGame\cfgFunctions.hpp"
        #include "dialogs\startMenu\cfgFunctions.hpp"
        #include "dialogs\loadMenu\cfgFunctions.hpp"
        #include "dialogs\saveMenu\cfgFunctions.hpp"
    };
};

class AS_TFAR {
    class withInterface {
        FNC(tfar,loadSettings);
        FNC(tfar,saveSettings);
    };
};

class AS_AI {
    class common {
        FNC(AI,activateSmokeCoverAI);
        FNC(AI,smokeCover);
        FNC(AI,autoRearm);
        FNC(AI,activateUnloadUnderSmoke);
        FNC(AI,surrender);
        FNC(AI,initDog);
        FNC(AI,dismountOnDanger);
    };
};

class AS_tactics {
    class common {
        FNC(tactics,heli_disembark);
        FNC(tactics,heli_paradrop);
        FNC(tactics,heli_fastrope);
        FNC(tactics,heli_attack);
        FNC(tactics,ground_disembark);
        FNC(tactics,ground_attack);
    };
};
