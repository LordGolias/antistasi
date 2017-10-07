#include "../macros.hpp"
AS_SERVER_ONLY("fnc_createDefendLocation");
params ["_location"];
private _debug_prefix = format ["defendLocation from '%1' to '%2' cancelled: ", _location];
if AS_S("blockCSAT") exitWith {
    private _message = "blocked";
    AS_ISDEBUG(_debug_prefix + _message);
};

private _position = _location call AS_location_fnc_position;

private _base = [_position] call AS_fnc_getBasesForCA;
private _airfield = [_position] call AS_fnc_getAirportsForCA;

// check if we have capabilities to use air units
// decide to not use airfield if not enough air units
if (_airfield != "") then {
    private _transportHelis = "helis_transport" call AS_AAFarsenal_fnc_count;
    private _armedHelis = "helis_armed" call AS_AAFarsenal_fnc_count;
    private _planes = "planes" call AS_AAFarsenal_fnc_count;
    // 1 transported + any other if _isMarker.
    if (_transportHelis < 1 or (_transportHelis + _armedHelis + _planes < 3)) then {
        _airfield = "";
    };
};

if ((_base=="") and (_airfield=="")) exitWith {
    private _message = "no available bases nor airports";
    AS_ISDEBUG(_debug_prefix + _message);
};

// check whether CSAT will support
private _useCSAT = false;
private _prestigeCSAT = AS_P("CSATsupport");
if ((random 100 < _prestigeCSAT) and (_prestigeCSAT >= 20) and not AS_S("blockCSAT")) then {
    _useCSAT = true;
};

private _mission = ["defend_location", _location] call AS_mission_fnc_add;
[_mission, "base", _base] call AS_mission_fnc_set;
[_mission, "airfield", _airfield] call AS_mission_fnc_set;
[_mission, "useCSAT", _useCSAT] call AS_mission_fnc_set;
_mission call AS_mission_fnc_activate;
