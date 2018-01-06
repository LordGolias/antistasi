#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_setData");
params ["_saveName", "_data"];
profileNameSpace setVariable ["AS_v1_" + _saveName, _data];
