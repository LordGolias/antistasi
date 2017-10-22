// returns a list of values that are ingested by AS_mission_fnc_execute/AS_mission_fnc_description
// that contain complete information about how a successful mission changed the game state
params ["_mission", ["_args", []]];
private _location = _mission call AS_mission_fnc_location;
private _position = _location call AS_location_fnc_position;
private _size = _location call AS_location_fnc_size;
private _type = _mission call AS_mission_fnc_type;

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
    _args params [["_vehPosition", [0,0,0]]];
    [5, [500, _vehPosition, 10], [-5, 0], [0, 5000], [10, -20, _position], -20*60]
};
if (_type == "convoy_armor") exitWith {
    _args params [["_vehPosition", [0,0,0]]];
    [5, [500, _vehPosition, 10], [5, 0], [0, 0], [0, 5, _position], 45*60]
};
if (_type == "convoy_hvt") exitWith {
    _args params [["_vehPosition", [0,0,0]]];
    [5, [500, _vehPosition, 10], [10, 0], [0, 0], [0, 5, _position], 30*60]
};
if (_type == "convoy_prisoners") exitWith {
    _args params [["_vehPosition", [0,0,0]], ["_hr", 0]];
    [round (_hr/2), [500, _vehPosition, _hr], [_hr, 0], [_hr, 0],
        [["Variable number of resources, foreign support and city support", {}]]
    ]
};
if (_type == "defend_city") exitWith {
    [10, [500, _position, 10], [10, 0], [0, 0], [-5, 20, _position], 120*60, [
        [(["AAF", "name"] call AS_fnc_getEntity) + " loses 5 support in all cities", {[-5,0,_x] call AS_fnc_changeCitySupport} forEach (call AS_location_fnc_cities)]
    ]]
};
if (_type == "defend_camp") exitWith {
    [5, [500, _position, 10], [0, 3], [0, 300]]
};
if (_type == "destroy_antenna") exitWith {
    _args params [["_pos", [0,0,0]]];
    [5, [500, _pos, 10], [5, -5], [0, 0], [0, 0, []], 10*60]
};
if (_type == "destroy_helicopter") exitWith {
    _args params [["_pos", [0,0,0]]];
    [5, [500, _pos, 10], [5, 0], [0, 300], [0, 0, []], 20*60]
};
if (_type == "destroy_vehicle") exitWith {
    _args params [["_pos", [0,0,0]]];
    [5, [500, _pos, 10], [2, 0], [0, 300], [0, 5, _position], 20*60]
};
if (_type == "steal_ammo") exitWith {
    _args params [["_pos", [0,0,0]]];
    [5, [500, _pos, 10], [2, 0], [0, 300], [0, 0, []], 20*60]
};
if (_type == "rob_bank") exitWith {
    _args params [["_pos", [0,0,0]]];
    [5, [500, _pos, 10], [-2, 0], [0, 5000], [0, -5, _position], 10*60]
};
if (_type == "send_meds") exitWith {
    [5, [500, _position, 10], [5, 0], [0, 0], [0, 15, _position], 10*60, [
        ["Probable mine pack", {
            if (random 10 < 8) then {
                private _mines = (["AAF", "ap_mines"] call AS_fnc_getEntity) + (["AAF", "at_mines"] call AS_fnc_getEntity);
                for "_i" from 1 to 3 do {
                    private _item = (selectRandom _mines) call AS_fnc_mineMag;
                    private _num = 2 + (floor random 5);
                    cajaVeh addMagazineCargoGlobal [_item, _num];
                };
                [[petros,"globalChat","Someone delivered mines to our camp [repair box]"],"AS_fnc_localCommunication"] call BIS_fnc_MP;
            };
        }, []]]]
};
if (_type == "help_meds") exitWith {
    [5, [500, _position, 10], [5, 0], [0, 0], [0, 15, _position]]
};
if (_type == "broadcast") exitWith {
    _args params [["_prestige",0]];
    [5, [500, _position, 10], [0, 0], [0, 0], [0, 0, []], 0, [
        ["City support per minute spent", {
            params ["_prestige", "_location"];
            [0, _prestige, _location] remoteExec ["AS_fnc_changeCitySupport",2];
        }, [_prestige, _location]]]
    ]
};
if (_type == "pamphlets") exitWith {
    [5, [500, _position, 10], [5, 0], [0, 0], [-15, 5, _position]]
};
if (_type == "repair_antenna") exitWith {
    [5, [500, _position, 10], [2, 0], [0, 0], [0, 0, []], 20*60,
        [[(["AAF", "name"] call AS_fnc_getEntity) + " antenna continues disabled", {}]]
    ]
};
if (_type == "rescue_prisioners") exitWith {
    _args params [["_hr", 0]];
    [round (_hr/2), [500, getMarkerPos "FIA_HQ", _hr], [_hr, 0], [_hr, 0],  [0, 0, []], 0,
        [["Variable number of resources, foreign support and city support", {}]]
    ]
};
if (_type == "rescue_refugees") exitWith {
    _args params [["_hr", 0]];
    [round (_hr/2), [500, getMarkerPos "FIA_HQ", _hr], [_hr, 0], [_hr, 0],  [0, 0, []], 0,
        [["Variable number of resources, foreign support and city support", {}]]
    ]
};
[]
