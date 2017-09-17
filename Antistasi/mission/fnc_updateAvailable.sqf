// make possible missions available and vice-versa.
#include "../macros.hpp"
AS_SERVER_ONLY("AS_mission_fnc_updateAvailable");

// maximum distance from HQ for a mission to be available
#define AS_missions_MAX_DISTANCE 4000
// maximum number of missions available or active.
#define AS_missions_MAX_MISSIONS 10

private _fnc_allPossibleMissions = {
    private _possible = [];

    private _locations = [[
        "city","outpost", "base", "airfield", "powerplant",
        "resource", "factory", "seaport", "outpostAA"
    ], "AAF"] call AS_location_fnc_TS;

    private _fnc_isPossibleMission = {
        // Checks whether the combination of location and mission type is a possible mission
        params ["_missionType", "_location"];

        not (_location call AS_location_fnc_spawned) and
        {(_location call AS_location_fnc_position) distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE}
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
        private _type = _location call AS_location_fnc_type;

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
        private _location = _x call AS_location_fnc_nearest;
        if ((_x distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE) and
            (_location call AS_location_fnc_side == "AAF") and
            not(_location call AS_location_fnc_spawned)) then {
            _possible pushBack ["destroy_antenna", _location];
        };
    } forEach AS_P("antenasPos_alive");

    {
        private _position = _x call AS_location_fnc_position;
        if (not (["rob_bank", _x] in _possible) and {_position distance (getMarkerPos "FIA_HQ") < AS_missions_MAX_DISTANCE} and
            {
                private _bank_position = [AS_bankPositions, _position] call BIS_fnc_nearestPosition;
                (_position distance _bank_position) < (_x call AS_location_fnc_size)} and
            {_x call AS_location_fnc_side == "AAF"} and
            {not(_x call AS_location_fnc_spawned)}) then {
            _possible pushBack ["rob_bank", _x];
        };
    } forEach (call AS_location_fnc_cities);

    // it uses exitWith so there is only one possible mission at the time.
    {
        private _location = _x;
        private _mission = ["black_market", _location];
        if (_mission call _fnc_isPossibleMission) exitWith {
            _possible pushBack _mission;
        };
    } forEach ((["city"] call AS_location_fnc_T) call AS_fnc_shuffle);

    _possible
};

private _fnc_isAvailable = {
    params ["_mission"];
    private _missionType = _mission call AS_mission_fnc_type;
    private _location = _mission call AS_mission_fnc_location;

    if (_mission call AS_mission_fnc_status == "active") exitWith {false};

    False or
    {not (_missionType in ["pamphlets", "broadcast", "convoy_money", "convoy_supplies", "convoy_armor", "convoy_ammo", "convoy_prisoners", "convoy_hvt"])} or
    {_missionType == "pamphlets" and [_location, "AAFsupport"] call AS_location_fnc_get > 0} or
    {_missionType == "broadcast" and [_location, "FIAsupport"] call AS_location_fnc_get > 10} or
    {_missionType in ["convoy_money", "convoy_supplies", "convoy_armor", "convoy_ammo", "convoy_prisoners", "convoy_hvt"] and {
        // needs a base around
        private _base = [_location call AS_location_fnc_position] call AS_fnc_getBasesForConvoy;

        private _condition = {_base != "" and {not(_base call AS_location_fnc_spawned)}};
        if (_missionType == "convoy_armor") then {
            _condition = True and _condition and {"tanks" call AS_AAFarsenal_fnc_count > 0};
        };
        if (_missionType == "convoy_ammo") then {
            _condition = True and _condition and {"supplies" call AS_AAFarsenal_fnc_count > 0};
        };
        call _condition
    }}
};

// 1. intersect the list of possible missions with the cached possible missions
//  * removes possible missions when they are no longer possible
//  * make available missions possible when they are no longer available
//  * adds new possible missions when they do not exist
private _possible = (call AS_mission_fnc_all) select {_x call AS_mission_fnc_status in ["possible", "available"]};
private _new_possible = call _fnc_allPossibleMissions;
{
    private _signature = [_x call AS_mission_fnc_type, _x call AS_mission_fnc_location];
    if not (_signature in _new_possible) then {
        _x call AS_mission_fnc_remove;
    } else {
        if (_x call AS_mission_fnc_status == "available" and {not (_x call _fnc_isAvailable)}) then {
            [_x, "status", "possible"] call AS_mission_fnc_set;
        };
    };
} forEach _possible;

{
    _x params ["_type", "_location"];
    if not ((format ["%1_%2", _type, _location]) in _possible) then {
        _x call AS_mission_fnc_add;
    };
} forEach _new_possible;

// 2. convert possible missions to available missions up to 5 available+active missions
_possible = (call AS_mission_fnc_all) select {_x call AS_mission_fnc_status in ["possible", "available"]}; // update in-memory list

private _available = (call AS_mission_fnc_all) select {_x call AS_mission_fnc_status in ["available", "active"]};
private _count = count _available;

{
    if (_count >= AS_missions_MAX_MISSIONS) exitWith {};
    // make mission available
    if not (_x in _available) then {
        [_x, "status", "available"] call AS_mission_fnc_set;
        // update in-memory
        _available pushBack _x;
        _count = _count + 1;
    };
} forEach (_possible call AS_fnc_shuffle);
