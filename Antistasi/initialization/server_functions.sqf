call compile preprocessFileLineNumbers "Functions\serverFunctions.sqf";

call compile preprocessFileLineNumbers "Functions\maintenance.sqf";

AAFeconomics = compile preProcessFileLineNumbers "AAFeconomics.sqf";
AS_fnc_setEasy = compile preProcessFileLineNumbers "fnc_setEasy.sqf";
FIAradio = compile preProcessFileLineNumbers "FIAradio.sqf";

AS_fnc_abandonFIALocation = compile preProcessFileLineNumbers "fnc_abandonFIALocation.sqf";
AS_fnc_renameFIAcamp = compile preProcessFileLineNumbers "fnc_renameFIAcamp.sqf";

resourcesAAF = compile preProcessFileLineNumbers "resourcesAAF.sqf";
resourcesFIA = compile preProcessFileLineNumbers "resourcesFIA.sqf";
citySupportChange = compile preProcessFileLineNumbers "citySupportChange.sqf";
AS_fnc_changeSecondsforAAFattack = compile preProcessFileLineNumbers "Functions\fnc_changeSecondsforAAFattack.sqf";
AS_fnc_changeForeignSupport = compile preProcessFileLineNumbers "fnc_changeForeignSupport.sqf";

AS_fnc_initPetros = compile preProcessFileLineNumbers "fnc_initPetros.sqf";
AS_fnc_HQbuild = compile preProcessFileLineNumbers "fnc_HQbuild.sqf";
AS_fnc_HQdeploy = compile preProcessFileLineNumbers "fnc_HQdeploy.sqf";
AS_fnc_HQmove = compile preProcessFileLineNumbers "fnc_HQmove.sqf";
AS_fnc_HQplace = compile preProcessFileLineNumbers "fnc_HQplace.sqf";
AS_fnc_HQaddObject = compile preprocessFileLineNumbers "fnc_HQaddObject.sqf";

AS_fnc_location_win = compile preProcessFileLineNumbers "fnc_location_win.sqf";
AS_fnc_location_lose = compile preProcessFileLineNumbers "fnc_location_lose.sqf";
AS_fnc_location_destroy = compile preProcessFileLineNumbers "fnc_location_destroy.sqf";
AS_fnc_updateAll = compile preProcessFileLineNumbers "fnc_updateAll.sqf";

powerReorg = compile preProcessFileLineNumbers "powerReorg.sqf";

fpsChange = compile preProcessFileLineNumbers "fpsChange.sqf";

AS_fnc_addMinefield = compile preProcessFileLineNumbers "Functions\fnc_addMinefield.sqf";

AS_fnc_changePersistentVehicles = compile preProcessFileLineNumbers "Functions\fnc_changePersistentVehicles.sqf";

AS_fnc_deployAAFminefield = compile preProcessFileLineNumbers "Functions\fnc_deployAAFminefield.sqf";

buyGear = compile preProcessFileLineNumbers "Municion\buyGear.sqf";

onPlayerDisconnect = compile preProcessFileLineNumbers "onPlayerDisconnect.sqf";

// player score, rank, eligibility and commanding
AS_fnc_changePlayerScore = compile preProcessFileLineNumbers "orgPlayers\fnc_changePlayerScore.sqf";
AS_fnc_chooseCommander = compile preProcessFileLineNumbers "orgPlayers\fnc_chooseCommander.sqf";
