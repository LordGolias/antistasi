// Creates a new level on the dictionary.
#include "macros.hpp"
if (count _this < 2) exitWith {
    diag_log "DICT:add:ERROR: requires 2 arguments";
};
[_this select 0, _this select 1, call EFUNC(create)] call EFUNC(set);
