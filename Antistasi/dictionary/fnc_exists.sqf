// Checks whether a key exists in the dictionary. Use multiple keys for nested operation
#include "macros.hpp"

if (count _this < 2) exitWith {
    diag_log format ["DICT:get(%1):ERROR: requires 2 arguments", _this];
};
private _value = _this call EFUNC(_get);
not isNil "_value"
