/*
This is a API to handle missions: a set of tasks that the player chooses to initiate
that ends with different outcomes.
Tasks initialize resources (e.g. soldiers,vehicles,markers) and own them.
Therefore, it is important that these resources are accessible to be destroyed.

This API handles:
* possible missions
* available missions
* ongoing missions
*/

AS_fnc_missions = {
    "mission" call AS_fnc_objects
};

AS_fnc_mission_status = {
    [_this, "status"] call AS_fnc_object_get
};

AS_fnc_mission_signature = {
    [_this, "signature"] call AS_fnc_object_get
};


AS_allMissionTypes = [
    "pamphlets", "broadcast","destroy_vehicle", "destroy_helicoper", "destroy_antena",
    "conquer_powerplant", "conquer_outpost", "conquer_outpostAA",
    "convoy_ammo", "convoy_money", "convoy_supplies", "convoy_armor",
    "rescue_prisioners", "rescue_refugees",
    "steal_ammo", "help_meds", "send_meds", "rob_bank", "kill_specops"
];


AS_fnc_possibleMissions = {
    // Returns a list of possible missions for the FIA_HQ location and given mission type
    params ["_missionType"];

    private _posbase = getMarkerPos "FIA_HQ";

    if (_missionType in ["pamphlets", "broadcast"]) exitWith {
        private _locations = [["city"], "AAF"] call AS_fnc_location_TS;

        private _possible = [];
        {
            if (_missionType == "pamphlets" and [_x, "AAFsupport"] call AS_fnc_location_get > 0) then {
				_possible pushBack [_missionType, _x];
			};
			if (_missionType == "broadcast" and [_x, "FIAsupport"] call AS_fnc_location_get > 10) then {
				_possible pushBack [_missionType, _x];
			};
		} forEach (_locations select {((_x call AS_fnc_location_position) distance _posbase < 4000)});
        _possible
    };
    if (_missionType in ["kill_specops"]) exitWith {
        private _locations = [["city"], "AAF"] call AS_fnc_location_TS;

        private _possible = [];
    	{
    		_possible pushBack [_missionType, _x];
    	} forEach (_locations select {((_x call AS_fnc_location_position) distance _posbase < 4000) and !(_x call AS_fnc_location_spawned)});
        _possible
    };
    if (_missionType in ["convoy_ammo", "convoy_money", "convoy_supplies", "convoy_armor"]) exitWith {
        private _locations = [["city"], "AAF"] call AS_fnc_location_TS;

        private _possible = [];
    	{
    		private _pos = _x call AS_fnc_location_position;
    		private _base = [_pos] call findBasesForConvoy;
    		if ((_pos distance _posbase < 4000) and (_base != "")) then {
    			_possible pushBack [_missionType, _x, _base];
    		}
    	} forEach _locations;
        _possible
    };
    // missions for any city
    if (_missionType in ["send_meds", "rescue_refugees"]) exitWith {
        private _locations = [["city"], "AAF"] call AS_fnc_location_TS;

        private _possible = [];
    	{
    		_possible pushBack [_missionType, _x];
    	} forEach (_locations select {((_x call AS_fnc_location_position) distance _posbase < 4000)});
        _possible
    };
    if (_missionType in [ "help_meds", "rob_bank", "send_meds"]) exitWith {
        private _locations = [];
        if (_missionType == "send_meds") then {
            _locations = [["city"], "AAF"] call AS_fnc_location_TS;
        };
        if (_missionType == "steal_ammo") then {
            _locations = [["outpost", "base"], "AAF"] call AS_fnc_location_TS;
        };

        private _possible = [];
    	{
    		_possible pushBack [_missionType, _x];
    	} forEach (_locations select {((_x call AS_fnc_location_position) distance _posbase < 4000)});
        _possible
    };
    []
};


AS_fnc_allPossibleMissions = {

    private _possible = [];
    {
        _possible append (_x call AS_fnc_possibleMissions);
    } forEach allMissionTypes;
    _possible
};


AS_fnc_updateAvailableMissions = {

    private _possible = call AS_fnc_allPossibleMissions;
    private _available = call AS_fnc_allAvailableMissions;
    {
        if not (_x call AS_fnc_mission_signature in _possible) then {
            _x call AS_fnc_object_remove;
        };
    } forEach _available;

    {
        if not (_x call AS_fnc_mission_signature in _available) then {
            [_x, "mission", True] call AS_fnc_object_add;
        };
    } forEach _possible;
};


AS_fnc_allAvailableMissions = {
    (call AS_fnc_missions) select {_x call AS_fnc_mission_status == "available"}
};
