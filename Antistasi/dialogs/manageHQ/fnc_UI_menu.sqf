disableSerialization;
private ["_display","_childControl","_texto"];
createDialog "AS_manageHQ";

_display = findDisplay 1602;

if (str (_display) != "no display") then {
    _childControl = _display displayCtrl 109;
    if (BE_currentStage == 3) then {
        _texto = "No further training available.";
    } else {
        _texto = format ["Training Cost: %1 €", call fnc_BE_calcPrice];
    };
    _childControl  ctrlSetTooltip _texto;
};
