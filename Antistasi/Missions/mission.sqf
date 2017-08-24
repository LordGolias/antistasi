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
#include "../macros.hpp"
// maximum distance from HQ for a mission to be available
AS_missions_MAX_DISTANCE = 4000;
// maximum number of missions available or active.
AS_missions_MAX_MISSIONS = 10;

AS_fnc_missions = {"mission" call AS_fnc_objects};

AS_fnc_mission_get = {
    params ["_mission", "_property"];
    ["mission", _mission, _property] call AS_fnc_object_get
};

AS_fnc_mission_set = {
    params ["_mission", "_property", "_value"];
    ["mission", _mission, _property, _value] call AS_fnc_object_set;
};

AS_fnc_mission_status = {
    [_this, "status"] call AS_fnc_mission_get
};

AS_fnc_mission_type = {
    [_this, "type"] call AS_fnc_mission_get
};

AS_fnc_mission_location = {
    [_this, "location"] call AS_fnc_mission_get
};

AS_fnc_mission_add = {
    params ["_type", "_location"];
    private _name = format ["%1_%2", _type, _location];
    ["mission", _name] call AS_fnc_object_add;
    [_name, "status", "possible"] call AS_fnc_mission_set;
    [_name, "type", _type] call AS_fnc_mission_set;
    [_name, "location", _location] call AS_fnc_mission_set;
    _name
};

AS_fnc_mission_create = {
    AS_SERVER_ONLY("AS_fnc_mission_create");
    params ["_type", "_NATOsupport", ["_params", []]];
    private _mission = [_type, ""] call AS_fnc_mission_add;
    [-_NATOsupport, 0] call AS_fnc_changeForeignSupport;
    [_mission, "NATOsupport", AS_P("NATOsupport")] call AS_fnc_mission_set;
    {
        _x params ["_name", "_value"];
        [_mission, _name, _value] call AS_fnc_mission_set;
    } forEach _params;
    _mission call AS_fnc_mission_activate;
};

AS_fnc_mission_remove = {["mission",_this] call AS_fnc_object_remove};

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

AS_fnc_mission_title = {
    params ["_mission"];
    private _missionType = _mission call AS_fnc_mission_type;
    if (_missionType == "kill_officer") exitWith {localize "STR_tsk_ASOfficer"};
    if (_missionType == "kill_specops") exitWith {localize "STR_tsk_ASSpecOp"};
    if (_missionType == "kill_traitor") exitWith {localize "STR_tsk_ASSTraitor"};
    if (_missionType == "black_market") exitWith {localize "Str_tsk_fndExp"};
    if (_missionType == "pamphlets") exitWith {localize "STR_tsk_PRPamphlet"};
    if (_missionType == "broadcast") exitWith {localize "STR_tsk_PRBrain"};
    if (_missionType == "convoy_armor") exitWith {localize "STR_tsk_CVY_Armor"};
    if (_missionType == "convoy_ammo") exitWith {localize "STR_tsk_CVY_Ammo"};
    if (_missionType == "convoy_money") exitWith {localize "STR_tsk_CVY_Money"};
    if (_missionType == "convoy_supplies") exitWith {localize "STR_tsk_CVY_Supply"};
    if (_missionType == "convoy_prisoners") exitWith {localize "STR_tsk_CVY_Pris"};
    if (_missionType == "convoy_hvt") exitWith {localize "STR_tsk_CVY_HVT"};
    if (_missionType == "rescue_prisioners") exitWith {localize "STR_tsk_resPrisoners"};
    if (_missionType == "rescue_refugees") exitWith {localize "STR_tsk_resRefugees"};
    if (_missionType == "rob_bank") exitWith {localize "STR_tsk_logBank"};
    if (_missionType == "help_meds") exitWith { localize "STR_tsk_logSupply"};
    if (_missionType == "send_meds") exitWith {localize "STR_tsk_logMedical"};
    if (_missionType == "steal_ammo") exitWith {localize "STR_tsk_logAmmo"};
    if (_missionType == "destroy_vehicle") exitWith {localize "STR_tsk_DesVehicle"};
    if (_missionType == "destroy_helicopter") exitWith {localize "STR_tsk_DesHeli"};
    if (_missionType == "destroy_antenna") exitWith {localize "STR_tsk_DesAntenna"};
    if (_missionType == "repair_antenna") exitWith {localize "STR_tsk_repAntenna"};
    if (_missionType == "conquer") exitWith {"Take location"};
    diag_log format ["[AS] Error: mission_title: invalid type '%1'", _missionType];
};

AS_fnc_mission_name = {
    params ["_mission"];
    private _location = _mission call AS_fnc_mission_location;

    private _name = _mission call AS_fnc_mission_title;
    if (_location != "") then {
        _name = _name + " at " + ([_location] call localizar);
    };
    _name
};

AS_fnc_mission_updateAvailable = {
    // make possible missions available and vice-versa.

    private _fnc_allPossibleMissions = {
        private _possible = [];

        private _locations = [[
            "city","outpost", "base", "airfield", "powerplant",
            "resource", "factory", "seaport", "outpostAA"
        ], "AAF"] call AS_fnc_location_TS;

        private _fnc_isPossibleMission = {
            // Checks whether the combination of location and mission type is a possible mission
            params ["_missionType", "_location"];

            not (_location call AS_fnc_location_spawned) and
            {(_location call AS_fnc_location_position) distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE}
        };

        private _cityMissions = [
            "pamphlets", "broadcast", "kill_specops", "kill_traitor",
            "send_meds", "help_meds","rescue_refugees",
            "convoy_money", "convoy_supplies"
        ];
        private _baseMissions = [
            "destroy_vehicle", "convoy_armor", "convoy_ammo", "convoy_prisoners", "convoy_hvt",
            "kill_officer", "rescue_prisioners", "steal_ammo"
        ];
        private _conquerableLocations = [
            "outpost", "base", "airfield", "powerplant",
            "resource", "factory", "seaport", "outpostAA"
        ];

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

        {
            private _location = _x;
            {
                private _mission = [_x, _location];
                if (_mission call _fnc_isPossibleMission and {_mission call _fnc_isValidMission}) then {
                    _possible pushBack _mission;
                };
            } forEach _cityMissions + _baseMissions + [
                "destroy_helicoper", "conquer", "destroy_antenna", "rob_bank"
            ];
        } forEach _locations;

        // add other missions
        {
            private _location = _x call AS_fnc_location_nearest;
            if ((_x distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE) and
                (_location call AS_fnc_location_side == "AAF") and
                not(_location call AS_fnc_location_spawned)) then {
                _possible pushBack ["destroy_antenna", _location];
            };
        } forEach AS_P("antenasPos_alive");

        {
            private _position = _x call AS_fnc_location_position;
            if (not (["rob_bank", _x] in _possible) and {_position distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE} and
                {
                    private _bank_position = [AS_bankPositions, _position] call BIS_fnc_nearestPosition;
                    (_position distance _bank_position) < (_x call AS_fnc_location_size)} and
                {_x call AS_fnc_location_side == "AAF"} and
                {not(_x call AS_fnc_location_spawned)}) then {
                _possible pushBack ["rob_bank", _x];
            };
        } forEach (call AS_fnc_location_cities);

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

    private _fnc_isAvailable = {
        params ["_mission"];
        private _missionType = _mission call AS_fnc_mission_type;
        private _location = _mission call AS_fnc_mission_location;

        if (_mission call AS_fnc_mission_status == "active") exitWith {false};

        False or
        {not (_missionType in ["pamphlets", "broadcast", "convoy_money", "convoy_supplies", "convoy_armor", "convoy_ammo", "convoy_prisoners", "convoy_hvt"])} or
        {_missionType == "pamphlets" and [_location, "AAFsupport"] call AS_fnc_location_get > 0} or
        {_missionType == "broadcast" and [_location, "FIAsupport"] call AS_fnc_location_get > 10} or
        {_missionType in ["convoy_money", "convoy_supplies", "convoy_armor", "convoy_ammo", "convoy_prisoners", "convoy_hvt"] and {
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

    // 1. intersect the list of possible missions with the cached possible missions
    //  * removes possible missions when they are no longer possible
    //  * make available missions possible when they are no longer available
    //  * adds new possible missions when they do not exist
    private _possible = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["possible", "available"]};
    private _new_possible = call _fnc_allPossibleMissions;
    {
        private _signature = [_x call AS_fnc_mission_type, _x call AS_fnc_mission_location];
        if not (_signature in _new_possible) then {
            _x call AS_fnc_mission_remove;
        } else {
            if (_x call AS_fnc_mission_status == "available" and {not (_x call _fnc_isAvailable)}) then {
                [_x, "status", "possible"] call AS_fnc_mission_set;
            };
        };
    } forEach _possible;

    {
        _x params ["_type", "_location"];
        if not ((format ["%1_%2", _type, _location]) in _possible) then {
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
            [_x, "status", "available"] call AS_fnc_mission_set;
            // update in-memory
            _available pushBack _x;
            _count = _count + 1;
        };
    } forEach (_possible call AS_fnc_shuffle);
};

AS_fnc_mission_activate = {
    params ["_mission"];

    [_mission, "status", "active"] call AS_fnc_mission_set;

    private _arguments = _mission;

    private _script = call {
        private _missionType = _mission call AS_fnc_mission_type;

        if (_missionType == "kill_traitor") exitWith {"ASS_Traidor"};
        if (_missionType == "black_market") exitWith {"AS_mis_black_market"};
        if (_missionType == "pamphlets") exitWith {"PR_Pamphlet"};
        if (_missionType == "broadcast") exitWith {"PR_Brainwash"};
        if (_missionType in ["convoy_armor", "convoy_ammo","convoy_money", "convoy_supplies", "convoy_prisoners", "convoy_hvt"]) exitWith {"AS_mis_convoy"};
        if (_missionType == "rob_bank") exitWith {"LOG_Bank"};
        if (_missionType == "help_meds") exitWith {"LOG_Suministros"};
        if (_missionType == "send_meds") exitWith {"LOG_Medical"};
        if (_missionType == "destroy_helicopter") exitWith {"DES_Heli"};
        if (_missionType == "conquer") exitWith {"AS_mis_conquer"};

        if (_missionType in ["nato_uav", "nato_armor", "nato_ammo", "nato_cas", "nato_artillery",
                             "nato_roadblock",
                             "steal_ammo", "repair_antenna",
                             "kill_specops", "kill_officer", "destroy_vehicle", "destroy_antenna",
                             "rescue_prisioners", "rescue_refugees"]) exitWith {
            _arguments = ["mission", _mission]; "AS_spawn_fnc_start"
        };
        if (_missionType == "nato_qrf") exitWith {"AS_mis_natoQRF"};
        if (_missionType == "nato_attack") exitWith {"AS_mis_natoAttack"};
        ""
    };
    if (_script == "") exitWith {
        diag_log format ["[AS] Error: AS_fnc_mission_activate: mission '%1' does not have script", _mission];
    };
    [_arguments, _script] call AS_scheduler_fnc_execute;
};

AS_fnc_mission_dismiss = {
    params ["_mission"];
    private _available = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["available"]};
    if not (_mission in _available) exitWith {
        diag_log format ["[AS] Error: AS_fnc_mission_dismiss: mission '%1' is not available", _mission];
    };

    [_mission, "status", "possible"] call AS_fnc_mission_set;
};

AS_fnc_mission_completed = {
    params ["_mission"];
    private _active = (call AS_fnc_missions) select {_x call AS_fnc_mission_status in ["active"]};
    if not (_mission in _active) exitWith {
        diag_log format ["[AS] Error: AS_fnc_mission_complete: mission '%1' is not active", _mission];
    };

    [_mission, "status", "completed"] call AS_fnc_mission_set;
};

AS_fnc_mission_save = {
    params ["_saveName"];
    ["mission", _saveName] call AS_fnc_object_save;
};

AS_fnc_mission_load = {
    params ["_saveName"];
    {_x call AS_fnc_mission_remove} forEach (call AS_fnc_missions);
    ["mission", _saveName] call AS_fnc_object_load;
    {_x call AS_fnc_mission_activate} forEach (call AS_fnc_active_missions);
};

AS_mission_fnc_spawn_wait_spawn = {
    params ["_mission"];

	private _task = ([_mission, "CREATED"] call AS_spawn_fnc_loadTask) call BIS_fnc_setTask;

	[_mission, "resources", [_task, [], [], []]] call AS_spawn_fnc_set;
};

AS_mission_fnc_clean = {
	params ["_mission"];
	([_mission, "resources"] call AS_spawn_fnc_get) params ["_task", "_groups", "_vehicles", "_markers"];

    {AS_commander hcRemoveGroup _x} forEach _groups;
	[_groups, _vehicles, _markers] call AS_fnc_cleanResources;
	sleep 30;
	[_task] call BIS_fnc_deleteTask;
	_mission call AS_fnc_mission_completed;
};
