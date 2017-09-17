// Increases the time the location is busy.
// Location needs to be a base or airport
#include "../macros.hpp"
AS_SERVER_ONLY("AS_location_fnc_increaseBusy");
params ["_location", "_minutes"];
private _busy = [_location,"busy"] call AS_location_fnc_get;
if (_busy < dateToNumber date) then {_busy = dateToNumber date};

private _busy = numberToDate [2035,_busy];
_busy set [4, (_busy select 4) + _minutes];

[_location,"busy",dateToNumber _busy] call AS_location_fnc_set;
