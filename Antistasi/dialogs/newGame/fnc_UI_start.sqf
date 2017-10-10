disableSerialization;
private _side = (lbData [0, lbCurSel 0]) select [0, 4];

private _faction_anti_state = (lbData [0, lbCurSel 0]) select [4];
private _faction_pro_anti_state = (lbData [1, lbCurSel 1]) select [4];
private _faction_state = (lbData [2, lbCurSel 2]) select [4];
private _faction_pro_state = (lbData [3, lbCurSel 3]) select [4];
hint str [_side, _faction_anti_state, _faction_pro_anti_state, _faction_state, _faction_pro_state, "CIV"];

[_side, _faction_anti_state, _faction_pro_anti_state, _faction_state, _faction_pro_state, "CIV"] remoteExec ["AS_fnc_startNewGame", 2];
closeDialog 0;
