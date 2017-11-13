disableSerialization;
private _mission = lbData [0, lbCurSel 0];
private _textCbo = ((findDisplay 1602) displayCtrl 1);
if (_mission == "") exitWith {
    _textCbo ctrlSetStructuredText parseText "No mission selected";
};

private _str_success = "";
{
    _str_success = _str_success + format ["* %1<br/>", _x];
} forEach (_mission call AS_mission_fnc_getSuccessDescription);
private _str_fail = "";
{
    _str_fail = _str_fail + format ["* %1<br/>", _x];
} forEach (_mission call AS_mission_fnc_getFailDescription);

private _str = format ["Success outcomes<br/>%1Failure outcomes<br/>%2", _str_success, _str_fail];

_textCbo ctrlSetStructuredText parseText _str;
