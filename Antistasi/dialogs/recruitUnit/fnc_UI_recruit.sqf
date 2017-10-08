disableSerialization;
private _id = lbCurSel 0;
private _unitName = lbData [0, _id];

if (_unitName != "") then {

    if (call AS_fnc_controlsAI) exitWith {
        hint "You cannot buy units while you are controlling AI"
    };

    if (player != leader group player) exitWith {
        hint "You cannot recruit units as you are not your group leader"
    };

    if (count units group player) exitWith {
        hint "Your squad is full or you have too many scattered units with no radio contact"
    };

    [player, _unitName] remoteExec ["AS_fnc_recruitFIAunit", 2];
} else {
    hint "no unit selected";
};
