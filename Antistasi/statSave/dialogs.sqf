
AS_fncUI_closeSaveLoadMenu = {
    closeDialog 0;
    if (isNil "placementDone") then {
        [] spawn AS_fnc_HQselect;
    };
};

AS_fncUI_LoadSaveMenu = {
	disableSerialization;
	createDialog "AS_SaveLoadMenu";

    [] call AS_fncUI_updateSaveGameList;

    if (isNil "placementDone") then {
        private _backButton = ((findDisplay 1601) displayCtrl (72));
        _backButton ctrlSetText "New game";

        // catch the escape
        private _escapeKey = (findDisplay 1601) displayAddEventHandler ["KeyDown", {
            if ((_this select 1) == 1) then {  // escape pressed
                [] spawn AS_fnc_HQselect;
            };
            false
        }];
        waitUntil {!isNil "placementDone"};
        (findDisplay 1601) displayRemoveEventHandler ["KeyDown", _escapeKey];
    };
};

AS_fncUI_selectSave = {
    disableSerialization;
    private _id = lbCurSel 0;
    private _saveName = lbData [0, _id];
    ctrlsetText [2, _saveName];
};

AS_fncUI_updateSaveGameList = {
    disableSerialization;
    private _cbo = ((findDisplay 1601) displayCtrl (0));
	lbCLear _cbo;

    private _savedGames = profileNameSpace getVariable ["AS_savedGames", []];
    {
        _cbo lbAdd(_x);
        _cbo lbSetData[(lbSize _cbo)-1, _x];
    } forEach _savedGames;
    _cbo lbSetCurSel 0;
};

AS_fncUI_saveGame = {
    disableSerialization;
    private _saveName = ctrlText (((findDisplay 1601) displayCtrl (2)));

    if (_saveName != "") then {
        [_saveName] call AS_fnc_saveGame;
        [] call AS_fncUI_updateSaveGameList;
    } else {
        hint "no save selected";
    };
};

AS_fncUI_loadGame = {
    disableSerialization;
    private _id = lbCurSel 0;
    if (_id != -1) then {
        private _saveName = lbData [0, _id];
        private _wasLoaded = ([_saveName] call AS_fnc_loadGame);
        if (_wasLoaded) then {
            [] call AS_fncUI_updateSaveGameList;
            hint format ['"%1" loaded', _saveName];
            closeDialog 1601;
        };
    } else {
        hint "no save selected";
    };
};

AS_fncUI_deleteGame = {
    disableSerialization;
    private _id = lbCurSel 0;
    if (_id != -1) then {
        private _saveName = lbData [0, _id];
        [_saveName] call AS_fnc_deleteSavedGame;
        [] call AS_fncUI_updateSaveGameList;
        hint format ['"%1" deleted', _saveName];
    } else {
        hint "no save selected";
    };
};
