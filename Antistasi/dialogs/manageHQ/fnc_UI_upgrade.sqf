#include "../../macros.hpp"

if (BE_currentStage == 3) exitWith {
    hint "No further training available.";
};
private _price = call fnc_BE_calcPrice;
if (AS_P("resourcesFIA") > _price) then {
    [] remoteExec ["fnc_BE_upgrade", 2];
    hint "FIA upgraded";
} else {
    hint "Not enough money.";
};
