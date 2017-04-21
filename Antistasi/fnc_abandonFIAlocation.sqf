#include "macros.hpp"
AS_SERVER_ONLY("fnc_abandonFIAlocation.sqf");
private _type = _this call AS_fnc_location_type;

if (_type == "camp") then {
    campNames pushBack ([_this, "name"] call AS_fnc_location_get);
};

// transfer garrison to FIA HQ

private _hq_garrison = "FIA_HQ" call AS_fnc_location_garrison;
_hq_garrison append (_this call AS_fnc_location_garrison);
["FIA_HQ","garrison",_hq_garrison] call AS_fnc_location_set;
"FIA_HQ" call AS_fnc_location_updateMarker;

_this call AS_fnc_location_delete;

hint "Location abandoned";
