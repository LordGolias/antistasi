#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_getData");
params ["_saveName"];
profileNameSpace getVariable ["AS_v1_" + _saveName, ""]
