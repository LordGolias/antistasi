params [["_on", false]];

// turn debug on
if (!AS_debug_flag and _on) then {
    AS_debug_flag = _on;
    publicVariable "AS_debug_flag";
    diag_log "[AS] Server: debug mode enabled.";
    hint "AS debug mode enabled.";
    AS_debug_flag_all = [];

    {
        [_x] call AS_debug_fnc_initVehicle;
    } forEach vehicles;

    {
        if (side _x in [side_red,side_blue,civilian]) then {
            [_x] call AS_debug_fnc_initUnit;
        };
    } forEach allUnits;

    {
        [_x] call AS_debug_fnc_initDead;
    } forEach allDead;

    {
        [_x] call AS_debug_fnc_initLocation;
    } forEach (call AS_location_fnc_all);
};

// turn debug off
if (AS_debug_flag and !_on) then {
    AS_debug_flag = _on;  // this kills all markers
    AS_debug_flag_all = nil;
    publicVariable "AS_debug_flag";
    diag_log "[AS] Server: debug mode disabled.";
    hint "AS debug mode disabled.";
};
