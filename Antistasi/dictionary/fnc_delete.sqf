// recursively deletes a dictionary
#include "macros.hpp"

params ["_dictionary"];
{
    private _value = _dictionary getVariable _x;
    if ISOBJECT(_value) then {
        _value call EFUNC(delete);
    };
} forEach allVariables _dictionary;
deleteVehicle _dictionary;
