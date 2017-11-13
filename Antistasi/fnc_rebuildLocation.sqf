#include "macros.hpp"
AS_SERVER_ONLY("fnc_rebuildLocation");

params ["_location"];
private _type = _location call AS_location_fnc_position;
[0,10,_location call AS_location_fnc_position] call AS_fnc_changeCitySupport;
[5,0] call AS_fnc_changeForeignSupport;
AS_Pset("destroyedLocations", AS_P("destroyedLocations") - [_location]);
if (_type == "powerplant") then {[_location] call AS_fnc_recomputePowerGrid};
[0,-5000] call AS_fnc_changeFIAmoney;
