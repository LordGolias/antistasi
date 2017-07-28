#include "../macros.hpp"
AS_SERVER_ONLY("Missions/outcomes.sqf");

// converts the outcome values to changes in the game state
// of the game.
AS_fnc_mission_execute = {
    params [["_commander_score", 0],
            ["_players_score", 0],
            ["_prestige", [0, 0]],
            ["_resourcesFIA", [0, 0]],
            ["_citySupport", [0, 0, []]],
            ["_changeAAFattack", 0],
            ["_custom", []],
            ["_increaseBusy", ["", 0]]
    ];
    private _increase_players_score = {
        params ["_size", "_position", "_value"];
        {
    		if (isPlayer _x) then {[_value,_x] call playerScoreAdd;};
    	} forEach ([_size,0,_position,"BLUFORSpawn"] call distanceUnits);
    };

    if not (_commander_score == 0) then {
        [_commander_score, AS_commander] call playerScoreAdd;
    };
    if not (_players_score == 0) then {
        _players_score call _increase_players_score;
    };
    if not (_prestige IsEqualTo [0, 0]) then {
        _prestige call prestige;
    };
    if not (_resourcesFIA IsEqualTo [0, 0]) then {
        _resourcesFIA call resourcesFIA;
    };
    if not (_citySupport IsEqualTo [0, 0, []]) then {
        _citySupport call citySupportChange;
    };
    if not (_changeAAFattack == 0) then {
        [1800] call AS_fnc_changeSecondsforAAFattack;
    };
    if not (_increaseBusy IsEqualTo ["", 0]) then {
        _increaseBusy call AS_fnc_location_increaseBusy;
    };
    if not (_custom IsEqualTo []) then {
        {
            (_x select 1) call (_x select 2);
        } forEach _custom;
    };
};

// converts the outcome values into a formatted description
AS_fnc_mission_description = {
    params [["_commander_score", 0],
            ["_players_score", 0],
            ["_prestige", [0, 0]],
            ["_resourcesFIA", [0, 0]],
            ["_citySupport", [0, 0, []]],
            ["_changeAAFattack", 0],
            ["_custom", []],
            ["_increaseBusy", ["", 0]]
    ];
    private _description = [];

    if not (_commander_score == 0) then {
        _description pushBack (format ["Commander's score: %1", _commander_score]);
    };
    if not (_players_score == 0) then {
        _description pushBack (format ["Players's score: %1", _players_score]);
    };
    if not (_prestige IsEqualTo [0, 0]) then {
        if (_prestige select 0 != 0) then {
            _description pushBack (format ["NATO support: %1", _prestige select 0]);
        };
        if (_prestige select 1 != 0) then {
            _description pushBack (format ["CSAT support: %1", _prestige select 1]);
        };
    };
    if not (_resourcesFIA IsEqualTo [0, 0]) then {
        if (_resourcesFIA select 0 != 0) then {
            _description pushBack (format ["Human resources: %1", _resourcesFIA select 0]);
        };
        if (_resourcesFIA select 1 != 0) then {
            _description pushBack (format ["Money: %1", _resourcesFIA select 1]);
        };
    };
    if not (_citySupport IsEqualTo [0, 0, []]) then {
        if (_resourcesFIA select 0 != 0) then {
            _description pushBack (format ["AAF city support: %1", _citySupport select 0]);
        };
        if (_resourcesFIA select 1 != 0) then {
            _description pushBack (format ["FIA city support: %1", _citySupport select 1]);
        };
    };
    if not (_changeAAFattack == 0) then {
        _description pushBack (format ["Disruption in AAF organization: %1", _changeAAFattack/60]);
    };
    if not (_increaseBusy IsEqualTo ["", 0]) then {
        _description pushBack (format ["Disruption in AAF base: %1", _increaseBusy select 1]);
    };
    if not (_custom IsEqualTo []) then {
        _description pushBack (_custom select 0);
    };
    if (_description isEqualTo []) exitWith {
        _description pushBack "No relevant information about mission outcome";
    };
    private _result = "";
    {
        _result = _x + "<br/>";
    } forEach _description;
    _result
};


// returns a list of values that are ingested by AS_fnc_mission_execute/AS_fnc_mission_description
// that contain complete information about how a successful mission changed the game state
AS_fnc_mission_success_get = {
    params ["_mission", "_args"];
    private _location = _mission call AS_fnc_mission_location;
    private _position = _location call AS_fnc_location_position;
    private _size = _location call AS_fnc_location_size;
    private _type = _mission call AS_fnc_mission_type;

    if (_type == "kill_traitor") exitWith {
        [5, [_size, _position, 10], [0, -2]]
    };
    if (_type == "kill_officer") exitWith {
        [5, [_size, _position, 10], [0, 3], [0, 200], [0, 0, _position], 30*60, [], [_location, 30]]
    };
    if (_type == "kill_specops") exitWith {
        [5, [_size, _position, 10], [0, 3], [0, 200], [0, 5, _position], 10*60]
    };
    if (_type == "aaf_attack_hq") exitWith {
        [0, [500, _position, 10], [0, 3], [0, 300]]
    };
    if (_type == "black_market") exitWith {
        [0, 0, [0, 0], [0, 0], [0, 0, []], 0,
            [["Temporary access to the black market", {}]]
        ]
    };
    if (_type == "aaf_attack") exitWith {
        [5, [500, _position, 10], [0, 0], [0, 0], [0, 0, []], 2700]
    };
    if (_type == "conquer") exitWith {
        [10, [_size, _position, 10], [0, 0], [0, 200], [-5, 0, _position], 10*60,
            [["Gain location", {}]]
        ]
    };
    if (_type in ["convoy_money", "convoy_ammo", "convoy_supplies"]) exitWith {
        _args params ["_vehPosition"];
        [5, [500, _vehPosition, 10], [-5, 0], [0, 5000], [10, -20, _position], -20*60]
    };
    if (_type == "convoy_armor") exitWith {
        _args params ["_vehPosition"];
        [5, [500, _vehPosition, 10], [5, 0], [0, 0], [0, 5, _position], 45*60]
    };
    if (_type == "convoy_hvt") exitWith {
        _args params ["_vehPosition"];
        [5, [500, _vehPosition, 10], [10, 0], [0, 0], [0, 5, _position], 30*60]
    };
    if (_type == "convoy_prisoners") exitWith {
        _args params ["_vehPosition", ["_hr", 0]];
        [round (_hr/2), [500, _vehPosition, _hr], [_hr, 0], [_hr, 0],
            [["Variable number of resources, prestige and city support", {}]]
        ]
    };
    if (_type == "csat_attack") exitWith {
        [10, [500, _position, 10], [10, 0], [0, 0], [-5, 20, _position], 120*60, [
            ["AAF lose 5 support in all cities", {[-5,0,_x] call citySupportChange} forEach (call AS_fnc_location_cities)]
        ]]
    };
    if (_type == "defend_camp") exitWith {
        [5, [500, _position, 10], [0, 3], [0, 300]]
    };
    if (_type == "destroy_antenna") exitWith {
        _args params ["_pos"];
        [5, [500, _pos, 10], [5, -5], [0, 0], [0, 0, []], 10*60]
    };
    if (_type == "destroy_helicopter") exitWith {
        _args params ["_pos"];
        [5, [500, _pos, 10], [5, 0], [0, 300], [0, 0, []], 20*60]
    };
    if (_type == "destroy_vehicle") exitWith {
        _args params ["_pos"];
        [5, [500, _pos, 10], [2, 0], [0, 300], [0, 5, _position], 20*60]
    };
    if (_type == "steal_ammo") exitWith {
        _args params ["_pos"];
        [5, [500, _pos, 10], [2, 0], [0, 300], [0, 0, []], 20*60]
    };
    if (_type == "steal_bank") exitWith {
        _args params ["_pos"];
        [5, [500, _pos, 10], [-2, 0], [0, 5000], [0, -5, _position], 10*60]
    };
    if (_type == "send_meds") exitWith {
        [5, [500, _position, 10], [5, 0], [0, 0], [0, 15, _position], 10*60, [
            ["Probable mine pack", {
                if (random 10 < 8) then {
            		for "_i" from 1 to 3 do {
            			private _item = (selectRandom AAFmines) call AS_fnc_mineMag;
            			private _num = 2 + (floor random 5);
            			cajaVeh addMagazineCargoGlobal [_item, _num];
            		};
            		[[petros,"globalChat","Someone delivered mines to our camp [repair box]"],"commsMP"] call BIS_fnc_MP;
            	};
            }, []]]]
    };
    if (_type == "help_meds") exitWith {
        [5, [500, _position, 10], [5, 0], [0, 0], [0, 15, _position]]
    };
    if (_type == "broadcast") exitWith {
        _args params ["_prestige"];
        [5, [500, _position, 10], [0, 0], [0, 0], [0, 0, []], 0, ["", 0], [
            ["City support per minute spent", {
                params ["_prestige", "_location"];
                [0, _prestige, _location] remoteExec ["citySupportChange",2];
            }, [_prestige, _location]]]
        ]
    };
    if (_type == "pamphlets") exitWith {
        [5, [500, _position, 10], [5, 0], [0, 0], [-15, 5, _position]]
    };
    if (_type == "repair_antenna") exitWith {
        [5, [500, _position, 10], [2, 0], [0, 0], [0, 0, []], 20*60,
            [["AAF antenna continues disabled", {}]]
        ]
    };
    if (_type == "rescue_prisioners") exitWith {
        _args params [["_hr", 0]];
        [round (_hr/2), [500, getMarkerPos "FIA_HQ", _hr], [_hr, 0], [_hr, 0],
            [["Variable number of resources, prestige and city support", {}]]
        ]
    };
    if (_type == "rescue_refugees") exitWith {
        _args params [["_hr", 0]];
        [round (_hr/2), [500, getMarkerPos "FIA_HQ", _hr], [_hr, 0], [_hr, 0],
            [["Variable number of resources, prestige and city support", {}]]
        ]
    };
    []
};


AS_fnc_mission_fail_get = {
    params ["_mission", "_args"];
    private _location = _mission call AS_fnc_mission_location;
    private _position = _location call AS_fnc_location_position;
    private _type = _mission call AS_fnc_mission_type;

    if (_type == "kill_traitor") exitWith {
        [-20, 0, [0, 0], [-2, -2000], [0, 0, []], -10*60]
    };
    if (_type == "kill_officer") exitWith {
        [-20, 0, [0, 0], [0, 0], [5, 0, _position], -10*60, [], [_location,-30]]
    };
    if (_type == "kill_specops") exitWith {
        [-20, 0, [0, 0], [0, 0], [5, 0, _position], -10*60]
    };
    if (_type == "aaf_attack_hq") exitWith {
        [-50, [500, _position, 10], [0, 3], [0, 5*60]]
    };
    if (_type == "black_market") exitWith {
        [-20, 0, [-5, 0]]
    };
    if (_type == "aaf_attack") exitWith {
        [-50, 0, [-2, 0], [0, -1000], [0, 0, []], 2700]
    };
    if (_type == "conquer") exitWith {
        [-10, 0, [0, 0], [0, 0], [5, 0, _position], -10*60]
    };
    if (_type == "convoy_supplies") exitWith {
        [-20, 0, [-5, 0], [0, 0], [10, -20, _position], -10*60]
    };
    if (_type == "convoy_money") exitWith {
        [-20, 0, [-5, 0], [0, 0], [10, -20, _position], -10*60, [["AAF gains money", {[5000] call resourcesAAF}]]]
    };
    if (_type == "convoy_ammo") exitWith {
        [-20, 0, [-5, 0], [0, 0], [0, 0, []], -10*60, [["AAF gains money", {[10000] call resourcesAAF}]]]
    };
    if (_type == "convoy_armor") exitWith {
        [-20, 0, [0, 0], [0, 0], [0, 0, []], -20*60]
    };
    if (_type == "convoy_hvt") exitWith {
        [-20, 0, [0, 0], [0, 0], [0, 0, []], -20*60]
    };
    if (_type == "convoy_prisoners") exitWith {
        [-20, 0, [0, 0], [0, 0], [0, -10, _position], -10*60]
    };
    if (_type == "csat_attack") exitWith {
        [-100, 0, [0, 0], [0, 0], [-10, -20, _position], 120*60, [
            ["City is destroyed", {
                params ["_location"];
                AS_Pset("destroyedLocations", AS_P("destroyedLocations") + [_location]);
            	if (count AS_P("destroyedLocations") > 7) then {
            		 ["destroyedCities",false,true] remoteExec ["BIS_fnc_endMission",0];
            	};
            }, [_location]],
            ["FIA loses 5 support in all cities", {[0,-5,_x] call citySupportChange} forEach (call AS_fnc_location_cities)]
        ]]
    };
    if (_type in ["defend_camp", "destroy_antenna", "destroy_helicopter", "destroy_vehicle", "steal_ammo", "steal_bank"]) exitWith {
        [-20, 0, [0, 0], [0, 0], [0, 0, []], -10*60]
    };
    if (_type in ["send_meds", "help_meds"]) exitWith {
        [-20, 0, [0, 0], [0, 0], [5,-5,_position]]
    };
    if (_type in ["nato_armor", "nato_ammo", "nato_artillery", "nato_uav", "nato_roadblock", "nato_qrf", "nato_cas"]) exitWith {
        [-20, 0, [-10, 0]]
    };
    if (_type == "broadcast") exitWith {
        [-20, 0, [0, 0], [0, 0], [5,-5,_position]]
    };
    if (_type == "pamphlets") exitWith {
        [-10, 0, [0, 0], [0, 0], [5,0,_position]]
    };
    if (_type == "repair_antenna") exitWith {
        _args params ["_antennaPos"];
        [-20, 0, [0, 0], [0, 0], [0, 0, []], -10*60,
            [["AAF antenna is repaired", {
                params ["_antennaPos"];
                antenasMuertas = antenasMuertas - [_antennaPos];
            	antenas = antenas + [_antennaPos];
            	publicVariable "antenas";
            	publicVariable "antenasMuertas";
                private _antenna = nearestBuilding _antennaPos;
                _antenna setDammage 0;
            	_antenna addEventHandler ["Killed", AS_fnc_antennaKilledEH];
            }, [_antennaPos]]]
        ];
    };
    if (_type == "rescue_prisioners") exitWith {
        _args params [["_dead", 0]];
        [-20, 0, [-_dead, 0], [0, 0], [0, 0, []], [["Variable lost of NATO support", {}]]]
    };
    if (_type == "rescue_refugees") exitWith {
        _args params [["_dead", 0]];
        [-20, 0, [-_dead, 0], [0, 0], [0, -15, _position], [["Variable lost of NATO support", {}]]]
    };
    [-20]
};


AS_fnc_mission_success = {
    (_this call AS_fnc_mission_success_get) call AS_fnc_mission_execute;
    ["mis"] call fnc_BE_XP;
};


AS_fnc_mission_fail = {
    (_this call AS_fnc_mission_fail_get) call AS_fnc_mission_execute;
};
