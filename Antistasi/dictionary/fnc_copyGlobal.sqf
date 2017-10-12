// Sets the value of the key of the dictionary. Use multiple keys for nested operation.
#include "macros.hpp"
params ["_dictionary", ["_ignore_keys", []]];
[_dictionary, _ignore_keys, true] call EFUNC(_copy);
