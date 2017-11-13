#include "macros.hpp"
params ["_type", "_formatData", "_percentage"];
// "Rank" can only be changed by the client, else only by the server
private _exit = true;
if (_type == "Rank") then {
    AS_CLIENT_ONLY("fnc_updateProgressBar");
    _exit = false;
} else {
    AS_SERVER_ONLY("fnc_updateProgressBar");
    _exit = false;
};

if _exit exitWith {};

private _PBar = "";

call {
    if (_percentage > 0.80) exitWith {
        _PBar = format (["%5: %3 (<t color='%1'>>>>></t><t color='%2'></t>%4)"] + _formatData);
    };
    if (_percentage > 0.60) exitWith {
        _PBar = format (["%5: %3 (<t color='%1'>>>></t><t color='%2'>></t>%4)"] + _formatData);
    };
    if (_percentage > 0.40) exitWith {
        _PBar = format (["%5: %3 (<t color='%1'>>></t><t color='%2'>>></t>%4)"] + _formatData);
    };
    if (_percentage > 0.20) exitWith {
        _PBar = format (["%5: %3 (<t color='%1'>></t><t color='%2'>>>></t>%4)"] + _formatData);
    };
    if (_percentage <= 0.20) exitWith {
        _PBar = format (["%5: %3 (<t color='%2'>>>>></t>%4)"] + _formatData);
    };
};

// store the result (the actual showing is not called here)
if (_type == "Rank") exitWith {
    player setVariable ["Rank_PBar", _PBar, true];
};

if (_type == "Army XP") exitWith {
    AS_Sset("BE_PBar", _PBar);
};
