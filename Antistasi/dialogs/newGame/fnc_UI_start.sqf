disableSerialization;
private _side = (lbData [0, lbCurSel 0]) select [0, 4];

private _faction_anti_state = (lbData [0, lbCurSel 0]) select [4];
private _faction_pro_anti_state = (lbData [1, lbCurSel 1]) select [4];
private _faction_state = (lbData [2, lbCurSel 2]) select [4];
private _faction_pro_state = (lbData [3, lbCurSel 3]) select [4];

private _difficulty = ctrlText (findDisplay 1601 displayCtrl 4);

closeDialog 0;
hint "Select the position you want to start your HQ from.
      \nClose the map to start in the default position.
      \nChoose wisely: game changes a lot with the initial position!
      \nYou can move your HQ later.";
private _position = [true] call AS_fnc_UI_newGame_selectHQ;
hint "";

[_side, _faction_anti_state, _faction_pro_anti_state, _faction_state, _faction_pro_state, "CIV", _position, _difficulty] remoteExec ["AS_fnc_startNewGame", 2];
