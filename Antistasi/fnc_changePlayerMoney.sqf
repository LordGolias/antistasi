#include "macros.hpp"
AS_SERVER_ONLY("fnc_changePlayerMoney");
params ["_player", "_value"];
_player setVariable ["money", (_player getVariable "money") + _value, true];
