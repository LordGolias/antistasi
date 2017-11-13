#include "../macros.hpp"
AS_SERVER_ONLY("fnc_defend_camp");

params ["_location"];

// only one defence mission at a time, no camp attacks while CSAT coms are being jammed
private _debug_prefix = format ["defend_camp from '%1' to '%2' cancelled: ", _location];
if AS_S("blockCSAT") exitWith {
    private _message = "blocked";
    AS_ISDEBUG(_debug_prefix + _message);
};
if not isNil {AS_S("campQRF")} exitWith {
    private _message = "another attack already in progress";
    AS_ISDEBUG(_debug_prefix + _message);
};

if (count ("defend_camp" call AS_mission_fnc_active_missions) != 0) exitWith {
    private _message = "another attack already in progress";
    AS_ISDEBUG(_debug_prefix + _message);
};

private _mission = ["defend_camp", _location] call AS_mission_fnc_add;
_mission call AS_mission_fnc_activate;
