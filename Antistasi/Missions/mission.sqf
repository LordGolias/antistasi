/*
This is a API to handle missions: a set of tasks that the player chooses to initiate
that ends with different outcomes.
Tasks initialize resources (e.g. soldiers,vehicles,markers) and own them.
Therefore, it is important that these resources are accessible to be destroyed.

This API handles the following mission `status`:
* possible
* available
* active
* completed
*/
// maximum distance from HQ for a mission to be available
AS_missions_MAX_DISTANCE = 4000;
// maximum number of missions available or active.
AS_missions_MAX_MISSIONS = 5;

AS_fnc_missions = {
    "mission" call AS_fnc_objects
};

AS_fnc_mission_status = {
    [_this, "status"] call AS_fnc_object_get
};

AS_fnc_mission_type = {
    [_this, "type"] call AS_fnc_object_get
};

AS_fnc_mission_location = {
    [_this, "location"] call AS_fnc_object_get
};

// return all active missions of a given type
AS_fnc_active_missions = {
    params ["_missionType"];
    (call AS_fnc_missions) select {
        _x call AS_fnc_mission_status == "active" and
        _x call AS_fnc_mission_type == _missionType}
};

AS_fnc_available_missions = {
    (call AS_fnc_missions) select {_x call AS_fnc_mission_status == "available"}
};

AS_fnc_mission_name = {
    params ["_mission"];
    private _missionType = _mission call AS_fnc_mission_type;
    private _location = _mission call AS_fnc_mission_location;

    private _name = _missionType;
    if (_location != "") then {
        _name = _name + " at " + [_location] call localizar;
    };
    _name
};


private _fnc_signature_to_mission = {
    params ["_type", "_location"];
    format ["%s_%s", _type, _location]
};

private _fnc_mission_to_signature = {
    [_this call AS_fnc_mission_type, _this call AS_fnc_mission_location]
};

// missions in cities
private _cityMissions = [
    "pamphlets", "broadcast", "kill_specops", "kill_traitor",
    "send_meds", "help_meds","rescue_refugees",
    "convoy_money", "convoy_supplies"
];

private _baseMissions = [
    "destroy_vehicle", "convoy_armor", "convoy_ammo",
    "kill_officer", "rescue_prisioners", "steal_ammo"
];

private _conquerableLocations = [
    "outpost", "base", "airfield", "powerplant",
    "resource", "factory", "seaport", "outpostAA"
];

private _allMissionTypes = _cityMissions + _baseMissions + [
    "destroy_helicoper", "conquer", "destroy_antenna", "rob_bank"
];

private _mission_to_script = {
    params ["_mission"];
    private _missionType = _mission call AS_fnc_mission_type;

    if (_missionType == "kill_officer") exitWith {_mission call AS_mis_assassinate};
    if (_missionType == "kill_specops") exitWith {_mission call AS_mis_assassinate};
    if (_missionType == "kill_traitor") exitWith {_mission call ASS_Traidor};
    if (_missionType == "black_market") exitWith {_mission call AS_mis_black_market};
    if (_missionType == "pamphlets") exitWith {_mission call PR_Pamphlet};
    if (_missionType == "broadcast") exitWith {_mission call PR_Brainwash};
    if (_missionType in ["convoy_armor", "convoy_ammo","convoy_money", "convoy_supplies"]) exitWith {_mission call AS_mis_convoy};
    if (_missionType == "rescue_prisioners") exitWith {_mission call RES_Prisioneros};
    if (_missionType == "rescue_refugees") exitWith {_mission call RES_Refugiados};
    if (_missionType == "rob_bank") exitWith {_mission call LOG_Bank};
    if (_missionType == "help_meds") exitWith {_mission call LOG_Suministros};
    if (_missionType == "send_meds") exitWith {_mission call LOG_Medical};
    if (_missionType == "steal_ammo") exitWith {_mission call LOG_Ammo};
    if (_missionType == "destroy_vehicle") exitWith {_mission call DES_Vehicle};
    if (_missionType == "destroy_helicopter") exitWith {_mission call DES_Heli};
    if (_missionType == "destroy_antenna") exitWith {_mission call DES_Antena};
    if (_missionType == "repair_antenna") exitWith {_mission call AS_mis_repair_antenna};
    if (_missionType == "conquer") exitWith {_mission call AS_mis_conquer};
    diag_log format ["[AS] Error: _mission_to_script: mission type '%1' does not have script", _missionType];
};

private _fnc_isValidMission = {
    // checks whether a given mission type is valid for a given location
    params ["_missionType", "_location"];
    private _type = _location call AS_fnc_location_type;

    false or
    {_type == "outpost" and {_missionType in ["rescue_prisioners", "steal_ammo"]}} or
    {_type == "city" and {_missionType in _cityMissions}} or
    {_type == "base" and {_missionType in _baseMissions}} or
    {_type == "airfield" and {_missionType == "destroy_helicopter"}} or
    {_type in _conquerableLocations and {_missionType == "conquer"}}
};

private _fnc_isPossibleMission = {
    // Checks whether the combination of location and mission type is a possible mission
    params ["_missionType", "_location"];

    not (_location call AS_fnc_location_spawned) and
    {(_location call AS_fnc_location_position) distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE}
};

private _fnc_allPossibleMissions = {
    private _possible = [];

    private _locations = [[
        "city","outpost", "base", "airfield", "powerplant",
        "resource", "factory", "seaport", "outpostAA"
    ], "AAF"] call AS_fnc_location_TS;

    {
        private _location = _x;
        {
            private _mission = [_x, _location];
            if (_mission call _fnc_isPossibleMission and {_mission call _fnc_isValidMission}) then {
                _possible pushBack _mission;
            };
        } forEach _allMissionTypes;
    } forEach _locations;

    // add other missions
    {
        private _location = _x call AS_fnc_location_nearest;
        if ((_x distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE) and
            (_location call AS_fnc_location_side == "AAF") and
            not(_location call AS_fnc_location_spawned)) then {
            _possible pushBack ["destroy_antenna", _location];
        };
    } forEach antenas;

    {
        private _location = _x call AS_fnc_location_nearest;
        if ((_x distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE) and
            (_location call AS_fnc_location_side == "AAF") and
            not(_location call AS_fnc_location_spawned)) then {
            _possible pushBack ["rob_bank", _location];
        };
    } forEach AS_bankPositions;

    // it uses exitWith so there is only one possible mission at the time.
    {
        private _location = _x;
        private _mission = ["black_market", _location];
        if (_mission call _fnc_isPossibleMission) exitWith {
            _possible pushBack _mission;
        };
    } forEach ((["city"] call AS_fnc_location_T) call AS_fnc_shuffle);

    _possible
};

AS_fnc_mission_add = {
    params ["_type", "_location"];
    private _name = _this call _fnc_signature_to_mission;
    [_name, "mission", True] call AS_fnc_object_add;
    [_name, "status", "possible"] call AS_fnc_object_set;
    [_name, "type", _type] call AS_fnc_object_set;
    [_name, "location", _location] call AS_fnc_object_set;
    _name
};
AS_fnc_mission_remove = AS_fnc_object_remove;

private _fnc_isAvailable = {
    private ["_mission"];
    private _missionType = _mission call AS_fnc_mission_type;
    private _location = _mission call AS_fnc_mission_location;

    if (_mission call AS_fnc_mission_status == "active") exitWith {false};

    False or
    {not (_missionType in ["pamphlets", "broadcast", "convoy_money", "convoy_supplies", "convoy_armor", "convoy_ammo"])} or
    {_missionType == "pamphlets" and [_location, "AAFsupport"] call AS_fnc_location_get > 0} or
    {_missionType == "broadcast" and [_location, "FIAsupport"] call AS_fnc_location_get > 10} or
    {_missionType in ["convoy_money", "convoy_supplies", "convoy_armor", "convoy_ammo"] and {
        // needs a base around
        private _base = [_location call AS_fnc_location_position] call findBasesForConvoy;

        private _condition = {_base != "" and {not(_base call AS_fnc_location_spawned)}};
        if (_missionType == "convoy_armor") then {
            _condition = True and _condition and {count ["tanks"] call AS_fnc_AAFarsenal_all > 0};
        };
        if (_missionType == "convoy_ammo") then {
            _condition = True and _condition and {["supplies"] call AS_fnc_AAFarsenal_count > 0};
        };
        call _condition
    }}
};

AS_fnc_updateAvailableMissions = {
    // make possible missions available and vice-versa.

    // 1. intersect the list of possible missions with the cached possible missions
    //  * removes possible missions when they are no longer possible
    //  * make available missions possible when they are no longer available
    //  * adds new possible missions when they do not exist
    private _possible = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["possible", "available"]};
    private _new_possible = call _fnc_allPossibleMissions;
    {
        private _signature = _x call _fnc_mission_to_signature;
        if not (_signature in _new_possible) then {
            _x call AS_fnc_mission_remove;
        } else {
            if (_x call AS_fnc_mission_status == "available" and {not (_x call _fnc_isAvailable)}) then {
                [_x, "status", "possible"] call AS_fnc_object_set;
            };
        };
    } forEach _possible;

    {
        if not (_x call _fnc_signature_to_mission in _possible) then {
            _x call AS_fnc_mission_add;
        };
    } forEach _new_possible;

    // 2. convert possible missions to available missions up to 5 available+active missions
    _possible = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["possible", "available"]}; // update in-memory list

    private _available = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["available", "active"]};
    private _count = count _available;

    {
        if (_count >= AS_missions_MAX_MISSIONS) exitWith {};
        // make mission available
        if not (_x in _available) then {
            [_x, "status", "available"] call AS_fnc_object_set;
            // update in-memory
            _available pushBack _x;
            _count = _count + 1;
        };
    } forEach (_possible call AS_fnc_shuffle);
};

AS_fnc_mission_activate = {
    params ["_mission", ["_forced", false]];
    if _forced exitWith {
        _mission call _mission_to_script;
    };
    private _available = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["available"]};
    if not (_mission in _available) exitWith {
        diag_log format ["[AS] Error: AS_fnc_mission_activate: mission '%1' is not available", _mission];
    };

    [_mission, "status", "active"] call AS_fnc_object_set;

    _mission call _mission_to_script;
};

AS_fnc_mission_dismiss = {
    params ["_mission"];
    private _available = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["available"]};
    if not (_mission in _available) exitWith {
        diag_log format ["[AS] Error: AS_fnc_mission_dismiss: mission '%1' is not available", _mission];
    };

    [_mission, "status", "possible"] call AS_fnc_object_set;
};

AS_fnc_mission_completed = {
    params ["_mission"];
    private _active = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["active"]};
    if not (_mission in _active) exitWith {
        diag_log format ["[AS] Error: AS_fnc_mission_complete: mission '%1' is not active", _mission];
    };

    [_mission, "status", "completed"] call AS_fnc_object_set;
};
