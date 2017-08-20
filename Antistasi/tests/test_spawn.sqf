[true] call AS_debug_init;
[] spawn {
    {
        private _type = _x;
        {
            private _side = _x;
            diag_log format ["[AS] test spawn: %1 %2", _type, _side];
            private _locations = _type call AS_fnc_location_T;
            private _location = _locations select 0;
            if (_type == "city") then {
                [_location, "AAFsupport", 0] call AS_fnc_location_set;
                [_location, "FIAsupport", 0] call AS_fnc_location_set;
                [_location, _side + "support", 100] call AS_fnc_location_set;
            } else {
                [_location, "side", _side] call AS_fnc_location_set;
            };
            [_location, true] call AS_fnc_location_spawn;
            sleep 10;
            [_location, true] call AS_fnc_location_despawn;
            sleep 10;
        } forEach ["FIA", "AAF"];
    } forEach ["city", "resource", "powerplant", "factory", "airfield", "base", "airfield", "outpost", "roadblock"];
    diag_log "[AS] test spawn: done";
};

// test spawn of patrol
[true] call AS_debug_init;
private _location = ("city" call AS_fnc_location_T) select 0;
[_location, _location] spawn AS_fnc_AAFpatrol;


// test spawn of road patrol
[true] call AS_debug_init;
hint str (["apcs"] call AS_fnc_AAFarsenal_addVehicle);
[] spawn AS_fnc_AAFroadPatrol;
// check map and see patrol moving
