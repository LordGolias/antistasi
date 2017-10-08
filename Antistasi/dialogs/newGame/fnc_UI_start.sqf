disableSerialization;
private _side = (lbData [0, lbCurSel 0]) select [0, 4];

private _faction_guerrilla = (lbData [0, lbCurSel 0]) select [4];
private _faction_pro_guerrilla = (lbData [1, lbCurSel 1]) select [4];
private _faction_state = (lbData [2, lbCurSel 2]) select [4];
private _faction_pro_state = (lbData [3, lbCurSel 3]) select [4];
hint str [_side, _faction_guerrilla, _faction_pro_guerrilla,_faction_state, _faction_pro_state];
